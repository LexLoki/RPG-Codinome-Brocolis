require "Menu/buttonsWinner"

local winnerScreen = {}
local winner_index = 0 
local playersInfo = {}

function winnerScreen.load(game, menuManager)
  winnerScreen.game = game
  winnerScreen.menuManager = menuManager
  buttonsWinner.load()
end

function winnerScreen.start(playersInf, winner)
  winner_index = winner
  playersInfo = playersInf
  buttonsWinner.start()
  audioManager.play(audioManager.endMatchMusic)
end

function winnerScreen.update(dt)
  buttonsWinner.update(dt)
end

function winnerScreen.draw()
  love.graphics.print("And the winner is ...", 20, 20, 0, 2, 2)
  for i, v in ipairs(playerManager.list) do
    if i == winner_index then
      love.graphics.draw(playerIcon[v.id], 100, 300, 0, 2, 2)
    end
  end
  love.graphics.print(tostring(winner_index), 20, 20, 0, 2, 2)
  buttonsWinner.draw()
end

function winnerScreen.keypressed(key)
  buttonsWinner.keypressed(key)
  if key == "return" then
    if buttonsWinner.pressed == 1 then
      winnerScreen.menuManager.goToPlayerSelection()
    elseif buttonsWinner.pressed == 2 then
      winnerScreen.menuManager.goToMenu()
    else
      winnerScreen.game.goToGameManager(playersInfo)
    end
  end
end
return winnerScreen
