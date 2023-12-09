-- function CreateKeybind(command, press, release, category, description, device, bind)
--     print(command, press, release, category, description, device, bind)
--     local invokingResource = GetInvokingResource()
    
--     if not device then device = "keyboard" end

--     local alreadyExist = Storage.Keybind[command]
--     if not alreadyExist then 
--         Storage.Keybind[command] = invokingResource
--     elseif alreadyExist then 
--         return print(("[%s] Keybind %s exists in %s"):format(invokingResource, command, alreadyExist))
--     end

--     if not command then 
--         return print(("[%s] Invalid Usage (No Command)"):format(invokingResource))
--     end

--     if not press then 
--         print(("[%s] Invalid Usage (No Press Function) | YOU CAN IGNORE THIS ERROR"):format(invokingResource))
--     end
    
--     if not release then 
--         print(("[%s] Invalid Usage (No Release Function) | YOU CAN IGNORE THIS ERROR"):format(invokingResource))
--     end

--     if not category then
--         return print(("[%s] Invalid Usage (No Category)"):format(invokingResource))
--     end

--     if not description then
--         return print(("[%s] Invalid Usage (No Description)"):format(invokingResource))
--     end
   
--     local str_command = ('(%s) %s'):format(category, description)
--     local keybindPress = ("+ps_util__%s"):format(command)
--     local keybindRelease = ("-ps_util__%s"):format(command)

--     RegisterCommand(keybindPress, press)
--     TriggerEvent('chat:removeSuggestion', keybindPress)

--     RegisterCommand(keybindRelease, release)
--     TriggerEvent('chat:removeSuggestion', keybindRelease)

--     if not bind then 
--         RegisterKeyMapping(keybindPress, str_command, device)
--     else
--         RegisterKeyMapping(keybindPress, str_command, device, bind)
--     end
-- end exports("CreateKeybind", CreateKeybind)

function CreateKeybind(cmd, emit, onPress, onRelease, category, description, device, bind)

    local invokingResource = GetInvokingResource() or "server_trigger"
    print(invokingResource)
    if not cmd then 
        print("No valid cmd")
        return
    end

    if not onPress then 
        print("No valid onpress")
        return
    end

    if not onRelease then 
        print("No valid onrelease")
        return
    end

    if not category then 
        print("No valid category")
        return
    end

    if not description then 
        print("No valid category")
        return
    end

    if not device then 
        device = "keyboard"
    end

    if not bind then 
        bind = ""
    end

    print(cmd, emit, onPress, onRelease, category, description, device, bind)


    local str_cmd = ('(%s) %s'):format(category, description)
    local keybindPress = ("+ps_util__%s"):format(cmd)
    local keybindRelease = ("-ps_util__%s"):format(cmd)

    RegisterCommand(keybindPress, function()
        if emit then 
            TriggerEvent("keybind:onPress", cmd)
        end
        onPress()
    end)

    RegisterCommand(keybindRelease, function()
        if emit then 
            TriggerEvent("keybind:onRelease", cmd)
        end
        onRelease()
    end)

    RegisterKeyMapping(keybindPress, str_cmd, device, bind)


end exports("CreateKeybind", CreateKeybind)

function GetKeybind(command)
    local keybindPress = ("+ps_util__%s"):format(command)
    local keybind = pBindString(2, GetHashKey(keybindPress) | 0x80000000, true)
    return keybind
end exports("GetKeybind", GetKeybind)

CreateThread(function()
    exports['ps-utils']:CreateKeybind("keybindtest", true, function()
        print("in")
    end, function()
        print("out")
    end, "Test", "Test 2")
end)
