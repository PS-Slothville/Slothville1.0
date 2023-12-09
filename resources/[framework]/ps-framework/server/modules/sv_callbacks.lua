local Callbacks = {}
InternalCallback = {}

RegisterNetEvent("ps-framework:TriggerCallback", function(key, name, data)
    if not data then data = {} end
    local source = source
    local event = ("ps-framework:%s:%s"):format(name, key)

    -- print(name, source, data, key, Callbacks, Callbacks[name])
    local cb = Callbacks[name]
    local result = cb(source, data)
    TriggerClientEvent(event, source, result)
end)

InternalCallback.Register = function(name, cb)
    if Callbacks[name] then print("[CALLBACKS] `"..name.."` exists, overriding.") end

    Callbacks[name] = cb
end
exports("RegisterCallback", InternalCallback.Register)
