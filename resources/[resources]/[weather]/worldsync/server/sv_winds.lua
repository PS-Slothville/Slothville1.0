local RandomValues = {
    'WEST', 'NORTH', 'NORTHWEST', 'NORTHEAST',
    'EAST', 'SOUTH', 'SOUTHWEST', 'SOUTHEAST',
}

local ServerDirection

CreateThread(function()
    GlobalState.WindDirection = Config.WindDirections[RandomValues[math.random(#RandomValues)]]
    GlobalState.WindForce = 0.0
    GlobalState.WindVector = (GlobalState.WindDirection * GlobalState.WindForce)
    ServerDirection = RandomValues[math.random(#RandomValues)]
end)

function WindDirectionChange()
    local NextDirection = math.random(1,2)
    if ServerDirection == "NORTH" then 
        if NextDirection == 1 then
            ServerDirection = "NORTHEAST"
            return Config.WindDirections["NORTHEAST"]
        else
            ServerDirection = "NORTHWEST"
            return Config.WindDirections["NORTHWEST"]
        end
    end
    if ServerDirection == "WEST" then 
        if NextDirection == 1 then
            ServerDirection = "SOUTHWEST"
            return Config.WindDirections["SOUTHWEST"]
        else
            ServerDirection = "NORTHWEST"
            return Config.WindDirections["NORTHWEST"]
        end
    end
    if ServerDirection == "SOUTH" then 
        if NextDirection == 1 then
            ServerDirection = "SOUTHEAST"
            return Config.WindDirections["SOUTHEAST"]
        else
            ServerDirection = "SOUTHWEST"
            return Config.WindDirections["SOUTHWEST"]
        end
    end
    if ServerDirection == "EAST" then 
        if NextDirection == 1 then
            ServerDirection = "SOUTHEAST"
            return Config.WindDirections["SOUTHEAST"]
        else
            ServerDirection = "NORTHEAST"
            return Config.WindDirections["NORTHEAST"]
        end
    end
    if ServerDirection == "NORTHWEST" then 
        if NextDirection == 1 then
            ServerDirection = "WEST"
            return Config.WindDirections["WEST"]
        else
            ServerDirection = "NORTH"
            return Config.WindDirections["NORTH"]
        end
    end
    if ServerDirection == "NORTHEAST" then 
        if NextDirection == 1 then
            ServerDirection = "EAST"
            return Config.WindDirections["EAST"]
        else
            ServerDirection = "NORTH"
            return Config.WindDirections["NORTH"]
        end
    end
    if ServerDirection == "SOUTHWEST" then 
        if NextDirection == 1 then
            ServerDirection = "WEST"
            return Config.WindDirections["WEST"]
        else
            ServerDirection = "SOUTH"
            return Config.WindDirections["SOUTH"]
        end
    end
    if ServerDirection == "SOUTHEAST" then 
        if NextDirection == 1 then
            ServerDirection = "EAST"
            return Config.WindDirections["EAST"]
        else
            ServerDirection = "SOUTH"
            return Config.WindDirections["SOUTH"]
        end
    end
end

function WindForceChange()
    local undecimalwindforce = GlobalState.WindForce * 10
    local randomForce = math.random(-5,5)
    if GlobalState.WeatherSyncing == "EXTRASUNNY" or GlobalState.WeatherSyncing == "CLEAR" or GlobalState.WeatherSyncing == 'NEUTRAL' then 
        randomForce = math.random(-5,5)
    end

    if GlobalState.WeatherSyncing == "THUNDER" or GlobalState.WeatherSyncing == "BLIZZARD" then
        randomForce = math.random(-10, 30)
    end

    print(randomForce)
    local NewForce = ((undecimalwindforce + randomForce) / 10.0)
    if NewForce < 0 then 
        NewForce = 0.0
    end
    return NewForce
end

function ChangeValue()
    if math.random(8) == 2 then
        return true
    end
    return false
end

RegisterCommand("wind", function(s,a)
    ServerDirection = string.upper(a[1])
    GlobalState.WindDirection = WindDirectionChange()
end)

RegisterCommand("test-cmd", function(s,a )
    GlobalState.WindForce = (tonumber(a[1]) or 10)*1.0
end)

CreateThread(function()
    while true do
        Wait(2000) -- so WindDirectionUpdates
        if not GlobalState.FreezeWindSyncing then
            if ChangeValue() then -- Wend Direction
                GlobalState.WindDirection = WindDirectionChange()
            end
            if ChangeValue() then
                GlobalState.WindForce = WindForceChange()
            end
            -- print(GlobalState.WindDirection, ServerDirection)
            print(GlobalState.WindForce, GlobalState.WeatherSyncing, ServerDirection)
            if GlobalState.WindVector ~= (GlobalState.WindDirection * GlobalState.WindForce) then 
                GlobalState.WindVector = (GlobalState.WindDirection * GlobalState.WindForce)
            end

        end
    end
end)