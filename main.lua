require "RPG_Full_Logo/RPG_Logo"
require "Game/game"
require "audioManager"
require "Menu/menu"

io.stdout:setvbuf("no")

local state

function love.load()
  fonte = love.graphics.setNewFont("Assets/game_over.ttf", 100)
  love.graphics.setFont(fonte)
  audioManager.load()
  RPG_Logo.load(1.5,1.5,1.5,love.startGame)
  menu.load()
  game.load()
  state = RPG_Logo
end
function love.update(dt)
  state.update(dt)
end
function love.draw()
  state.draw()
end
function love.keypressed(key)
  state.keypressed(key)
end
function menu.mousepressed(x, y, button)
  game.mousepressed(x, y, button)
end
function love.startGame()
  state = game
  state.start()
end