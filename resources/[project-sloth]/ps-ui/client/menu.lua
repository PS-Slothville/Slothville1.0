
local function CreateMenu(MenuData)
    SendNUIMessage({
        action = "ShowMenu",
        data = MenuData
    })
    SetNuiFocus(true, true)
end
exports("CreateMenu", CreateMenu)

RegisterNetEvent("ps-ui:CreateMenu", function(MenuData)
    CreateMenu(MenuData)
end)

local function CloseMenu()
    SetNuiFocus(false, false)
end
exports("CloseMenu", CloseMenu)

RegisterNetEvent("ps-ui:CloseMenu", function()
    CloseMenu()
end)

RegisterNUICallback('menuClose', function(data, cb)
    CloseMenu()
    cb('ok')
end)

RegisterNUICallback('MenuSelect', function(data, cb)
    print("MenuSelect", json.encode(data))
    if data.data.event then 
        if data.data.server then 
            TriggerServerEvent(data.data.event, table.unpack(data.data.args))
        else
            TriggerEvent(data.data.event, table.unpack(data.data.args))
        end
    end
    CloseMenu()
    cb('ok')
end)

RegisterNetEvent("event:one", function(arg1, arg2, arg3)
    print("event:one", arg1, arg2, arg3)
end)