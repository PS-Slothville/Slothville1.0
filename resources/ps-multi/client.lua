CharacterData = {}

CurrentScene = 1

--#region Undefined Natives
local function NativeHasPedComponentLoaded(ped)
    return 
end

local function NativeUpdatePedVariation(ped)
   
    while not NativeHasPedComponentLoaded(ped) do
        Wait(1)
    end
end

local function NativeSetPedComponentEnabled(ped, componentHash, immediately, isMp)
 
    NativeUpdatePedVariation(ped)
end
--#endregion

-- Begin the process of loading characters after loading screen is done
CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() then
            DoScreenFadeOut(500)
            Wait(500)
            TriggerServerEvent("ps-framework:LoadCharacters")
            CurrentScene = math.random(1, 3)
            return
        end
    end
end)

if GlobalState.FrameworkConfig.Player.CanLogout then
    RegisterCommand("logout", function()
        local plyState = LocalPlayer.state
        if plyState.isLoggedIn then
            Camera.Cam = nil
            Camera.SelectedChar = 1
            Camera.PointingAtChar = 0
            DoScreenFadeOut(500)
            Wait(500)
            TriggerServerEvent("ps-framework:Logout")
            TriggerEvent("ps-framework:Logout")
            TriggerServerEvent("ps-framework:LoadCharacters")
            return
        end
    end)
end

AddEventHandler('onResourceStop', function(resName)
    if resName ~= GetCurrentResourceName() then return end

    Camera.DestroyCamera()
    Peds.DestroyPeds()
end)

--#region Functions

CharacterSelected = function()
    if CharacterData[Camera.SelectedChar] then
        DoScreenFadeOut(250)
        Wait(300)
        Camera.DestroyCamera()
        Peds.DestroyPeds()
        TriggerServerEvent("ps-multi:SelectCharacter", CharacterData[Camera.SelectedChar].citizenid)
        Camera.CamActive = false
        Camera.Cam = nil
        Camera.SelectedChar = 1
        Camera.PointingAtChar = 0
    else
        SendNUIMessage({ action = "OPEN" })
        SetNuiFocus(true, true)
    end
end

DeleteCharacter = function()
    if CharacterData[Camera.SelectedChar] then
        SendNUIMessage({ action = "OPEN_CONFIRMDELETE" })
        SetNuiFocus(true, true)
    else
        Camera.StartCameraThread()
        return
    end
end

--#endregion

--#region NUI Callbacks

RegisterNUICallback("CloseConfirm", function(response)
    SetNuiFocus(false, false)
    if not response then
        Camera.StartCameraThread()
        return
    end

    if response.confirm == true then
        TriggerServerEvent("ps-multi:DeleteCharacter", CharacterData[Camera.SelectedChar].citizenid)
    else
        Camera.StartCameraThread()
    end
end)

RegisterNUICallback("CloseNUI", function(response)
    SetNuiFocus(false, false)
    if not response then
        Camera.StartCameraThread()
        return
    end

    if response.firstname then
        local info = {
            firstname = response.firstname, -- Default name
            lastname = response.lastname, -- Default name
            birthdate = response.birthdate
            gender = tonumber(response.gender), -- 1 = Male, 0 = Female
            nationality = response.nationality
        }
    
        DoScreenFadeOut(250)
        Wait(300)
        Camera.DestroyCamera()
        Peds.DestroyPeds()
        Camera.CamActive = false

        TriggerServerEvent("ps-multi:CreateCharacter", info, Camera.SelectedChar)
    else
        Camera.StartCameraThread()
    end
end)

RegisterNUICallback("ChangeGender", function(response)
    Peds.DestroyPed(Camera.SelectedChar)
    local ped = Peds.SpawnPed(Camera.SelectedChar, response.gender)
    -- local Components = exports['ps-appearance']:getSkinData()

    if response.gender == 1 then
        -- MALE
    else
        -- FEMALE
    end
    NativeUpdatePedVariation(ped)
end)

--#endregion

--#region Net Events

RegisterNetEvent("ps-multi:CharacterDeleted", function()
    DoScreenFadeOut(500)
    Wait(500)
    ClearFocus()
    Camera.DestroyCamera()
    Peds.DestroyPeds()
    Camera.CamActive = false
    Camera.Cam = nil
    Camera.SelectedChar = 1
    Camera.PointingAtChar = 0
    TriggerServerEvent("ps-framework:LoadCharacters")
end)

RegisterNetEvent("ps-multi:LoadCharacters", function(chardata)
    CharacterData = {}

    for _,data in ipairs(chardata) do
        if not CharacterData[data.slot] then
            CharacterData[data.slot] = {}
        end
        CharacterData[data.slot].citizenid = data.citizenid
        CharacterData[data.slot].slot = data.slot
        CharacterData[data.slot].charinfo = json.decode(data.charinfo)
        CharacterData[data.slot].skin = json.decode(data.skin)
    end

    local PositionsTaken = 0

    SetEntityCoords(PlayerPedId(), Config.HidePed[CurrentScene].x, Config.HidePed[CurrentScene].y, Config.HidePed[CurrentScene].z)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityAlpha(PlayerPedId(), 0.0, true)

    for i = 1, 4 do
        if CharacterData[i] then
            -- Load Chars
            local ped = Peds.SpawnPed(tonumber(CharacterData[i].slot), tonumber(CharacterData[i].charinfo.gender))
            -- exports['ps-appearance']:loadSkin(ped, CharacterData[i].skin)
            PositionsTaken = PositionsTaken + 1
            Wait(10)
        end
    end

    if PositionsTaken < 4 then
        for i = 1, 4 do
            if not CharacterData[i] then
                -- Unused Slots | Default Ped
                local ped = Peds.SpawnPed(i)
                
            end
        end
    end

    Camera.SetUpCamera()

    Wait(100)
    DoScreenFadeIn(500)

    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end

    Camera.StartCameraThread()
end)

RegisterNetEvent("ps-multi:CharacterSelected", function(playerdata, newplayer)
    -- exports['ps-appearance']:RequestAndSetModel(playerdata.charinfo.gender == 1 and "mp_m_freemode_01" or "mp_f_freemode_01")
    Wait(10)

    ClearFocus()

    -- exports['ps-appearance']:loadSkin(PlayerPedId(), playerdata.skin)

    if not newplayer then
        local position = playerdata.position
        local SpawnPosition = vector3(position.x, position.y, position.z)
        SetEntityCoords(PlayerPedId(), SpawnPosition.x, SpawnPosition.y, SpawnPosition.z - 1.0)

        TriggerEvent("wicked-spawn:client:SpawnAtPosition", SpawnPosition)

        FreezeEntityPosition(PlayerPedId(), false)
        DoScreenFadeIn(500)
    else
        -- create character then open spawn menu
        TriggerEvent("ps-appearance:client:newPlayer")
    end
end)

--#endregion
