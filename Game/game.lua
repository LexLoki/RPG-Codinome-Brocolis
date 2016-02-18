require "Menu/menuManager"
require "Game/gameManager"

game = {}

local nPlayers = 0


function game.start()
  game.curr_state = menuManager
  menuManager.start(nPlayers)
  gameManager.start(nPlayers)
end
function game.load()
  menuManager.load()
  gameManager.load()
end

function game.update(dt)
  game.curr_state.update(dt)
end

function game.draw()
  game.curr_state.draw()
end

function game.keypressed(key)
  game.curr_state.keypressed(key)
end

function game.goToMenuManager()
  game.setState(menuManager)
end
function game.goToGameManager()
  game.setState(gameManager)
end
function game.setState(state)
  game.curr_state = state
  state.start()
end