

-- Number Maze
RegisterCommand("maze",function()
    exports['ps-ui']:Maze(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 20) -- Hack Time Limit
end) 

-- VAR
RegisterCommand("var", function()
    exports['ps-ui']:VarHack(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 6, 10) -- Number of Blocks, Time (seconds)
end)

-- CIRCLE
RegisterCommand("circle", function()
    exports['ps-ui']:Circle(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 2, 20) -- NumberOfCircles, MS
end)

-- THERMITE
RegisterCommand("thermite", function()
    exports['ps-ui']:Thermite(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 10, 7, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks
end)

-- SCRAMBLER
RegisterCommand("scrambler", function()
    exports['ps-ui']:Scrambler(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, "numeric", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )
end)

-- Number Up
RegisterCommand("numberup", function()
    exports['ps-ui']:NumberUp(function(success)
        if success then
            print("success")
		else
			print("fail")
		end
    end, 5, 30, 15, 2) -- GridSize (number), Time (Seconds), shuffleTime (Seconds), lifes(number)
end)

-- DISPLAY TEXT
RegisterCommand("display", function()
    exports['ps-ui']:DisplayText("Example Text [E]", "success") -- Colors: primary, error, success, warning, info, mint
end)

RegisterCommand("hide", function()
    exports['ps-ui']:HideText()
end)


local status = false
RegisterCommand("showstatus", function()
    if not status then
        status = true
        exports['ps-ui']:StatusShow("Area Dominance", "This is a test Description", "fa-solid fa-circle-info", 
        {
            {key = "Gang", value = "Ballas"}, {key = "Area", value = "Strawberry"}, {key = "Time", value = "10:00"}
        })
    else 
        status = false
        exports['ps-ui']:StatusHide()
    end
end)


RegisterCommand("cmenu", function()
    exports['ps-ui']:CreateMenu({
        {
            header = "header1",
            text = "text1",
            icon = "fa-solid fa-circle",
            color = "red",
            event = "event:one",
            args = {
                1,
                "two",
                "3",
            },
            server = false,
            -- subMenu = nil
            subMenu =  {
                {
                    header= 'Submenu1',
                    icon= 'fa-solid fa-circle-info',
                    color= '#02f1b5',
                    event = "event:one",
                    args = {
                        1,
                        "two",
                        "3",
                    },
                },

            },
            
        },
    })
end)

RegisterCommand("input", function()
    local input = exports['ps-ui']:Input(
        {
            {
                id = '1',
                label= 'Name',
                type = "text",
                -- placeholder = "test2",
                icon = "fa-solid fa-pen"
            },
            {
                id = '2',
                label= 'Password',
                type = "password",
                -- placeholder = "password",
                icon = "fa-solid fa-lock"
            },
            {
                id = '3',
                label= 'Phone Number',
                type = "number",
                -- placeholder = "666",
                icon = "fa-solid fa-phone"
            },
        
    })
    for k,v in pairs(input) do 
        print(k,v.id, v.value)
    end
end)

RegisterCommand("showimage", function()
    exports['ps-ui']:ShowImage("https://user-images.githubusercontent.com/91661118/168956591-43462c40-e7c2-41af-8282-b2d9b6716771.png")
end)