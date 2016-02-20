require "Menu/instruct"
require "Menu/menu"
require "Menu/playerSelection"

menuManager = {}

function menuManager.load()
  menu.load()
  instruct.load()
  playerSelection.load()
end

function menuManager.start(n_players)
  menuManager.setState(menu)
end

function menuManager.update(dt)
  menuManager.curr_state.update(dt)
end

function menuManager.draw()
  menuManager.curr_state.draw()
end

function menuManager.keypressed(key)
  menuManager.curr_state.keypressed(key)
end

function menu.mousepressed(x, y, button)
  menu.mousepressed(x, y, button)
end

function menuManager.goToPlayerSelection()
  menuManager.setState(playerSelection)
end
function menuManager.goToMenu()
  menuManager.setState(menu)
end
function menuManager.goToInstruct()
  menuManager.setState(instruct)
end
function menuManager.setState(state)
  menuManager.curr_state = state
  state.start()
end