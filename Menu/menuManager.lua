require "Menu/instruct"
require "Menu/menu"
require "Menu/playerSelection"

menuManager = {}

function menuManager.load()
  menu.load()
  instruct.load()
  playerSelection.load()
end

function menuManager.start(nPlayers)
  menu.curr_state = menu
  menu.start(nPlayers)
  instruct.start()
  playerSelection.start(nPlayers)
end

function menuManager.update(dt)
  menu.curr_state.update(dt)
end

function menuManager.draw()
  menu.curr_state.draw()
end

function menuManager.keypressed(key)
  menu.curr_state.keypressed(key)
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