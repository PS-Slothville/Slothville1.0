--useless except for GlobalStates
CreateThread(function()
    GlobalState.MaxPlayers = InternalConfig.MaxPlayers
    GlobalState.PlayerCount = 0
    while true do
        Wait(10000)
        GlobalState.PlayerCount = #GetPlayers()
    end
end)