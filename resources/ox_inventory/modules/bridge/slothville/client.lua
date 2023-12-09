local onLogout = ...

RegisterNetEvent('ox:playerLogout', onLogout)

AddStateBagChangeHandler("job", nil, function(bagName, key, value) 
    if GetPlayerFromStateBagName(bagName) ~= PlayerId() then return end
	local plyState = value
	local PlayerData = {}
	PlayerData.groups = {}
    PlayerData.groups[value.name] = value.rank
	OnPlayerData("groups", PlayerData.groups)
end)

--[[
AddStateBagChangeHandler("gang", nil, function(bagName, key, value) 
    if GetPlayerFromStateBagName(bagName) ~= PlayerId() then return end
	local plyState = LocalPlayer.state
	local PlayerData = {}
	PlayerData.groups = {}
    PlayerData.groups[plyState.gang.name] = plyState.gang.rank
	OnPlayerData("groups", PlayerData.groups)
end)]]

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(values)
	for name, value in pairs(values) do

		local plyState = LocalPlayer.state
		if name == "hunger" then
			TriggerServerEvent('ps-framework:SetHunger', plyState.metadata.hunger + value)
		elseif name == "thirst" then
			TriggerServerEvent('ps-framework:SetThirst', plyState.metadata.thirst + value)
		elseif name == "stress" then
			TriggerServerEvent('ps-framework:SetStress', plyState.metadata.stress + value)
		end
	end
end
