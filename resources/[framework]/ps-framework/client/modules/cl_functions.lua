InternalFunctions = {}

InternalFunctions.GetEntityInFront = function(distance, ped)
	local coords = GetEntityCoords(ped, 1)
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, distance, 0.0)
	local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, offset.x, offset.y, offset.z, -1, ped, 0)
	local a, b, c, d, entity = GetRaycastResult(rayHandle)
	return entity
end
exports("GetEntityInFront", InternalFunctions.GetEntityInFront)

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
exports("GetCardinalDirection", InternalFunctions.GetCardinalDirection)

InternalFunctions.OpenUrl = function(url)
    SendNUIMessage({
        url = url or "https://discord.gg/qptj9xqxgm",
    })
end
exports("OpenUrl", InternalFunctions.OpenUrl)

InternalFunctions.RotationToDirection = function(rotation)
    local z = math.rad(rotation.z);
    local x = math.rad(rotation.x);
    local num = math.abs(math.cos(x));

    local vector3Direction = vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
    return vector3Direction
end
exports("RotationToDirection", InternalFunctions.RotationToDirection)

InternalFunctions.ScreenRelToWorld = function(camPos,camRot,coord)
    local distance = 20.0
    local camForward = InternalFunctions.RotationToDirection(camRot);
    local rotUp = camRot + vector3(distance, 0, 0);
    local rotDown = camRot + vector3(-distance, 0, 0);
    local rotLeft = camRot + vector3(0, 0, -distance);
    local rotRight = camRot + vector3(0, 0, distance);

    local camRight = InternalFunctions.RotationToDirection(rotRight) - InternalFunctions.RotationToDirection(rotLeft);
    local camUp = InternalFunctions.RotationToDirection(rotUp) - InternalFunctions.RotationToDirection(rotDown);

    local rollRad = -math.rad(camRot.y);

    local camRightRoll = camRight * math.cos(rollRad) - camUp * math.sin(rollRad);
    local camUpRoll = camRight * math.sin(rollRad) + camUp * math.cos(rollRad);

    local point3D = camPos + camForward * distance + camRightRoll + camUpRoll;
    local point2D;
    local b,cx,cy = GetScreenCoordFromWorldCoord(point3D.x,point3D.y,point3D.z)
    local point2D = {X = cx,Y = cy};
    if not point2D or not cx or not cy then 
      print("[ERROR] If you see this please report")
      return camPos + camForward * distance; 
    end

    local point3DZero = camPos + camForward * distance;
    local b,cx,cy = GetScreenCoordFromWorldCoord(point3DZero.x,point3DZero.y,point3DZero.z)
    local point2DZero = {X = cx,Y = cy};
    if not point2DZero or not cx or not cy then 
      print("[ERROR2] If you see this please report")
      return camPos + camForward * distance; 
    end

    local eps = 0.001;
    if (math.abs(point2D.X - point2DZero.X) < eps or math.abs(point2D.Y - point2DZero.Y) < eps) then 
      print("[ERROR3] If you see this please report")
      return camPos + camForward * distance; 
    end

    local scaleX = (coord.x - point2DZero.X) / (point2D.X - point2DZero.X);
    local scaleY = (coord.y - point2DZero.Y) / (point2D.Y - point2DZero.Y);
    local point3Dret = camPos + camForward * distance + camRightRoll * scaleX + camUpRoll * scaleY;
    return point3Dret;
end
exports("ScreenRelToWorld", InternalFunctions.ScreenRelToWorld)

InternalFunctions.RequestAnimDict = function(animDict)
	if HasAnimDictLoaded(animDict) then return end
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(0)
	end
end
exports("RequestAnimDict", InternalFunctions.RequestAnimDict)

InternalFunctions.PlayAnim = function(animDict, animName, upperbodyOnly, duration)
    local flags = upperbodyOnly and 16 or 0
    local runTime = duration or -1
    InternalFunctions.RequestAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 1.0, runTime, flags, 0.0, false, false, true)
    RemoveAnimDict(animDict)
end
exports("PlayAnim", InternalFunctions.PlayAnim)

InternalFunctions.LoadModel = function(model)
    if HasModelLoaded(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end
exports("LoadModel", InternalFunctions.LoadModel)

InternalFunctions.LoadAnimSet = function(animSet)
    if HasAnimSetLoaded(animSet) then return end
    RequestAnimSet(animSet)
    while not HasAnimSetLoaded(animSet) do
        Wait(0)
    end
end
exports("LoadAnimSet", InternalFunctions.LoadAnimSet)

InternalFunctions.GetVehicles = function()
    return GetGamePool('CVehicle')
end
exports("GetVehicles", InternalFunctions.GetVehicles)

InternalFunctions.GetObjects = function()
    return GetGamePool('CObject')
end
exports("GetObjects", InternalFunctions.GetObjects)

InternalFunctions.GetPlayers = function()
    return GetActivePlayers()
end
exports("GetPlayers", InternalFunctions.GetPlayers)

InternalFunctions.GetStreetNametAtCoords = function(coords)
    local streetname1, streetname2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    return { main = GetStreetNameFromHashKey(streetname1), cross = GetStreetNameFromHashKey(streetname2) }
end
exports("GetStreetNametAtCoords", InternalFunctions.GetStreetNametAtCoords)

InternalFunctions.GetZoneAtCoords = function(coords)
    return GetLabelText(GetNameOfZone(coords))
end
exports("GetZoneAtCoords", InternalFunctions.GetZoneAtCoords)

InternalFunctions.GetCurrentTime = function()
    local obj = {}
    obj.min = GetClockMinutes()
    obj.hour = GetClockHours()

    if obj.hour <= 12 then
        obj.ampm = "AM"
    elseif obj.hour >= 13 then
        obj.ampm = "PM"
        obj.formattedHour = obj.hour - 12
    end

    if obj.min <= 9 then
        obj.formattedMin = "0" .. obj.min
    end

    return obj
end
exports("GetCurrentTime", InternalFunctions.GetCurrentTime)

InternalFunctions.GetGroundZCoord = function(coords)
    if not coords then return end

    local retval, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)
    if retval then
        return vector3(coords.x, coords.y, groundZ)
    else
        print('Couldn\'t find Ground Z Coordinates given 3D Coordinates')
        print(coords)
        return coords
    end
end
exports("GetGroundZCoord", InternalFunctions.GetGroundZCoord)


-- InternalFunctions.RequestRoutingBucket = function(bucket) -- insecure asf
--     TriggerServerEvent("ps-framework:RequestRoutingBucketForSelf", bucket)
-- end