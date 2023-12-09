Framework               = {}
Framework.Config        = InternalConfig
Framework.Shared        = InternalShared
Framework.Database      = InternalDatabase
Framework.Permissions   = InternalPermissions
Framework.Functions     = InternalFunctions
Framework.Debug         = InternalDebug
Framework.Player        = InternalPlayer
Framework.Players       = InternalPlayers
Framework.Callback      = InternalCallback
    
exports('LoadObject', function()
    return Framework
end)

RegisterNetEvent(GetCurrentResourceName(), function()
    local src = source
    local identifier = ExtractIdentifiers(src)
    if not IsPlayerAceAllowed(src, 'nui_devtools') then
        -- ADD LOGS
        DropPlayer(src, "Hmm, what you wanna do in this inspector?")	
    end
end)