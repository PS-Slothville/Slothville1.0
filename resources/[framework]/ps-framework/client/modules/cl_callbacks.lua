InternalCallback = {}

InternalCallback.Execute = function(name, data)
	local newEvent = nil
	local p = promise.new()
	local key = math.random(1,9999999)
	local event = ("ps-framework:%s:%s"):format(name, key)
	RegisterNetEvent(event)
	newEvent = AddEventHandler(event, function(result)
		newEvent = RemoveEventHandler(newEvent)
		p:resolve(result)
	end)
	TriggerServerEvent("ps-framework:TriggerCallback", key, name, data)
	return Citizen.Await(p)
end
exports("ExecuteCallback", InternalCallback.Execute)