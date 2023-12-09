RegisterNetEvent("scuff-fix", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if IsEntityDead(ped) or IsPedRagdoll(ped) then
        print("Dead Scuff Fix")
        SetEntityCoords(ped, coords)
    end
end)

RegisterCommand("scuff-fix", function()
    TriggerEvent("scuff-fix")
end)