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
  local n_players = 0
  gameManager.n_dead = 0
  gameManager.game = game
  gameManager.paused = false
  gameManager.round = 1
  gameManager.timer = 90
  gameManager.score = {0, 0, 0, 0}
  arena.load(12,15)
  Player.load()
  bulletManager.load()
end
function gameManager.start(playersInfo)
  playersInf = playersInfo
  math.randomseed(os.time())
  playerManager.start(playersInfo)
  n_players = #(playerManager.list)
  audioManager.play(audioManager.brocolisMusic)
end

function gameManager.update(dt)
  if not gameManager.paused then 
    --love.graphics.print(math.ceil(dt), 640, 20)
    gameManager.timer = gameManager.timer - dt
    playerManager.update(dt)
    bulletManager.update(dt)
    arena.update(dt)
    gameManager.n_dead = gameManager.numberOfDeadPlayers()
    --arena.update(dt,gameManager.players)
    if gameManager.n_dead >= (n_players - 1) or gameManager.timer <= 0 then
      gameManager.changeRound()
    end
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(gameManager.timer).."", love.graphics.getWidth()/2, 0.005*love.graphics.getHeight(), 0, 1, 1, (#"ROUND 1 - 00")*10)
  love.graphics.print(n_players, 10, 400)
  love.graphics.print(gameManager.numberOfDeadPlayers(), 10, 450)
  for i, v in ipairs(playerManager.list) do
    love.graphics.print(tostring(v.score), 1100, 300+50*i)
  end
  if gameManager.paused then
    love.graphics.setColor(0,0,0,100)
    love.graphics.rectangle("fill", 0,0, 1920, 1080)
    love.graphics.setColor(255,255,255)
    love.graphics.print("PAUSED", love.graphics.getWidth()/2, 0.3*love.graphics.getHeight()/2, 0, 3, 3, (#"PAUSE")*20)
  end
  love.graphics.setColor(255,255,255)
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
  for i,v in ipairs(playerManager.list) do
    if v.score >= 3 then
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
  gameManager.round = gameManager.round + 1
  gameManager.timer = 90
  death_timer = 1
  gameManager.resetPlayers()
end
function checkForWinner()
  for i,v in ipairs(playerManager.list) do
    if v.score >= 3 then
      return v
    end
  end
end
function gameManager.resetPlayers()
  for i, v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
      v.curr_state = v.states.dead
      v.hp = 4
      v.score = v.score + 1
      v.curr_state = v.states.alive
    else
      v.curr_state = v.states.alive
      v.hp = 4
    end
  end
end

function gameManager.numberOfDeadPlayers()
  local n_dead = 0
  for i, v in ipairs (playerManager.list) do
    if v.curr_state:is_a(PlayerDeadState) and v.curr_animation.animComp.finished then
      n_dead = n_dead + 1
    end
  end
  return n_dead
end
return gameManager
