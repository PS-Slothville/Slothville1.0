RegisterServerEvent("ps-framework:RequestSyncNative", function(native, netID, ...)
    TriggerClientEvent("ps-framework:SyncExecute", -1, native, netID, ...)
end)

RegisterServerEvent("ps-framework:ExecuteSyncNative", function(native, netEntity, options, args)
    TriggerClientEvent("ps-framework:ExecuteSyncNative", -1, native, netEntity, options, args)
end)

RegisterNetEvent("ps-framework:AbortedSyncNative", function(native, netID)
    -- Logs
end)