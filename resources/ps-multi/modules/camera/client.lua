---@class Camera
---@field Cam table
---@field SelectedChar number
---@field PointingAtChar number
---@field CamActive boolean
---@field SetUpCamera function
---@field DestroyCamera function
---@field StartCameraThread function

DrawText2D = function (text, x,y, width,height, scale, r, g, b, a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


Camera = {}
Camera.Cam = nil
Camera.SelectedChar = 1
Camera.PointingAtChar = 0
Camera.CamActive = false

Camera.SetUpCamera = function()
    
    Camera.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local camCoords = Config.CamCoords[CurrentScene][1]
    SetCamCoord(Camera.Cam, camCoords.x, camCoords.y, camCoords.z)
    SetCamRot(Camera.Cam, 0.0, 0.0, camCoords.w)

    SetCamActive(Camera.Cam, true)
    RenderScriptCams(true, false, 1, true, true)
end

Camera.DestroyCamera = function()
    RenderScriptCams(false, false, 0, true, true)
    DestroyCam(Camera.Cam, false)
end

Camera.StartCameraThread = function()
    CreateThread(function()
        Camera.CamActive = true
        while Camera.CamActive do
            Wait(1)

            DisableControlAction(0, 189, true) -- LEFT ARROW
            DisableControlAction(0, 190, true) -- RIGHT ARROW
            DisableControlAction(0, 191, true) -- ENTER
            DisableControlAction(0, 202, true) -- ESC / PAUSE
            DisableControlAction(0, 194, true) -- BACKSPACE
            DisableControlAction(0, 199, true) -- P / PAUSE

            HideHudAndRadarThisFrame()
        end
    end)
end