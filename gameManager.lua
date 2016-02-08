require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

gameManager = {}

function gameManager.load()
  arena.load(12,16)
  Player.load()
end

function gameManager.start(nPlayers)
  playerManager.start(nPlayers)
end

function gameManager.update(dt)
  playerManager.update(dt)
  bulletManager.update(dt)
  --arena.update(dt,gameManager.players)
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
end

function gameManager.keypressed(key)
  playerManager.keypressed(key)
end