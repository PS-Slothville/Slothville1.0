local open = false

RegisterNUICallback('numberup-callback', function(data, cb)
	SetNuiFocus(false, false)
    Callback(data.success)
    open = false
    cb('ok')
end)

local function NumberUp(callback, size, time, shuffleTime, lifes)
    if size == nil then size = 5 end
    if time == nil then time = 30 end
    if shuffleTime == nil then shuffleTime = 13 end
    if lifes == nil then lifes = 3 end
    if not open then
        Callback = callback
        open = true
        SendNUIMessage({
            action = "GameLauncher",
            data = {
                game = "NumberUp",
                gameName = "Number Up MiniGame",
                gameDescription = "Lorem ipsum is placeholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.",
                gameTime = time,
                gameShuffleTime = shuffleTime,
                gameLifes = lifes,
                gameSize = size,
                triggerEvent = 'numberup-callback',
            }
        })
        SetNuiFocus(true, true)
    end
end

exports("NumberUp", NumberUp)

--[[
    const NumberUpGameData = {
      game: GamesEnum.NumberUp,
      gameName: 'Number Up MiniGame',
      gameDescription: 'Lorem ipsum is placeholder text commonly used in the arachic, print and publishing industries for previewing layouts and visual mockups.',
      gameTime: 30, // seconds
      gameShuffleTime: 13, // seconds
      gameLifes: 1,
      gameSize: 5, // this * its self to make the max number
      triggerEvent: 'numberup-callback',
    };
]]