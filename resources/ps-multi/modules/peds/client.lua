---@class Peds
---@field PedList table
---@field SpawnPed function
---@field DestroyPeds function

Peds = {}
Peds.PedList = {}

Peds.SpawnPed = function(position, gender)
    -- print("SpawnPed 1")
    local Model
    if tonumber(gender) == 0 then
        Model = 'mp_f_freemode_01'
    else
        Model = 'mp_m_freemode_01'
    end
    -- print("SpawnPed 2")
    local coords = Config.CharLocations[CurrentScene][position]
    RequestModel(GetHashKey(Model))
    while not HasModelLoaded(GetHashKey(Model)) do
        Wait(1)
    end
    -- print("SpawnPed 3")
    -- local ped = CreatePed(GetHashKey(Model), coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    local ped = CreatePed(2, GetHashKey(Model), coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    -- print("SpawnPed 4", ped)
    while not DoesEntityExist(ped) do
        Wait(1)
    end
    -- print("SpawnPed 5")
    SetEntityAsMissionEntity(ped, true, true)
    NetworkSetEntityInvisibleToNetwork(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, coords.w)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityCanBeDamagedByRelationshipGroup(ped, false, GetHashKey("PLAYER"))
    SetModelAsNoLongerNeeded(GetHashKey(Model))
    Peds.PedList[position] = ped
    -- print("yolo")
    return Peds.PedList[position]
end

Peds.DestroyPeds = function()
    for position,ped in pairs(Peds.PedList) do
        DeleteEntity(ped)
    end
end

Peds.DestroyPed = function(position)
    DeleteEntity(Peds.PedList[position])
end
