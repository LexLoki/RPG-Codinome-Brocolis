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
    gameManager.changeRound(gameManager.round,timer)
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
  if key == "r" then
    --gameManager.setRespawn()
  end
end

function gameManager.changeRound(Gameround, timer)
  local round = Gameround
  
  --if checkForWinner() ~= nil then
   
  --end
  if timer <= 0  or #playerManager.getAlivePlayers() == 1 then
    round = round + 1
    timer = 90
    gameManager.setRespawn()
  end
  gameManager.round = round
  
end

function gameManager.setRespawn()
   local alive_players = playerManager.getLastPlayer()
   --last.score = last.score + 1
   for k,v in pairs(alive_players) do
       playerManager.killPlayer(v)
   end

  Player.load()
  bulletManager.load()
  timer = 90 
  playerManager.start(nPlayers)
  
end

function checkForWinner()
  local winner
  for i,v in ipairs(playerManager.list) do
    if v.score == 5 then
    winner = v
    return winner
    end
  end
end
return gameManager
