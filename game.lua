require "Menu/menu"
require "gameManager"

game = {}

local p

function game.load()
  menu.load()
  gameManager.load()
  game.setState(gameManager,3)
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

function game.goToMenu()
  game.setState(menu)
end
function game.goToGame()
  game.setState(gameManager)
end
function game.setState(state,...)
  game.curr_state = state
  state.start(...)
end