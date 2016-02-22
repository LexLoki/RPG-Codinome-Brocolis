--  gameManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

gameManager = {}
function gameManager.load()
  gameManager.round = 1
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
  --love.graphics.print(math.ceil(dt), 640, 20)
  playerManager.update(dt)
  bulletManager.update(dt)
  timer = timer - dt
  arena.update(dt)
  --arena.update(dt,gameManager.players)
  if timer <= 0  then
    gameManager.round = gameManager.round + 1
    timer = 90
  end
  --[[
  if gameManager.round > 5 or #playerManager.getAlivePlayers() <= 1 then
    gameManager.round = 1
    game.goToWinnerScreen(n_players)
  end
  ]]
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(timer).."", 640, 20)
end

function gameManager.keypressed(key)
  playerManager.keypressed(key)
end