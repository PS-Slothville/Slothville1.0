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
        while true do
            Wait(1)

            -- Point the camera at the selected ped
            if Camera.PointingAtChar ~= Camera.SelectedChar then
                Camera.PointingAtChar = Camera.SelectedChar
                
                for _, ped in pairs(Peds.PedList) do
                    if GetEntityAlpha(ped) ~= 100 then
                        SetEntityAlpha(ped, 100, false)
                    end
                end

                local camCoords = Config.CamCoords[CurrentScene][Camera.SelectedChar]
                SetCamParams(Camera.Cam, camCoords.x, camCoords.y, camCoords.z, 0.0, 0.0, camCoords.w, GetGameplayCamFov(), 500, 1.0, 2, 1)
                Wait(500)
            end

            -- Set the alpha of the entity the camera is pointing at
            if GetEntityAlpha(Peds.PedList[Camera.PointingAtChar]) ~= 255 then
                SetEntityAlpha(Peds.PedList[Camera.PointingAtChar], 255, false)
                SetFocusEntity(Peds.PedList[Camera.PointingAtChar])
            end

            -- Make sure all other peds are not transparent
            for _, ped in pairs(Peds.PedList) do
                if ped ~= Peds.PedList[Camera.PointingAtChar] then
                    if GetEntityAlpha(ped) ~= 100 then
                        SetEntityAlpha(ped, 100, false)
                    end
                end
            end

            DisableControlAction(0, 189, true) -- LEFT ARROW
            DisableControlAction(0, 190, true) -- RIGHT ARROW
            DisableControlAction(0, 191, true) -- ENTER
            DisableControlAction(0, 202, true) -- ESC / PAUSE
            DisableControlAction(0, 194, true) -- BACKSPACE
            DisableControlAction(0, 199, true) -- P / PAUSE

            HideHudAndRadarThisFrame()

            local text = "<- Create Character ->"
            if CharacterData[Camera.SelectedChar] then
                text = ("<- %s %s ->"):format(CharacterData[Camera.SelectedChar].charinfo.firstname, CharacterData[Camera.SelectedChar].charinfo.lastname)
                DrawText2D("[~COLOR_RED~BACKSPACE~q~] TO DELETE", 0.50, 0.85, 0.5, 0.5, 0.6, 255, 255, 255, 255, true)

                -- Delete the character slot
                if IsDisabledControlJustReleased(0, 194) then
                    DeleteCharacter()
                    return
                end
            end
            
            DrawText2D(text, 0.50, 0.75, 0.5, 0.5, 0.6, 255, 255, 255, 255, true)
            DrawText2D("[~COLOR_GOLD~ENTER~q~] TO SELECT", 0.50, 0.80, 0.5, 0.5, 0.6, 255, 255, 255, 255, true)


            -- Change the selected ped left
            if IsDisabledControlJustReleased(0, 189) then
                if Camera.SelectedChar == 1 then
                    Camera.SelectedChar = 4
                else
                    Camera.SelectedChar = Camera.SelectedChar - 1
                end
            end

            -- Change the selected ped right
            if IsDisabledControlJustReleased(0, 190) then
                if Camera.SelectedChar == 4 then
                    Camera.SelectedChar = 1
                else
                    Camera.SelectedChar = Camera.SelectedChar + 1
                end
            end

            -- Select the character slot
            if IsDisabledControlJustReleased(0, 191) then
                CharacterSelected()
                return
            end
        end
    end)
end