local Text = ""
local Color = "primary"

exports("DisplayText", function(text, color, icon)
    print(text, color, icon)
    if text == nil then Text = "" else Text = text end
    if color ==  nil then Color = "primary" else Color = color end
    print(Text, Color)
    SendNUIMessage({
        action = "ShowDrawTextMenu",
        data = {
            title = "No Title",
            keys = Text,
            icon = icon or 'fa-solid fa-circle-info',
            color = Color,
        }
    })
end)

exports("HideText", function()
    Text = ""
    Color = "primary"
    SendNUIMessage({
        action = "HideDrawTextMenu",
    })
end)

exports("UpdateText", function(text)
    if text == nil then Text = "" else Text = text end
    SendNUIMessage({
        action = "ShowDrawTextMenu",
        data = {
            keys = Text,
            icon = icon or 'fa-solid fa-circle-info',
            color = Color,
        }
    })
end)



