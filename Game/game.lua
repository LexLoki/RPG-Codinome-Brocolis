require "Menu/menuManager"
require "Game/gameManager"
require "Menu/winnerScreen"
require "Menu/playerSelection"
game = {}

function game.start()
  game.curr_state = menuManager
  menuManager.start()
end
function game.load()
  menuManager.load()
  gameManager.load()
  winnerScreen.load()
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
function game.mousepressed(x, y, button)
  menuManager.mousepressed(x, y, button)
end
function game.goToMenuManager(n_players)
  game.setState(menuManager, n_players)
end
function game.goToGameManager(n_players)
  game.setState(gameManager,n_players)
end
function game.goToWinnerScreen(n_players)
  game.setState(winnerScreen,n_players)
end
function game.goToPlayerSelection()
  game.setState(playerSelection)
end
function game.setState(state,n_players)
  game.curr_state = state
  state.start(n_players)
end