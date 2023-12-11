RegisterNetEvent("ps-framework:LoadCharacters", function()
    local src = source
    local characters = exports['ps-framework']:GetCharacters(src)

    TriggerClientEvent("ps-multi:LoadCharacters", src, characters)
end)

RegisterNetEvent("ps-multi:SelectCharacter", function(cid)
    local src = source
    exports['ps-framework']:SelectCharacter(src, cid)
end)

RegisterNetEvent("ps-multi:CreateCharacter", function(info, slot)
    local src = source
    exports['ps-framework']:CreateCharacter(src, info, slot)
end)

RegisterNetEvent("ps-framework:Logout", function()
    local src = source
    Player(src).state:set('isLoggedIn', false, true)
    exports['ps-framework']:Logout(src)
end)

RegisterNetEvent("ps-multi:DeleteCharacter", function(cid)
    local src = source
    exports['ps-framework']:DeleteCharacter(src, cid)
    TriggerClientEvent("ps-multi:CharacterDeleted", src)
end)