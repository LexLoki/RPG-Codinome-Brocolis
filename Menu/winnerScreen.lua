require "Menu/buttonsWinner"

local winnerScreen = {}

function winnerScreen.load(game)
  winnerScreen.game = game
  local playersInfo = {}
  buttonsWinner.load()
end

function winnerScreen.start(playersInf, winner)
  playerWin = {}
  playerWin = winner
  playersInfo = playersInf
  buttonsWinner.start()
  audioManager.play(audioManager.endMatchMusic)
end

function winnerScreen.update(dt)
  buttonsWinner.update(dt)
end

function winnerScreen.draw()
  love.graphics.print("And the winner is ...", 20, 20, 0, 2, 2)
  for i, v in ipairs(playerWin) do
    love.graphics.draw(playerIcon[v.id], 100, 300, 0, 2, 2)
  end
  buttonsWinner.draw()
end

function winnerScreen.keypressed(key)
  buttonsWinner.keypressed(key)
  if key == "return" then
    if buttonsWinner.pressed == 1 then
      table.remove(playerManager.list)
      winnerScreen.game.goToPlayerSelection()
    elseif buttonsWinner.pressed == 2 then
      table.remove(playerManager.list)
      winnerScreen.game.goToMenuManager(n_players)
    else
      table.remove(playerManager.list)
      winnerScreen.game.goToGameManager(playersInfo)
    end
  end
end
return winnerScreen
