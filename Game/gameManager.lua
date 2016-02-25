--  gameManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

local gameManager = {}
function gameManager.load(game)
  local playersinf = {}
  gameManager.game = game
  gameManager.paused = false
  gameManager.round = 1
  gameManager.timer = 90
  arena.load(12,15)
  Player.load()
  bulletManager.load()
end
function gameManager.start(playersInfo)
  table.remove(playerManager.list)
  playersInf = playersInfo
  math.randomseed(os.time())
  playerManager.start(playersInfo)
  audioManager.play(audioManager.stageMusic)
end

function gameManager.update(dt)
  if not gameManager.paused then 
    --love.graphics.print(math.ceil(dt), 640, 20)
    gameManager.timer = gameManager.timer - dt
    playerManager.update(dt)
    bulletManager.update(dt)
    arena.update(dt)
    gameManager.changeRound()
    --arena.update(dt,gameManager.players)
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(gameManager.timer).."", 640, 20)
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
    table.remove(playerManager.list)
    gameManager.game.goToWinnerScreen(playersInf)
  end
  --[[if key == "r" then
    table.remove(playerManager.list)
    gameManager.game.goToGameManager(playersInf)
  end]]
end

function gameManager.changeRound()
  if gameManager.timer <= 0 or #playerManager.getAlivePlayers() == 1 then
    gameManager.round = gameManager.round + 1
    gameManager.timer = 90
    table.remove(playerManager.list)
    gameManager.game.goToGameManager(playersInf)
    --gameManager.setRespawn()
  end
end

--[[function gameManager.setRespawn()
  local alive_players = playerManager.getLastPlayer()
  --last.score = last.score + 1
  for k,v in pairs(alive_players) do
    playerManager.killPlayer(v)
  end

  Player.load()
  bulletManager.load()
  timer = 10
  --playerManager.start(nPlayers)
  
end]]

function checkForWinner()
  for i,v in ipairs(playerManager.list) do
    if v.score == 5 then
      return v
    end
  end
end
return gameManager
