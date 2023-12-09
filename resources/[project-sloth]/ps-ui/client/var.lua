local open = false

RegisterNUICallback('var-callback', function(data, cb)
    print("triggered?")
	SetNuiFocus(false, false)
    Callbackk(data.success)
    open = false
    cb('ok')
end)

local function VarHack(callback, blocks, speed)
    if speed == nil or (speed < 2) then speed = 20 end
    if blocks == nil or (blocks < 1 or blocks > 15) then blocks = 5 end
    if not open then
        open = true
        Callbackk = callback
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "GameLauncher",
            data = {
                game = "NumberPuzzle",
                gameName = "NumberPuzzle",
                gameDescription = "Lorem ipsum is placceholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.",
                gameTime = 15,
                triggerEvent = 'var-callback',
                maxAnswersIncorrect = 2,
                amountOfAnswers = blocks,
                timeForNumberDisplay = 3,
            }
        })
        print("VarHack")
        SetNuiFocus(true, true)
    end
end

exports("VarHack", VarHack)

-- const numberPuzzleGameData = {
--     game: GamesEnum.NumberPuzzle,
--     gameName: 'Number Puzzle MiniGame',
--     gameDescription: 'Lorem ipsum is placeholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.',
--     gameTime: 30, // seconds 
--     maxAnswersIncorrect: 2,
--     amountOfAnswers: 5,
--     timeForNumberDisplay: 5, // seconds
--     triggerEvent: 'var-callback',
--   };