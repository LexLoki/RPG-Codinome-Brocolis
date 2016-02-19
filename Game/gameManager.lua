--  gameManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

gameManager = {}
function gameManager.load()
  arena.load(12,15)
  Player.load()
  bulletManager.load()
  timer = 90
end

function gameManager.start(nPlayers)
  math.randomseed(os.time())
  playerManager.start(nPlayers)
  audioManager.play(audioManager.stageMusic)
end

function gameManager.update(dt)
  playerManager.update(dt)
  bulletManager.update(dt)
  timer = timer - math.ceil(dt)
  arena.update(dt)
  --arena.update(dt,gameManager.players)
end

function gameManager.draw()
  arena.draw()
  love.graphics.print(math.ceil(timer), 640, 20)
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
end

function gameManager.keypressed(key)
  playerManager.keypressed(key)
end