function CheckAdvWeatherArg(arg)
    for i,wtype in ipairs(Config.AdvancedWeatherTypes) do
        if string.upper(arg) == wtype then
            return true
        end
    end
    return false
end

CreateThread(function()
    GlobalState.AlwaysSnow = false
end)

RegisterCommand('alwayssnow', function(source, args) 
    if IsIdAdmin(source) then 
        GlobalState.AlwaysSnow = not GlobalState.AlwaysSnow
    end
end)