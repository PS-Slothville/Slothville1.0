RegisterNetEvent("jay-attacks:spawn", function(netIds, vehId)
    local ped = PlayerPedId()
    Wait(1000)
    -- local copVehicle = NetworkGetEntityFromNetworkId(vehId)
    for i = 1, #netIds, 1 do
        local guard = NetworkGetEntityFromNetworkId(netIds[i])
        print(guard)
        -- SetPedIntoVehicle(guard, copVehicle, i-2)
        SetPedDropsWeaponsWhenDead(guard, false)
        SetEntityHealth(guard, 200)
        SetCanAttackFriendly(guard, false, true)
        SetPedCombatAttributes(guard, 46, true)
        SetPedCombatAttributes(guard, 0, false)
        SetPedCombatAbility(guard, 100)
        SetPedAsCop(guard, true)
        SetPedRelationshipGroupHash(guard, `HATES_PLAYER`)
        SetPedAccuracy(guard, 60)
        SetPedFleeAttributes(guard, 0, 0)
        SetPedKeepTask(guard, true)
        SetBlockingOfNonTemporaryEvents(guard, true)
        TaskCombatPed(guard, ped, 0, 16)
    end
end)



-- CLIENT
-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(60000) --every minute
--         local deadPeds = {}
--         local pedPool = GetGamePool('CPed')
--         for _, ped in pairs(pedPool) do
--             if IsEntityDead(ped) then
--                 deadPeds[#deadPeds+1]= ped
--             end
--         end
--         TriggerServerEvent("deleteEntitiesAcrossClients", deadPeds)
--     end
-- end)


-- RegisterNetEvent('deleteEntitiesFromServer', function(entities)
--     for _, entity in pairs(entities) do
--         SetEntityAsNoLongerNeeded(entity)
--         DeleteEntity(entity)
--     end
-- end)