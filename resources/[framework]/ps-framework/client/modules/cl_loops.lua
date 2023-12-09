Register player coordinates with the server.
CreateThread(function()
    while true do
        Wait(2500)
        if LocalPlayer.state.isLoggedIn then
            local PlayerPed = PlayerPedId()
            TriggerServerEvent("ps-framework:UpdatePlayerCoords", GetEntityCoords(PlayerPed), GetEntityHeading(PlayerPed))
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if LocalPlayer.state.isLoggedIn then
            Wait((1000 * 60) * InternalConfig.Player.UpdateRate)
            TriggerServerEvent('ps-framwork:UpdatePlayer')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(InternalConfig.Player.StatusRate)
        if LocalPlayer.state.isLoggedIn then
            if LocalPlayer.state.metadata['hunger'] <= 5 or LocalPlayer.state.metadata['thirst'] <= 5 then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                SetEntityHealth(ped, currentHealth - math.random(5, 10))
            end
        end
    end
end)