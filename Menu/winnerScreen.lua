require "Menu/buttonsWinner"
local playerIcon = require "Player/playerIcon"
local winnerScreen = {}
local winner_index = 0 
local playersInfo = {}

function winnerScreen.load(game, menuManager)
  winnerScreen.game = game
  winnerScreen.menuManager = menuManager
  background_img = love.graphics.newImage("Assets/Menu/background_character_select.png")
  buttonsWinner.load()
end

function winnerScreen.start(playersInf, winner)
  winner_index = winner
  playersInfo = playersInf
  buttonsWinner.start()
audioManager.playEndMatchSound()end

function winnerScreen.update(dt)
  buttonsWinner.update(dt)
end

function winnerScreen.draw()
  buttonsWinner.draw()
  love.graphics.print("And the winner is ...", 20, 20, 0, 2, 2)
  for i, v in ipairs(playerManager.list) do
    love.graphics.draw(playerIcon[v.id], 100, 300, 0, 1.5, 1.5)
  end
  love.graphics.print("Player "..tostring(winner_index),100, 600, 0, 2, 2)
end

function winnerScreen.keypressed(key)
  buttonsWinner.keypressed(key)
  if key == "return" then
    if buttonsWinner.pressed == 1 then
      winnerScreen.menuManager.goToPlayerSelection()
    elseif buttonsWinner.pressed == 2 then
      winnerScreen.menuManager.goToMenuManager()
    else
      winnerScreen.game.goToGameManager(playersInfo)
    end
  end
end
return winnerScreen
