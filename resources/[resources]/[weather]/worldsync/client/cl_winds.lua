local cache_prop_id = {}

CreateThread(function()
    while true do
        Wait(1000) -- Wait for 1 second before adding props to table
        for _, obj in ipairs(GetGamePool("CObject")) do
            if not IsEntityAPed(obj) and IsEntityAnObject(obj) then
                local propHash = GetEntityModel(obj)
                if Config.WindProps[propHash] or Config.AnyProp and not Config.WindDisableProp[hash] then -- test
                    cache_prop_id[obj] = propHash
                end
            end
            Wait(15) -- safety
        end
    end
end)

CreateThread(function()
    while true do
        Wait(100)
        if GlobalState.WindForce > 0 then
            -- print(GlobalState.WindForce)
            for obj, hash in pairs(cache_prop_id) do 
                -- print(obj, hash)
                local bypass = false
                if not DoesEntityExist(obj) then
                    -- print("entity no exist")
                    cache_prop_id[obj] = nil 
                    bypass = true
                end
                if bypass or Config.WindProps[hash] or Config.AnyProp and not Config.WindDisableProp[hash] then -- test
                    -- print("test")
                    ApplyForceToEntityCenterOfMass(obj, 1, GlobalState.WindVector.x, GlobalState.WindVector.y, GlobalState.WindVector.z, 0.0, 0.0, 0.0, 0, true, true, true, true, true)   
                end
            end
        else
            Wait(5000)
        end

    end
end)
