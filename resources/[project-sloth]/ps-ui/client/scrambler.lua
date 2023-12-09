local open = false

RegisterNUICallback('scrambler-callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    open = false
    cb('ok')
end)

local function Scrambler(callback, type, time, mirrored)
    if type == nil then type = "alphabet" end
    if time == nil then time = 10 end
    if mirrored == nil then mirrored = 0 end

    if not open then
        Callbackk = callback
        open = true
        SendNUIMessage({
            action = "GameLauncher",
            data = {
                game = "Scramber",
                gameName = "Scrambler",
                gameDescription = "Lorem ipsum is placceholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.",
                amountOfAnswers = 4,
                gameTime = time,
                sets = type,
                triggerEvent = 'scrambler-callback',
                changeBoardAfter = 1,
            }
        })
        SetNuiFocus(true, true)
    end
end

-- game: GamesEnum.Scrambler,
-- gameName: 'Scrambler MiniGame',
-- gameDescription: 'Lorem ipsum is placeholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.',
-- amountOfAnswers: 4, // count of numbers to display
-- gameTime: 30, // seconds 
-- sets: 'numeric',  // numeric, alphabet, alphanumeric, greek, braille, runes
-- triggerEvent: 'scrambler-callback',
-- changeBoardAfter: 3 //seconds

exports("Scrambler", Scrambler)