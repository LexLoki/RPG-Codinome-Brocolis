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
  gameManager.score = {0, 0, 0, 0}
  death_timer = 1
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
    if #playerManager.getAlivePlayers() == 1 and #animations.list == 0 then
      death_timer = death_timer - dt
      for i,v in ipairs(playerManager.getAlivePlayers()) do
        v.score = v.score + 1
        gameManager.score[v.index] = gameManager.score[v.index]+ v.score
      end
    end
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(gameManager.timer).."", 640, 20)
  love.graphics.print(#animations.list, 20, 20)
  for i, v in ipairs(playerManager.getAlivePlayers()) do
    love.graphics.print(tostring(v.score) + gameManager.score[i], 1400, 300+50*i)
  end
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
  for i,v in ipairs(playerManager.getAlivePlayers()) do
    if key == "k" or v.score >= 3 then
      gameManager.game.goToWinnerScreen(playersInf, checkForWinner())
    end
  end
  --[[if key == "r" then
    table.remove(playerManager.list)
    gameManager.game.goToGameManager(playersInf)
  end]]
end

function gameManager.gamepadpressed(joystick,button)
  playerManager.gamepadpressed(joystick,button)
end

function gameManager.changeRound()
  if (gameManager.timer <= 0 or death_timer <= 0) then
    gameManager.round = gameManager.round + 1
    gameManager.timer = 90
    table.remove(playerManager.list)
    gameManager.game.goToGameManager(playersInf)
    --gameManager.setRespawn()
    death_timer = 1
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
    if v.score == 3 then
      return v
    end
  end
end
return gameManager
