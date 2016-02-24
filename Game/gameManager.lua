--  gameManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

gameManager = {}
function gameManager.load()
  gameManager.paused = false
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
  if not gameManager.paused then 
    --love.graphics.print(math.ceil(dt), 640, 20)
    playerManager.update(dt)
    bulletManager.update(dt)
    timer = timer - dt
    arena.update(dt)
    --gameManager.changeRound
    --arena.update(dt,gameManager.players)
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(timer).."", 640, 20)
  if gameManager.paused then
    love.graphics.setColor(0,0,0,100)
    love.graphics.rectangle("fill", 0,0, 1920, 1080)
  end
end

function gameManager.keypressed(key)
  if key == "return" then
    if gameManager.paused then
      gameManager.paused = false
    else
      gameManager.paused = true
    end
  end
  playerManager.keypressed(key)
  if key == "k" then
    game.goToWinnerScreen()
  end
end

function gameManager.changeRound(round, timer)
  if timer <= 0  or #playerManager.getAlivePlayers() <= 1 then
    round = round + 1
    timer = 90
    --gameManager.setRespawn()
  end
  if round > 5 then
    round = 1
    game.goToWinnerScreen()
  end
end