require "Menu/buttonsWinner"

local winnerScreen = {}

function winnerScreen.load()
  buttonsWinner.load()
end

function winnerScreen.start()
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
      game.goToPlayerSelection()
    elseif buttonsWinner.pressed == 2 then
      game.goToMenuManager(n_players)
    else
      game.goToGameManager(2)
    end
  end
end
return winnerScreen
