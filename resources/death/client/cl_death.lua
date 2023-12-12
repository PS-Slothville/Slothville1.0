-- Varaiables
-- local isViolent = false
-- local isMinor = false

local isDead = false
local canRespawn = false

exports("IsDead", function()
    return isDead
end)

local HeldTime = 0

local DamageTaken = {
    hash = "",
    source = -1,
    melee = false,
}


-- Big important?
CreateThread(function()
    local isPressed = false
    exports['ps-utils']:CreateKeybind("respawn", true, function()
        if isDead and canRespawn then
            isPressed = true
            while isPressed do 
                Wait(Config.HoldTime * 1000)
                if HeldTime < 5 then 
                    HeldTime = HeldTime + 1
                    print(HeldTime)
                end
            end
        end
    end, function()
        if isDead and canRespawn then
            isPressed = false
            HeldTime = 0
        end
    end, "Respawn", "For when you die")
end)


-- Handlers
AddEventHandler("DamageEvents:EntityDamaged", function(victim, attacker, pWeapon, isMelee)
    local playerPed = PlayerPedId()

    if victim ~= playerPed then
      return
    end

    DamageTaken = {
        hash = pWeapon,
        source = attacker,
        melee = isMelee
    }
end)

-- Functions
local function IsViolent(deathHash)
    if Config.InjuryList[deathHash] and Config.InjuryList[deathHash].violent then
        return true
    end
    return false
end

local function IsMinor(deathHash)
    if Config.InjuryList[deathHash] and Config.InjuryList[deathHash].minor then
        return true
    end
    return false
end

local function Draw2DText(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local function IsDeadVehAnimPlaying()
    if IsEntityPlayingAnim(PlayerPedId(), Config.CarAnim.dict, Config.CarAnim.anim, 1) then
        return true
    else
        return false
    end
end

local function IsDeadAnimPlaying()
    if IsEntityPlayingAnim(PlayerPedId(), Config.DeadAnim.dict, Config.DeadAnim.anim, 1) or IsEntityPlayingAnim(PlayerPedId(), Config.MinorAnim.dict, Config.MinorAnim.anim, 1) then
        return true
    else
        return false
    end
end

local function IsPedInAnySeat()
    local ply = PlayerPedId()
    local intrunk = false
    if IsPedSittingInAnyVehicle(ply) or intrunk then
      return true
    else
      return false
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while(not HasAnimDictLoaded(dict)) do
        Citizen.Wait(0)
    end
end

local function ReviveAnim()
    ClearPedSecondaryTask(PlayerPedId())
    LoadAnimDict("random@crash_rescue@help_victim_up" ) 
    TaskPlayAnim(PlayerPedId(), "random@crash_rescue@help_victim_up", "helping_victim_to_feet_victim", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    SetCurrentPedWeapon(PlayerPedId(),2725352035,true)
    Wait(3000)
    ClearPedSecondaryTask(PlayerPedId())
end

local function RequestRevive()
    if IsPedInAnySeat() then
        return
    end
    if isDead or IsDeadAnimPlaying() or IsDeadVehAnimPlaying() then
        isDead = false
        local ped = PlayerPedId()
        SetEntityInvincible(ped, false)
        SetPedMaxHealth(ped, 200)
        SetEntityHealth(ped, GetEntityMaxHealth(ped))
        SetPlayerMaxArmour(PlayerId(), 60)
        ClearPedBloodDamage(ped)
        local plyPos = GetEntityCoords(ped,  true)
        local heading = GetEntityHeading(ped)
        ClearPedTasksImmediately(ped)
        NetworkResurrectLocalPlayer(plyPos, heading, false, false, false)
        Citizen.Wait(500)
        RemoveAllPedWeapons(ped,true)
        ReviveAnim()
    end
end

local function ClosestHospital()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local min = 9999
    local foundName = 'Pillbox Hospital'
    local foundCoords = hospitals[foundName]
    for name,hospital in ipairs(hospitals) do
        local dist = #(hospital - plyCoords)
        if dist < min then
            min = dist
            foundCoords = hospital
            foundName = name
        end
    end
    return foundCoords, foundName
end

local function ReleaseBody(dropItems)
    local player = PlayerPedId()
    FreezeEntityPosition(player, false)
    RemoveAllPedWeapons(player)
    DoScreenFadeOut(3000)
    Wait(3000)
    if dropItems then
        lib.notify({
            title = "Local EMS",
            description = "We could not recover your pockets",
            type = 'inform',
        })
        TriggerServerEvent("death:LoseInvItems")
    end
    SetCurrentPedWeapon(player, 2725352035, true)
    ClearPedTasksImmediately(player)
    Wait(2000)
    SetEntityInvincible(player, false)
    ClearPedBloodDamage(player)
    isDead = false
    local coords,hospital = ClosestHospital()
    SetEntityCoords(player, coords)
    Wait(2000)
    print("DEBUG LOL HOSPITAL ISNT MADE YET")
    RequestRevive()
    DoScreenFadeIn(3000)
end

local function StartDeath(isViolet, isMinor, KeepItems)
    local deadTime = (isMinor) and Config.PoliceRespawnTime or Config.RespawnTime
    local respawnComplete = false

    CreateThread(function()
        deathText = isMinor and ("Unconscious: ~g~ %d~w~ seconds remaining") or ("Dead: ~r~ %d ~w~ seconds remaining")
        respawnText = isMinor and ("~W~HOLD ~g~E ~w~ (%d) ~w~ TO ~g~GET UP~w~") or ("~w~HOLD ~g~E ~w~(%d) ~w~TO ~g~RESPAWN ~w~OR WAIT FOR ~g~EMS")
        while isDead do
            Citizen.Wait(0)
            if not canRespawn then
                Draw2DText(0.89, 1.42, 1.0,1.0,0.6, deathText:format(thecount), 255, 255, 255, 255)
            else
                Draw2DText(0.89, 1.42, 1.0,1.0,0.6, respawnText:format(math.ceil(EHeld/100)), 255, 255, 255, 255)
            end
        end
        inDoctorBed = false
    end)

    while isDead do 
        Wait(1000)
        deadTime = deadTime - 1

        if deadTime < 0 and not respawnComplete then
            if not canRespawn then 
                canRespawn = true
            end
            if HeldTime < 1 and not (isMinor and IsPedInAnySeat()) then 
                deadTime = 1000
                respawnComplete = true
                if isMinor then 
                    RequestRevive()
                    return
                end
                ReleaseBody(not KeepItems)
            end
        end
    end
end

AddEventHandler('gameEventTriggered', function(event, data)
    if event == 'CEventNetworkEntityDamage' then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
            -- First thing first disarm ped
            TriggerEvent('ox_inventory:disarm')

            print(json.encode(data, {indent = true}))
            local deathHash = GetPedCauseOfDeath(cache.ped)
            local deathSource = GetPedSourceOfDeath(cache.ped)
            print(weapon, deathHash, deathSource)
            print(victim, cache.ped, PlayerPedId(), victimDied)
            print(attacker, IsEntityAPed(deathSource), IsPedAPlayer(deathSource), deathSource ~= PlayerPedId()) 

            local isViolent = IsViolent(weapon)
            local isMinor = IsMinor(weapon)

            local KeepItems = true

            SetEntityInvincible(cache.ped, true)
            SetEntityHealth(cache.ped, GetEntityMaxHealth(cache.ped))
            if not isDead then 
                isDead = true 
                StartDeath(isViolent, isMinor, KeepItems)
            end
        end
    end
end)