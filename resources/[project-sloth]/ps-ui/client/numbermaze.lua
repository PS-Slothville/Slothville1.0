local open = false

RegisterNUICallback('maze-callback', function(data, cb)
	SetNuiFocus(false, false)
    Callback(data.success)
    open = false
    cb('ok')
end)

local function Maze(callback, speed)
    if speed == nil then speed = 10 end
    if not open then
        Callback = callback
        open = true
        SendNUIMessage({
            action = "GameLauncher",
            data = {
                game = "NumberMaze",
                gameName = "NumberMaze",
                gameDescription = "Lorem ipsum is placceholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.",
                gameTime = speed,
                triggerEvent = 'maze-callback',
                maxAnswersIncorrect = 2,
            }
        })
        SetNuiFocus(true, true)
    end
end

exports("Maze", Maze)


-- const numberMazeGameData = {
--     game: NumberMaze,
--     gameName: 'Number Maze MiniGame',
--     gameDescription: 'Lorem ipsum is placeholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.',
--     gameTime: 30, // seconds 
--     maxAnswersIncorrect: 2,
--     triggerEvent: 'maze-callback',
--   };