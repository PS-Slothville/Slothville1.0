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
        TriggerServerEvent("ps-multi:SelectCharacter", CharacterData[Camera.SelectedChar].cid)
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
        TriggerServerEvent("ps-multi:DeleteCharacter", CharacterData[Camera.SelectedChar].cid)
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
            birthdate = response.birthdate,
            gender = tonumber(response.gender), -- 1 = Male, 0 = Female
            nationality = response.nationality,
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

RegisterCommand("fixfade", function()
    DoScreenFadeIn(500)
end)

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

RegisterNetEvent("ps-multi:SelectedChar", function(data)
    print(json.encode(data, {indent=true}))
    if CharacterData[Camera.SelectedChar] then
        DoScreenFadeOut(250)
        Wait(300)
        Camera.DestroyCamera()
        Peds.DestroyPeds()
        TriggerServerEvent("ps-multi:SelectCharacter", CharacterData[Camera.SelectedChar].cid)
        Camera.CamActive = false
        Camera.Cam = nil
        Camera.SelectedChar = 1
        Camera.PointingAtChar = 0
    else
        SendNUIMessage({ action = "OPEN" })
        SetNuiFocus(true, true)
    end
end)

local reopenMenu = false
local menuOpen = false
local MenuData = {}

-- RegisterNetEvent("ps-ui:menuClosed", function()
--     print(reopenMenu)
--     if reopenMenu and not menuOpen then
--         Wait(5000)
--         print(json.encode(MenuData))
--         exports['ps-ui']:CreateMenu(MenuData)
--         -- menuOpen = true
--     end
-- end)

RegisterCommand("multi-ui",function()
    MenuData = {
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 1,
            },
            server = false,
            subMenu = nil
            -- subMenu =  {
            --     {
            --         header= 'Submenu1',
            --         icon= 'fa-solid fa-circle-info',
            --         color= '#02f1b5',
            --         event = "ps-multi:SelectedChar",
            --         args = {
            --             slot = 1,
            --         },
            --     },

            -- },
        },
        {
            header = "Jays Character",
            text = "Select",
            icon = "fa-solid fa-circle",
            -- event = "ps-multi:SelectedChar",
            -- args = {
            --     slot = 2,
            -- },
            server = false,
            -- subMenu = nil
            subMenu =  {
                {
                    header= 'Spawn',
                    icon= 'fa-solid fa-plane',
                    color= '#02f1b5',
                    event = "ps-multi:SelectedChar",
                    args = {
                        slot = 2,
                    },
                },
                {
                    header= 'Delete',
                    icon= 'fa-solid fa-trash',
                    color= 'red',
                    event = "ps-multi:DeleteCharacterMenu",
                    args = {
                        slot = 2,
                    },
                },

            },
        },
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 3,
            },
            server = false,
            subMenu = nil
        },
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 4,
            },
            server = false,
            subMenu = nil
        },
    }
    print("open ne")
    exports['ps-ui']:CreateMenu(MenuData)

end)

RegisterNetEvent("ps-multi:LoadCharacters", function(chardata)
  
    MenuData = {
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 1,
            },
            server = false,
            subMenu = nil
            -- subMenu =  {
            --     {
            --         header= 'Submenu1',
            --         icon= 'fa-solid fa-circle-info',
            --         color= '#02f1b5',
            --         event = "ps-multi:SelectedChar",
            --         args = {
            --             slot = 1,
            --         },
            --     },

            -- },
        },
        {
            header = "Jays Character",
            text = "Select",
            icon = "fa-solid fa-circle",
            -- event = "ps-multi:SelectedChar",
            -- args = {
            --     slot = 2,
            -- },
            server = false,
            -- subMenu = nil
            subMenu =  {
                {
                    header= 'Spawn',
                    icon= 'fa-solid fa-plane',
                    color= '#02f1b5',
                    event = "ps-multi:SelectedChar",
                    args = {
                        slot = 2,
                    },
                },
                {
                    header= 'Delete',
                    icon= 'fa-solid fa-trash',
                    color= 'red',
                    event = "ps-multi:DeleteCharacterMenu",
                    args = {
                        slot = 2,
                    },
                },

            },
        },
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 3,
            },
            server = false,
            subMenu = nil
        },
        {
            header = "New Character",
            text = "Create a new character",
            icon = "fa-solid fa-circle",
            event = "ps-multi:SelectedChar",
            args = {
                slot = 4,
            },
            server = false,
            subMenu = nil
        },
    }
    
    for _,data in ipairs(chardata) do
        print(data.slot)
        if not MenuData[data.slot] then
    
        end
        

        -- MenuData[data.slot].cid = data.cid
        -- MenuData[data.slot].slot = data.slot
        -- MenuData[data.slot].charinfo = json.decode(data.charinfo)
        -- MenuData[data.slot].skin = json.decode(data.skin)
    end
    -- print("nom")
    exports['ps-ui']:CreateMenu(MenuData)
    reopenMenu = true
    Peds.SpawnPed(1)
end)

RegisterNetEvent("ps-multi:LoadCharacters", function(chardata)
    -- print("test")
    CharacterData = {}

    for _,data in ipairs(chardata) do
        -- print(data.slot)
        if not CharacterData[data.slot] then
            CharacterData[data.slot] = {}
        end
        CharacterData[data.slot].cid = data.cid
        CharacterData[data.slot].slot = data.slot
        CharacterData[data.slot].charinfo = json.decode(data.charinfo)
        CharacterData[data.slot].skin = json.decode(data.skin)
    end
    -- print("test1")

    local PositionsTaken = 0

    SetEntityCoords(PlayerPedId(), Config.HidePed[CurrentScene].x, Config.HidePed[CurrentScene].y, Config.HidePed[CurrentScene].z)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityAlpha(PlayerPedId(), 0.0, true)

    -- for i = 1, 4 do
    --     if CharacterData[i] then
    --         -- Load Chars
    --         local ped = Peds.SpawnPed(tonumber(CharacterData[i].slot), tonumber(CharacterData[i].charinfo.gender))
    --         -- exports['ps-appearance']:loadSkin(ped, CharacterData[i].skin)
    --         PositionsTaken = PositionsTaken + 1
    --         Wait(10)
    --     end
    -- end
    -- print("test2")

    -- if PositionsTaken < 4 then
    --     -- print("test5")
    --     for i = 1, 4 do
    --         -- print("test6")
    --         if not CharacterData[i] then
    --             -- print("test7")
    --             -- Unused Slots | Default Ped
    --             local ped = Peds.SpawnPed(i)
    --             -- print("aa")
    --         end
    --     end
    -- end
    -- print("test3")
-- 
    Camera.SetUpCamera()
    -- print("test4")

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
        -- TriggerEvent("ps-appearance:client:newPlayer")
        -- TriggerEvent("fivem-appearance:client:CreateFirstCharacter")
    end
end)

--#endregion
