InternalPlayer = {}
InternalPlayers = {}

InternalPlayer.CreatePlayer = function(src, dbdata) -- no work in InternalPlayers should be fixed soon when framework is working properly
    local self = {}
    self.source = src
    self.license = GetPlayerIdentifierByType(self.source, "license")
    self.name = GetPlayerName(self.source)
    self.cid = dbdata.cid or InternalPlayer.GenerateCid()
    self.permissiongroup = InternalPermissions.GetPermissionGroup(self.source)
    print("PERMS: "..self.permission, self.permissiongroup)
    self.slot = dbdata.slot or 1 -- Default slot

    self.charinfo = dbdata.charinfo or {}
    self.charinfo.firstname = self.charinfo.firstname or "John" -- Default name
    self.charinfo.lastname = self.charinfo.lastname or "Doe" -- Default name
    self.charinfo.fullname = ("%s %s"):format(self.charinfo.firstname, self.charinfo.lastname)
    self.charinfo.birthdate = self.charinfo.birthdate or '0000-00-00'
    self.charinfo.gender = self.charinfo.gender or 1 -- 1 = Male, 0 = Female
    self.charinfo.nationality = self.charinfo.nationality
    self.charinfo.phone = self.charinfo.phone or InternalPlayer.CreatePhoneNumber()
    self.charinfo.account = self.charinfo.account or InternalPlayer.CreateAccountNumber()

    self.skin = dbdata.skin or {}

    self.job = dbdata.job or {}
    self.job.name = self.job.name or "unemployed" -- Default job
    self.job.rank = tonumber(self.job.rank) or 0 -- Default rank
    self.job.duty = false

    self.gang = dbdata.gang or {}
    self.gang.name = self.gang.name or "none" -- Default gang
    self.gang.rank = tonumber(self.gang.rank) or 0 -- Default rank

    self.money = dbdata.money or {}
    self.money.cash = tonumber(self.money.cash) or InternalConfig.Player.StartingCash
    self.money.bank = tonumber(self.money.bank) or InternalConfig.Player.StartingBank

    self.metadata = dbdata.metadata
    if self.metadata == nil then self.metadata = {} end
    if not self.metadata.thirst then self.metadata.thirst = 100 end
    if not self.metadata.hunger then self.metadata.hunger = 100 end
    if not self.metadata.stress then self.metadata.stress = 0 end
    if not self.metadata.health then self.metadata.health = 100 end
    if not self.metadata.armour then self.metadata.armour = 100 end
    if not self.metadata.stamina then self.metadata.stamina = 100 end

    self.position = dbdata.position or InternalConfig.Player.DefaultPosition

    -- Functions
    self.SetMoney = function(type, amount)
        if self.money[type] then
            self.money[type] = amount
            if type == "cash" then
                TriggerEvent("ps-framework:OnCashChanged", self.source, self.money[type]) -- for inv
            end
            InternalPlayer.UpdateStateBags(self.source)
        end
    end

    self.GetMoney = function(type)
        if self.money[type] then
            local type = type:lower()
            InternalPlayer.UpdateStateBags(self.source)
            return self.money[type]
        end
        return false
    end

    self.AddMoney = function(type, amount)
        if self.money[type] then
            self.money[type] = self.money[type] + tonumber(amount)
            TriggerClientEvent("hud:client:OnMoneyChange", self.source, type, amount, false) -- hud money change
            if type == "cash" then
                TriggerEvent("ps-framework:OnCashChanged", self.source, self.money[type]) -- for inv
            end
            InternalPlayer.UpdateStateBags(self.source)
        end
    end

    self.RemoveMoney = function(type, amount)
        if self.money[type] then
            self.money[type] = self.money[type] - tonumber(amount)
            TriggerClientEvent("hud:client:OnMoneyChange", self.source, type, amount, true) -- hud money change
            if type == "cash" then
                TriggerEvent("ps-framework:OnCashChanged", self.source, self.money[type]) -- for inv
            end
            InternalPlayer.UpdateStateBags(self.source)
        end
    end

    self.SetJob = function(job, rank)
        self.job.name = job
        self.job.rank = tonumber(rank)
        InternalPlayer.UpdateStateBags(self.source) -- Not a huge fan of repeating this in every setter function. Not sure how to refactor yet.
    end

    self.SetJobDuty = function(jobDuty)
        self.job.duty = jobDuty
        InternalPlayer.UpdateStateBags(self.source)
    end

    self.SetGang = function(gang, rank)
        self.gang.name = gang
        self.gang.rank = tonumber(rank)
        InternalPlayer.UpdateStateBags(self.source)
    end

    self.SetMetaData = function(key, value)
        self.metadata[key] = value
        InternalPlayer.UpdateStateBags(self.source)
    end

    self.SetSkinData = function(data) 
        self.skin = data
        InternalPlayer.UpdateStateBags(self.source)
    end

    self.Save = function()
        InternalPlayer.Save(self.source)
    end

    self.UpdateStateBags = function()
        InternalPlayer.UpdateStateBags(self.source)
    end

    return self
end
exports("CreatePlayer", InternalPlayer.CreatePlayer)

InternalPlayer.UpdateStateBags = function(src)
    if InternalPlayers[src] then
        local PlayerInfo = InternalPlayers[src]
        Player(src).state:set("isLoggedIn", true, true)

        for key, value in pairs(PlayerInfo) do
            if type(value) ~= "function" then -- Only set state for non-functions. We don't need to propagate functions to the client.
                Player(src).state:set(key, value, true)
            end
        end
    end
end
exports('UpdateStateBags', InternalPlayer.UpdateStateBags)

InternalPlayer.GetPlayer = function(src)
    local playerId = tonumber(src)
    if InternalPlayers[playerId] then
        return InternalPlayers[playerId]
    end
    return nil
end
exports("GetPlayer", InternalPlayer.GetPlayer)

InternalPlayer.GetPlayers = function()
    local sources = {}
    for k in pairs(InternalPlayers) do
        sources[#sources+1] = k
    end
    return sources
end
exports("GetPlayers", InternalPlayer.GetPlayers)

InternalPlayer.GetPlayerByCid = function(cid)
    for _,player in pairs(InternalPlayers) do
        if player.cid == cid then
            return player
        end
    end
    return nil
end
exports("GetPlayerByCid", InternalPlayer.GetPlayerByCid)

InternalPlayer.GetCharacters = function(src)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")
    local result = MySQL.Sync.fetchAll('SELECT * FROM characters WHERE license = ? ORDER BY slot', { license })
    if result then
        local characterList = {}
        for k,v in pairs(result) do
            characterList[k] = v
        end
        return characterList
    end
    return {}
end
exports("GetCharacters", InternalPlayer.GetCharacters)

InternalPlayer.SelectCharacter = function(src, cid)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")
    local result = MySQL.prepare.await('SELECT * FROM characters WHERE license = ? AND cid = ?', { license, cid })
    if not result then
        return print("[SLOTHVILLE] Character not found. (ps-framework server error code 1)")
    end

    local dbdata = result
    dbdata.charinfo = json.decode(dbdata.charinfo)
    dbdata.skin = json.decode(dbdata.skin)
    dbdata.job = json.decode(dbdata.job)
    dbdata.gang = json.decode(dbdata.gang)
    dbdata.money = json.decode(dbdata.money)
    dbdata.metadata = json.decode(dbdata.metadata)
    dbdata.position = json.decode(dbdata.position)

    InternalPlayers[src] = InternalPlayer.CreatePlayer(src, dbdata)

    -- InternalLogs.AddLog("framework", 
    --     ("Player %s (%s) has logged into their character %s %s (%s)"):format(InternalPlayers[src].name, src, dbdata.charinfo.firstname, dbdata.charinfo.lastname, dbdata.cid)
    -- )
    
    ---@cast src number

    InternalPlayer.UpdateStateBags(src)
    TriggerClientEvent("ps-multi:client:CharacterSelected", src, dbdata, false) -- not coded but will pass needed values for startup
    TriggerClientEvent("ps-framework:PlayerLoaded", src)
    TriggerEvent("ps-framework:PlayerLoaded", src, InternalPlayers[src])
end
exports("SelectCharacter", InternalPlayer.SelectCharacter)

InternalPlayer.CreateCharacter = function(src, info, slot)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")

    local NewCharacterData = {}
    NewCharacterData.charinfo = info
    NewCharacterData.slot = slot
    InternalPlayers[src] = InternalPlayer.CreatePlayer(src, NewCharacterData)

    local PlayerInfo = InternalPlayers[src]
    
    MySQL.execute('INSERT INTO characters (`license`, `cid`, `slot`, `charinfo`, `skin`, `job`, `gang`, `money`, `metadata`, `position`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
        license,
        PlayerInfo.cid,
        slot,
        json.encode(PlayerInfo.charinfo),
        json.encode(PlayerInfo.skin),
        json.encode(PlayerInfo.job),
        json.encode(PlayerInfo.gang),
        json.encode(PlayerInfo.money),
        json.encode(PlayerInfo.metadata),
        json.encode(PlayerInfo.position)
    })

    -- InternalLogs.AddLog("framework", 
    --     ("Player %s (%s) has created character %s %s (%s)"):format(PlayerInfo.name, src, info.firstname, info.lastname, PlayerInfo.cid)
    -- )

    InternalPlayer.UpdateStateBags(src)
    PlayerInfo.position = InternalConfig.DefaultPosition

    ---@cast src number
    TriggerClientEvent("ps-multi:client:CharacterSelected", src, PlayerInfo, true) -- not coded but will pass needed values for startup

    TriggerClientEvent("clothing:newOpenMenu", src) -- Open Clothing Menu for new Player
end
exports("CreateCharacter", InternalPlayer.CreateCharacter)

InternalPlayer.DeleteCharacter = function(src, cid)
    ---@cast src string
    local license = GetPlayerIdentifierByType(src, "license")
    MySQL.execute('DELETE FROM characters WHERE license = ? AND cid = ?', { license, cid })
    -- InternalLogs.AddLog("framework", 
    --     ("Player %s (%s) has deleted character ID %s"):format(GetPlayerName(src), src, cid)
    -- )
end
exports("DeleteCharacter", InternalPlayer.DeleteCharacter)

InternalPlayer.Save = function(src)
    if InternalPlayers[src] then
        local PlayerInfo = InternalPlayers[src]
        MySQL.execute('UPDATE characters SET charinfo = ?, skin = ?, job = ?, gang = ?, money = ?, metadata = ?, position = ? WHERE license = ? AND cid = ?', {
            json.encode(PlayerInfo.charinfo),
            json.encode(PlayerInfo.skin),
            json.encode(PlayerInfo.job),
            json.encode(PlayerInfo.gang),
            json.encode(PlayerInfo.money),
            json.encode(PlayerInfo.metadata),
            json.encode(PlayerInfo.position),
            PlayerInfo.license,
            PlayerInfo.cid
        })
    end
end
exports("Save", InternalPlayer.Save)

InternalPlayer.Logout = function(src)
    if InternalPlayers[src] then
        InternalPlayer.Save(src)
        InternalPlayers[src] = nil
        Player(src).state:set("isLoggedIn", false, true)
        -- Event thing
        TriggerEvent("ps-framework:UnloadPlayer", src)
        TriggerClientEvent("ps-framework:UnloadPlayer", src)
    end
end
exports("Logout", InternalPlayer.Logout)

InternalPlayer.GenerateCid = function()
    local Length = InternalConfig.CidLength
    local GoodCidFound = false
    local cid = ""
    local charset = {}  do -- [0-9A-Z]
        for c = 48, 57  do table.insert(charset, string.char(c)) end
        for c = 97, 122 do table.insert(charset, string.char(c)) end
    end
    while not GoodCidFound do
        cid = ""
        math.randomseed(os.time())
        for i = 1, Length do
            cid = cid .. "" .. charset[math.random(1, #charset)]
        end

        cid = string.upper(cid) -- Make sure it's uppercase. I could have changed the charset, but meh.

        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE cid = ?', { cid })
        if result == 0 then
            GoodCidFound = true
        end
    end
    return cid
end
exports("GenerateCid", InternalPlayer.GenerateCid)

InternalPlayer.CreateAccountNumber = function()
    local UniqueFound = false
    local AccountNumber = nil
    while not UniqueFound do
        AccountNumber = math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9) .. math.random(1,9)
        local query = '%' .. AccountNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return AccountNumber
end
exports("CreateAccountNumber", InternalPlayer.CreateAccountNumber)

InternalPlayer.CreatePhoneNumber = function()
    local UniqueFound = false
    local PhoneNumber = nil
    while not UniqueFound do
        PhoneNumber = math.random(100,999) .. math.random(1000000,9999999)
        local query = '%' .. PhoneNumber .. '%'
        local result = MySQL.prepare.await('SELECT COUNT(*) as count FROM characters WHERE charinfo LIKE ?', { query })
        if result == 0 then
            UniqueFound = true
        end
    end
    return PhoneNumber
end
exports("CreatePhoneNumber", InternalPlayer.CreatePhoneNumber)
