local function Log(...)
    if Config.debug then
        print(...)
    end
end

CreateThread(function()
    for k, v in pairs(Config.Routes) do
        OpenPatrolRoute('miss_'..k) -- Seems if it dsoent start with 'miss_', its hardcoded not to work
        for i = 0, #v.Points do
            if v.CustomLookAt then
                AddPatrolRouteNode(i, v.Scenario, v.Points[i], v.LookAt[i], v.Timeout)
                Log('AddPatrolRouteNode('..i.. ', '..v.Scenario..', '..v.LookAt[i]..', '..v.Points[i]..', '..v.Timeout)
            else
                AddPatrolRouteNode(i, v.Scenario, v.Points[i], v.Points[i], v.Timeout)
                Log('AddPatrolRouteNode('..i.. ', '..v.Scenario..', '..v.Points[i]..', '..v.Points[i]..', '..v.Timeout)
            end
            if i  < #v.Points then
                AddPatrolRouteLink(i, (i + 1))
                Log('AddPatrolRouteLink('..i..', '..(i + 1)..')')
            else
                AddPatrolRouteLink(i, 0)
                Log('AddPatrolRouteLink('..i..', '..'0'..')')
            end
        end
        ClosePatrolRoute()
        CreatePatrolRoute()

        if Config.debug then
            CreateThread(function()
                while true do
                    Wait(1)
                    for i = 0, #v.Points do
                        DrawMarker(28, v.Points[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0, 100, 255, 255, false)
                        if i  < #v.Points then
                            DrawLine(v.Points[i], v.Points[i + 1], 0, 255, 0, 255)
                        else
                            DrawLine(v.Points[i], v.Points[0], 0, 255, 0, 255)
                        end
                        if v.CustomLookAt then
                            DrawLine(v.Points[i], v.LookAt[i], 255, 0, 0, 255)
                        end
                    end
                    -- if DoesEntityExist(ped) then
                    --     --[[
                    --         1. Patrollig (Normal)
                    --         2. Ragdolled
                    --         7. Not Patrollig
                    --     ]]
                    --     print(GetScriptTaskStatus(ped, `SCRIPT_TASK_PATROL`))
                    -- end
                end
            end)
        end
    end
end)

-- RegisterCommand('patrol', function(source, args)
--     TriggerServerEvent('jay-patrols:server:spawnGuard', 6, `G_M_M_Goons_01`, vector4(1873.597, 2537.6685, 45.6721, 60.0), 'miss_'..args[1])
-- end)

-- RegisterCommand('getmission', function(source, args)
    -- TriggerServerEvent('jay-patrols:server:spawnGuard', 6, `s_m_m_security_01`, vector4(715.05615, 136.15304, 80.754486, 348.05642), 'miss_powerstation_walk')
    -- TriggerServerEvent('jay-patrols:server:spawnGuard', 6, `s_m_m_security_01`, vector4(711.28271, 150.90623, 80.754531, 262.78869), 'miss_powerstation_test')
    -- TriggerServerEvent('jay-patrols:server:spawnGuard', 6, `s_m_m_security_01`, vector4(726.00299, 146.55435, 80.754493, 128.40267), 'miss_powerstation_test_2')
-- end)

RegisterNetEvent('jay-patrols:server:catchGuard', function(pID, route)
    while NetworkGetEntityFromNetworkId(pID) == 0 do Wait(1000) end
    Wait(1000)
    local ped = NetworkGetEntityFromNetworkId(pID)
    Log('Got Ped: '..pID, DoesEntityExist(ped))
    SetPedDesiredMoveBlendRatio(ped, 0.0)
    SetPedDropsWeaponsWhenDead(ped, false)
    SetPedKeepTask(ped, true)
    SetCanAttackFriendly(ped, false, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAttributes(ped, 0, false)
    SetPedCombatAbility(ped, 100)
    SetPedAsCop(ped, true)
    SetPedAlertness(ped, 3)
    TaskPatrol(ped, route, 1, false, true)
    CreateThread(function()
        while not IsEntityDead(ped) do
            Wait(1000)
            local me = PlayerPedId()
            local coords = GetEntityCoords(me)
            local guard = GetEntityCoords(ped)
            local dist = #(coords-guard)
            if dist < 20 then
                SetPedRelationshipGroupHash(ped, `HATES_PLAYER`)
                SetPedAccuracy(ped, 60)
                SetPedFleeAttributes(ped, 0, 0)
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskCombatPed(ped, me, 0, 16)
                if IsEntityDead(me) then
                    SetBlockingOfNonTemporaryEvents(ped, false)
                    TaskPatrol(ped, route, 1, false, true)
                end
            end
        end
    end)
end)

AddEventHandler('onResourceStop', function(res)
    if GetCurrentResourceName() ~= res then
        return
    end

    for k in pairs(Config.Routes) do
        Log('^1Deleted '..'miss_'..k..'^7')
        DeletePatrolRoute('miss_'..k)
    end
end)