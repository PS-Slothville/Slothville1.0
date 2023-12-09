Framework               = {}
Framework.Config        = InternalConfig
Framework.Shared        = InternalShared
Framework.Debug         = InternalDebug
Framework.Functions     = InternalFunctions
Framework.Callback      = InternalCallback

-- This is not recommended for use
exports("LoadObject", function()
    return Framework
end)

-- State bag change handlers for framework
AddStateBagChangeHandler("UIHidden", nil, function(bagName, key, value)
    if GetPlayerFromStateBagName(bagName) ~= PlayerId() then return end
    if value then
        print("[SLOTHVILLE] Hiding UI.")
        SendNUIMessage({
            type = "HIDE_UI"
        })
    else
        print("[SLOTHVILLE] Showing UI.")
        SendNUIMessage({
            type = "SHOW_UI"
        })
    end
end)

-- Anti NUI Devtools
RegisterNUICallback(GetCurrentResourceName(), function()
    TriggerServerEvent(GetCurrentResourceName())
end)