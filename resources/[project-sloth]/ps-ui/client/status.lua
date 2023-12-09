local function StatusShow(title,description, icon, values)
    print("StatusShow")
    SendNUIMessage({
        action = "ShowStatusBar",
        data = {
            title = title,
			description = description,
            icon = icon,
			items = values
        }
    })
end

local function StatusHide()
    SendNUIMessage({
        action = "HideStatusBar",
    })
end

local function StatusUpdate(title, values)
    SendNUIMessage({
        action = "status",
        update = true,
        title = title,
        values = values,
    })
end

exports("StatusShow", StatusShow)
exports("StatusHide", StatusHide)
exports("StatusUpdate", StatusUpdate)