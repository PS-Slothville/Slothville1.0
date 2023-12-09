InternalSync = {}

RegisterNetEvent("ps-framework:SyncExecute", function(native, netID, ...)
    local entity = NetworkGetEntityFromNetworkId(netID)
    
    if not DoesEntityExist(entity) then
        return TriggerServerEvent('ps-framework:AbortedSyncNative', native, netID)
    end

    if InternalSync[native] then
        InternalSync[native](entity, ...)
    end
end)

function RequestSyncExecution(native, entity, ...)
    if DoesEntityExist(entity) then
        TriggerServerEvent('ps-framework:RequestSyncNative', GetInvokingResource(), native, GetPlayerServerId(NetworkGetEntityOwner(entity)), NetworkGetNetworkIdFromEntity(entity), ...)
    end
end

function SyncedExecution(native, entity, ...)
    if NetworkHasControlOfEntity(entity) then
        InternalSync[native](entity, ...)
    else
        RequestSyncExecution(native, entity, ...)
    end
end

exports("SyncedExecution", SyncedExecution)

--
-- better sync method
-- prob wanna use this instead
-- onesync needs to be better
--
-- options table:
-- - entity = { 1, 2, 4 }
-- - - table key IDs for network conversion

function SyncNative(name, netEntity, options, ...)
    TriggerServerEvent("ps-framework:ExecuteSyncNative", name, netEntity, options, table.pack(...))
end
exports("SyncNative", SyncNative)

RegisterNetEvent("ps-framework:ExecuteSyncNative", function(native, netEntity, options, args)
    if options and options.entity then
        for _, v in pairs(options.entity) do
            args[v] = NetworkGetEntityFromNetworkId(args[v])
        end
    end
    if native == "0xB736A491E64A32CF" then
        SetEntityAsNoLongerNeeded(args[1])
        return
    end
    local result = Citizen.InvokeNative(native, table.unpack(args))
end)

InternalSync.DeleteVehicle = function (vehicle)
    if NetworkHasControlOfEntity(vehicle) then
        DeleteVehicle(vehicle)
    else
        RequestSyncExecution("DeleteVehicle", vehicle)
    end
end

InternalSync.DeleteEntity = function (entity)
    if NetworkHasControlOfEntity(entity) then
        DeleteEntity(entity)
    else
        RequestSyncExecution("DeleteEntity", entity)
    end
end

InternalSync.DeletePed = function (ped)
    if NetworkHasControlOfEntity(ped) then
        DeletePed(ped)
    else
        RequestSyncExecution("DeletePed", ped)
    end
end

InternalSync.DeleteObject = function (object)
    if NetworkHasControlOfEntity(object) then
        DeleteObject(object)
    else
        RequestSyncExecution("DeleteObject", object)
    end
end

InternalSync.SetVehicleFuelLevel = function (vehicle, level)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleFuelLevel(vehicle, level)
    else
        RequestSyncExecution("SetVehicleFuelLevel", vehicle, level)
    end
end

InternalSync.SetVehicleTyreBurst = function (vehicle, index, onRim, p3)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleTyreBurst(vehicle, index, onRim, p3)
    else
        RequestSyncExecution("SetVehicleTyreBurst", vehicle, index, onRim, p3)
    end
end

InternalSync.SetVehicleDoorShut = function (vehicle, doorIndex, closeInstantly)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleDoorShut(vehicle, doorIndex, closeInstantly)
    else
        RequestSyncExecution("SetVehicleDoorShut", vehicle, doorIndex, closeInstantly)
    end
end

InternalSync.SetVehicleDoorOpen = function (vehicle, doorIndex, loose, openInstantly)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleDoorOpen(vehicle, doorIndex, loose, openInstantly)
    else
        RequestSyncExecution("SetVehicleDoorOpen", vehicle, doorIndex, loose, openInstantly)
    end
end

InternalSync.SetVehicleDoorBroken = function (vehicle, doorIndex, deleteDoor)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleDoorBroken(vehicle, doorIndex, deleteDoor)
    else
        RequestSyncExecution("SetVehicleDoorBroken", vehicle, doorIndex, deleteDoor)
    end
end

InternalSync.SetVehicleEngineOn = function(vehicle, value, instantly, noAutoTurnOn)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleEngineOn(vehicle, value, instantly, noAutoTurnOn)
    else
        RequestSyncExecution("SetVehicleEngineOn", vehicle, value, instantly, noAutoTurnOn)
    end
end

InternalSync.SetVehicleUndriveable = function(vehicle, toggle)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleUndriveable(vehicle, toggle)
    else
        RequestSyncExecution("SetVehicleUndriveable", vehicle, toggle)
    end
end

InternalSync.SetVehicleHandbrake = function(vehicle, toggle)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleHandbrake(vehicle, toggle)
    else
        RequestSyncExecution("SetVehicleHandbrake", vehicle, toggle)
    end
end

InternalSync.DecorSetFloat = function (entity, propertyName, value)
    if NetworkHasControlOfEntity(entity) then
        DecorSetFloat(entity, propertyName, value)
    else
        RequestSyncExecution("DecorSetFloat", entity, propertyName, value)
    end
end

InternalSync.DecorSetBool = function (entity, propertyName, value)
    if NetworkHasControlOfEntity(entity) then
        DecorSetBool(entity, propertyName, value)
    else
        RequestSyncExecution("DecorSetBool", entity, propertyName, value)
    end
end

InternalSync.DecorSetInt = function (entity, propertyName, value)
    if NetworkHasControlOfEntity(entity) then
        DecorSetInt(entity, propertyName, value)
    else
        RequestSyncExecution("DecorSetInt", entity, propertyName, value)
    end
end

InternalSync.DetachEntity = function (entity, p1, collision)
    if NetworkHasControlOfEntity(entity) then
        DetachEntity(entity, p1, collision)
    else
        RequestSyncExecution("DetachEntity", entity, p1, collision)
    end
end

InternalSync.SetEntityCoords = function (entity, xPos, yPos, zPos, xAxis, yAxis, zAxis, clearArea)
    if NetworkHasControlOfEntity(entity) then
        SetEntityCoords(entity, xPos, yPos, zPos, xAxis, yAxis, zAxis, clearArea)
    else
        RequestSyncExecution("SetEntityCoords", entity, xPos, yPos, zPos, xAxis, yAxis, zAxis, clearArea)
    end
end

InternalSync.SetEntityHeading = function (entity, heading)
    if NetworkHasControlOfEntity(entity) then
        SetEntityHeading(entity, heading)
    else
        RequestSyncExecution("SetEntityHeading", entity, heading)
    end
end

InternalSync.FreezeEntityPosition = function (entity, freeze)
    if NetworkHasControlOfEntity(entity) then
        FreezeEntityPosition(entity, freeze)
    else
        RequestSyncExecution("FreezeEntityPosition", entity, freeze)
    end
end

InternalSync.SetVehicleDoorsLocked = function (entity, status)
    if NetworkHasControlOfEntity(entity) then
        SetVehicleDoorsLocked(entity, status)
    else
        RequestSyncExecution("SetVehicleDoorsLocked", entity, status)
    end
end

InternalSync.NetworkExplodeVehicle = function (vehicle, isAudible, isInvisible, p3)
    if NetworkHasControlOfEntity(vehicle) then
        NetworkExplodeVehicle(vehicle, isAudible, isInvisible, p3)
    else
        RequestSyncExecution("NetworkExplodeVehicle", vehicle, isAudible, isInvisible, p3)
    end
end

InternalSync.SetBoatAnchor = function (vehicle, state)
    if NetworkHasControlOfEntity(vehicle) then
        SetBoatAnchor(vehicle, state)
    else
        RequestSyncExecution("SetBoatAnchor", vehicle, state)
    end
end

InternalSync.SetBoatFrozenWhenAnchored = function (vehicle, state)
    if NetworkHasControlOfEntity(vehicle) then
        SetBoatFrozenWhenAnchored(vehicle, state)
    else
        RequestSyncExecution("SetBoatFrozenWhenAnchored", vehicle, state)
    end
end

InternalSync.SetForcedBoatLocationWhenAnchored = function (vehicle, state)
    if NetworkHasControlOfEntity(vehicle) then
        SetForcedBoatLocationWhenAnchored(vehicle, state)
    else
        RequestSyncExecution("SetForcedBoatLocationWhenAnchored", vehicle, state)
    end
end

InternalSync.SetVehicleOnGroundProperly = function (vehicle)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleOnGroundProperly(vehicle)
    else
        RequestSyncExecution("SetVehicleOnGroundProperly", vehicle)
    end
end

InternalSync.SetVehicleTyreFixed = function (vehicle, index)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleTyreFixed(vehicle, index)
    else
        RequestSyncExecution("SetVehicleTyreFixed", vehicle, index)
    end
end

InternalSync.SetVehicleEngineHealth = function (vehicle, health)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleEngineHealth(vehicle, health + 0.0)
    else
        RequestSyncExecution("SetVehicleEngineHealth", vehicle, health  + 0.0)
    end
end

InternalSync.SetVehicleBodyHealth = function (vehicle, health)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleBodyHealth(vehicle, health + 0.0)
    else
        RequestSyncExecution("SetVehicleBodyHealth", vehicle, health  + 0.0)
    end
end

InternalSync.SetVehicleDeformationFixed = function (vehicle)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleDeformationFixed(vehicle)
    else
        RequestSyncExecution("SetVehicleDeformationFixed", vehicle)
    end
end

InternalSync.SetVehicleFixed = function (vehicle)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleFixed(vehicle)
    else
        RequestSyncExecution("SetVehicleFixed", vehicle)
    end
end

InternalSync.SetEntityAsNoLongerNeeded = function (entity)
    if NetworkHasControlOfEntity(entity) then
        SetEntityAsNoLongerNeeded(entity)
    else
        RequestSyncExecution("SetEntityAsNoLongerNeeded", entity)
    end
end

InternalSync.SetPedKeepTask = function (ped, keepTask)
    if NetworkHasControlOfEntity(ped) then
        SetPedKeepTask(ped, keepTask)
    else
        RequestSyncExecution("SetPedKeepTask", ped, keepTask)
    end
end

InternalSync.SetVehicleMods = function (vehicle, mods)
    if NetworkHasControlOfEntity(vehicle) then
        -- come back when customs script is made
    else
        RequestSyncExecution("SetVehicleMods", vehicle, mods)
    end
end

InternalSync.SetVehicleAppearance = function (vehicle, appearance)
    if NetworkHasControlOfEntity(vehicle) then
        -- come back when customs script is made
    else
        RequestSyncExecution("SetVehicleAppearance", vehicle, appearance)
    end
end

InternalSync.SetVehicleTyresCanBurst = function (vehicle, enabled)
    if NetworkHasControlOfEntity(vehicle) then
        SetVehicleTyresCanBurst(vehicle, enabled)
    else
        RequestSyncExecution("SetVehicleTyresCanBurst", vehicle, enabled)
    end
end