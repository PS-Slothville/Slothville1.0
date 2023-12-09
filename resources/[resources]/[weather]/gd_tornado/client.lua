StopGameplayCamShaking(0)



Citizen.CreateThread(function()
    local Script = MainScript:new()
    Script:MainScript()
    local IsTornadoActive = false
    local Tornado = nil
    local IsShake = false
    local IsStall = false
    
    local debugTeleport = true

    RegisterNetEvent("gd_tornado:spawn")
    AddEventHandler("gd_tornado:spawn", function(pos, dest)
        pos = vec3(pos.x, pos.y, pos.z)
        dest = vec3(dest.x, dest.y, dest.z)
        Tornado = Script._factory:CreateVortex(pos)
        Tornado._position = pos
        Tornado._destination = dest
        IsTornadoActive = true
    end)

    RegisterNetEvent("gd_tornado:setPosition")
    AddEventHandler("gd_tornado:setPosition", function(pos)
        pos = vec3(pos.x, pos.y, pos.z)
        Tornado = Script._factory:CreateVortex(pos)
        Tornado._position = pos
    end)

    RegisterNetEvent("gd_tornado:setDestination")
    AddEventHandler("gd_tornado:setDestination", function(dest)
        dest = vec3(dest.x, dest.y, dest.z)
        Tornado = Script._factory:CreateVortex(dest)
        Tornado._destination = dest
    end)

    RegisterNetEvent("gd_tornado:delete")
    AddEventHandler("gd_tornado:delete", function()
        IsTornadoActive = false
    end)

    while true do
        if IsTornadoActive and Tornado then
            Script:OnUpdate(GetGameTimer())
            local ped = PlayerPedId()
            
            -- print(GetIsVehicleEngineRunning(GetVehiclePedIsUsing(ped)))
            -- SetVehicleEngineOn(GetVehiclePedIsUsing(ped), false, true, true)
            local entity = GetVehiclePedIsUsing(ped)
            local model = GetEntityModel(entity)
            local coords = GetEntityCoords(PlayerPedId())
            local dist = #(coords - vector3(globalCoords.x, globalCoords.y, globalCoords.z))
            if dist < 600 then 
                -- print(dist)
                if dist < 300 then 
                    if IsThisModelAPlane(model) or IsThisModelAHeli(model) then
                        IsShake = true
                        -- print("stall 3")
                        if not IsStall then 
                            IsStall = true
                            print("stalled 2")
                            CreateThread(function()
                                print("stalled")
                                local heliRotar = GetHeliTailRotorHealth(entity)
                                local heliMain = GetHeliMainRotorHealth(entity)
                                local mainHealth = GetVehicleEngineHealth(entity)
                            
                                CreateThread(function()
                                    SetVehicleEngineHealth(entity, 0.0)
                                    Wait(math.random(500, 1000))
                                    SetVehicleEngineHealth(entity, heliMain)
                                end)

                                -- CreateThread(function()
                                --     SetHeliMainRotorHealth(entity, 0.0)
                                --     Wait(math.random(4000, 7000))
                                --     SetHeliMainRotorHealth(entity, heliMain)
                                -- end)

                                CreateThread(function()
                                    SetHeliTailRotorHealth(entity, 0.0)
                                    Wait(math.random(1000, 2000))
                                    SetHeliTailRotorHealth(entity, heliRotar)
                                end)
                                -- -- SetHeliTailRotorHealth(entity, 0.0)
                                -- SetHeliMainRotorHealth(entity, 0.0)
                                -- Wait(math.random(4000, 7000))
                                -- -- SetHeliTailRotorHealth(entity, heliRotar)
                                -- SetHeliMainRotorHealth(entity, heliMain)
                                Wait(math.random(10000,17000))
                               
                                IsStall = false
                            end)
                        end
                        if dist < 200 then 
                            -- print("shake 70.0")
                            ShakeGameplayCam('SKY_DIVING_SHAKE', 70.0)
                        else
                            -- print("shake 20.0")
                            ShakeGameplayCam('SKY_DIVING_SHAKE', 20.0)
                        end
                    else 
                        -- print("shake 5.0")
                        IsShake = true
                        ShakeGameplayCam('SKY_DIVING_SHAKE', 5.0)
                    end
                else
                    -- print("shake 1.0")
                    IsShake = true
                    ShakeGameplayCam('SKY_DIVING_SHAKE', 1.0)
                end
            else 
                if IsShake then 
                    IsShake = false
                    StopGameplayCamShaking(0)
                end
            end

            if debugTeleport then 
                debugTeleport = false 
                local entityToTP = GetVehiclePedIsUsing(PlayerPedId()) or PlayerPedId()
                SetEntityCoords(entityToTP, globalCoords.x, globalCoords.y, 300.0)
            end
            
        else
            if Tornado then
                Tornado._position = vec3(10000.0, 10000.0, 0.0)
                Script:OnUpdate(GetGameTimer())
                Tornado = nil
            end
        end
        Wait(15)
    end

end)