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
  timer = 9000
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
  timer = timer - 10*math.ceil(dt)
  arena.update(dt)
  --arena.update(dt,gameManager.players)
  if timer <= 0 then
    gameManager.round = gameManager.round + 1
    timer = 9000
  end
  if gameManager.round >= 5 then
    gameManager.round = 1
    --game.goToWinnerScreen(n_players)
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(timer/100).."", 640, 20)
end

function gameManager.keypressed(key)
  playerManager.keypressed(key)
end