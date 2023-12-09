InternalFunctions = {}

InternalFunctions.GetEntityInFront = function(distance, ped)
	local coords = GetEntityCoords(ped, 1)
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, distance, 0.0)
	local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, offset.x, offset.y, offset.z, -1, ped, 0)
	local a, b, c, d, entity = GetRaycastResult(rayHandle)
	return entity
end

InternalFunctions.GetCardinalDirection = function(entity)
    entity = DoesEntityExist(entity) and entity or PlayerPedId()
    if DoesEntityExist(entity) then
        local heading = GetEntityHeading(entity)
        if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
            return "North"
        elseif (heading >= 45 and heading < 135) then
            return "West"
        elseif (heading >= 135 and heading < 225) then
            return "South"
        elseif (heading >= 225 and heading < 315) then
            return "East"
        end
    else
        return "Cardinal Direction Error"
    end
end

InternalFunctions.OpenUrl = function(url)
    SendNUIMessage({
        url = url or "https://discord.gg/eA2DJyvXTy",
    })
end

-- InternalFunctions.RequestRoutingBucket = function(bucket) -- insecure asf
--     TriggerServerEvent("ps-framework:RequestRoutingBucketForSelf", bucket)
-- end