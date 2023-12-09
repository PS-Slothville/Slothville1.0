RegisterServerEvent("ps-framework:RequestSyncNative", function(native, netID, ...)
    TriggerClientEvent("ps-framework:SyncExecute", -1, native, netID, ...)
end)

RegisterServerEvent("comet-base:server:ExecuteSyncNative", function(native, netEntity, options, args)
    TriggerClientEvent("comet-base:client:ExecuteSyncNative", -1, native, netEntity, options, args)
end)

RegisterNetEvent("ps-framework:AbortedSyncNative", function(native, netID)
    -- Logs
end)