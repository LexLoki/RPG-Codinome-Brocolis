require "RPG_Full_Logo/RPG_Logo"
require "Game/game"
require "audioManager"

io.stdout:setvbuf("no")

local state

function love.load()
  RPG_Logo.load(1.5,1.5,1.5,love.startGame)
  game.load()
  state = RPG_Logo
  audioManager.load()
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
end