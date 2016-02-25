require "Menu/buttonsWinner"

local winnerScreen = {}

function winnerScreen.load(game)
  winnerScreen.game = game
  local playersInfo = {}
  buttonsWinner.load()
end

function winnerScreen.start(playersInf)
  playersInfo = playersInf
  buttonsWinner.start()
end

function winnerScreen.update(dt)
  buttonsWinner.update(dt)
end

function winnerScreen.draw()
  love.graphics.print("And the winner is ...", 100, 300, 0, 2, 2)
  buttonsWinner.draw()
end

function winnerScreen.keypressed(key)
  buttonsWinner.keypressed(key)
  if key == "return" then
    if buttonsWinner.pressed == 1 then
      winnerScreen.game.goToPlayerSelection()
    elseif buttonsWinner.pressed == 2 then
      winnerScreen.game.goToMenuManager(n_players)
    else
      winnerScreen.game.goToGameManager(playersInfo)
    end
  end
end
return winnerScreen
