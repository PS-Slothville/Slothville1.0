local open = false
local p = nil

local correctBlocksBasedOnGrid = {
    [5] = 10,
    [6] = 14,
    [7] = 18,
    [8] = 20,
    [9] = 24,
    [10] = 28,
}

RegisterNUICallback('thermite-callback', function(data, cb)
    
	SetNuiFocus(false, false)
    p:resolve(data.success)
    p = nil
    open = false
    cb('ok')
end)

local function Thermite(cb, time, gridsize, wrong, correctBlocks)
    if not open then
        p = promise.new()
        if time == nil then time = 10 end
        if gridsize == nil then gridsize = 6 end
        if wrong == nil then wrong = 3 end
        open = true
        SendNUIMessage({
            action = "GameLauncher",
            data = {
                game = "MemoryGame",
                gameName = "Memory Game",
                gameDescription = "Lorem ipsum is placceholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.",
                amountOfAnswers = correctBlocks or correctBlocksBasedOnGrid[gridsize],
                gameTime = time,
                maxAnswersIncorrect = wrong,
                displayInitialAnswersFor = 3,
                gridSize = gridsize, --5,6,7,8,9,10 - one of these values as number of rows and columns
                triggerEvent = 'thermite-callback',
            }
        })
        SetNuiFocus(true, true)
        local result = Citizen.Await(p)
        cb(result)
    end
end

exports("Thermite", Thermite)

-- export enum GamesEnum {
-- 	Scrambler = 'Scramber',
-- 	NumberMaze = 'NumberMaze',
-- 	Memory = 'MemoryGame',
-- 	NumberPuzzle = 'NumberPuzzle',
-- }


-- const memoryGameData = {
--     game: GamesEnum.Memory,
--     gameName: 'Memory MiniGame',
--     gameDescription: 'Lorem ipsum is placceholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.',
--     amountOfAnswers: 9,
--     gameTime: 30, // seconds 
--     maxAnswersIncorrect: 0,
--     displayInitialAnswersFor: 5, //seconds
--     triggerEvent: 'memorygame-callback',
--   };
