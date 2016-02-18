require "RPG_Full_Logo/RPG_Logo"
require "Game/game"
require "audioManager"
require "Menu/menu"

io.stdout:setvbuf("no")

local state

function love.load()
  audioManager.load()
  RPG_Logo.load(1.5,1.5,1.5,love.startGame)
  menu.load()
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

function love.startGame()
  state = game
  state.start()
end