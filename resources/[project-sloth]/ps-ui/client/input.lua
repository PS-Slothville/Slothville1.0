local p = nil
local Active = false

local function Input(InputData)
    p = promise.new()
    while Active do Wait(0) end
    Active = true
    print("InputData", json.encode(InputData))
    SendNUIMessage({
        action = "ShowInput",
        data = InputData
    })
    SetNuiFocus(true, true)

    local inputs = Citizen.Await(p)
    return inputs
end
exports("Input", Input)

RegisterNUICallback('input-callback', function(data, cb)
    print("input-callback", json.encode(data))
	SetNuiFocus(false, false)
    p:resolve(data)
    p = nil
    Active = false
    cb('ok')
end)

RegisterNUICallback('input-close', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)