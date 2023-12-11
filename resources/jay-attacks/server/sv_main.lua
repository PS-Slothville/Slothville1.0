local function Spawn(source, spawnLocation)
    local source = source
    local netIds = {}
    local netId
    local vehId
    local playerPed = GetPlayerPed(source)
    for spawn=1,#Config.Spawns[spawnLocation].spawns do
        local copVehicle = CreateVehicle(Config.Spawns[spawnLocation].car, Config.Spawns[spawnLocation].spawns[spawn].x, Config.Spawns[spawnLocation].spawns[spawn].y, Config.Spawns[spawnLocation].spawns[spawn].z, Config.Spawns[spawnLocation].spawns[spawn].w, true, true)
        local veh_coords = GetEntityCoords(copVehicle)
        while not DoesEntityExist(copVehicle) do Wait(25) end
        vehId = NetworkGetNetworkIdFromEntity(copVehicle)
        for i = 1,Config.Spawns[spawnLocation].max do
            local ped = CreatePed(30, Config.Spawns[spawnLocation].ped, Config.Spawns[spawnLocation].spawns[spawn].x, Config.Spawns[spawnLocation].spawns[spawn].y, Config.Spawns[spawnLocation].spawns[spawn].z, 0, true, false)
            SetPedIntoVehicle(ped, copVehicle, i-2)
            GiveWeaponToPed(ped, Config.Spawns[spawnLocation].weapon, 250, false, true)
            SetPedArmour(ped, 100)
            TaskCombatPed(ped, playerPed, 0, 16)
            while not DoesEntityExist(ped) do Wait(25) end
            netId = NetworkGetNetworkIdFromEntity(ped)
            print(netId)
            netIds[#netIds+1] = netId
        end
        TriggerClientEvent("jay-attacks:spawn", source, netIds, vehId)
    end
end exports("Spawn", Spawn)

RegisterNetEvent("jay-attacks:createSpawns", function()
    Spawn(source)
end)

RegisterCommand("test", function(s,a)
   Spawn(s)
end)

-- RegisterServerEvent('deleteEntitiesAcrossClients', function(entities)
--     TriggerClientEvent("deleteEntitiesFromServer", -1, entities)  
-- end)