--  gameManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/arena"
require "Player/playerManager"
require "Bullet/bulletManager"

local gameManager = {}
local arenaPos
local playersinf = {}
function gameManager.load(game)
  local n_players = 0
  gameManager.n_dead = 0
  gameManager.game = game
  gameManager.paused = false
  gameManager.round = 1
  gameManager.timer = 90
  arena.load(12,15)
  Player.load()
  bulletManager.load()
end
function gameManager.start(playersInfo)
  playersInf = playersInfo
  math.randomseed(os.time())
  playerManager.start(playersInfo)
  n_players = #(playerManager.list)
  audioManager.play(soundAssets[1].stage)
  local ax,ay = arena.tileSize.width+10, arena.tileSize.height+10
  local aw,ah = arena.width, arena.height
  arenaPos = {
    {x=ax,y=ay},
    {x=aw-ax-Player.width,y=ay},
    {x=ax,y=ah-ay-Player.height},
    {x=aw-ax-Player.width,y=ah-ay-Player.height}
  }
end

function gameManager.update(dt)
  if not gameManager.paused then 
    --love.graphics.print(math.ceil(dt), 640, 20)
    gameManager.timer = gameManager.timer - dt
    playerManager.update(dt)
    bulletManager.update(dt)
    arena.update(dt)
    gameManager.numberOfDeadPlayers()
    gameManager.n_dead = gameManager.numberOfDeadPlayers()
    --arena.update(dt,gameManager.players)
    if gameManager.n_dead >= (n_players - 1) or gameManager.timer <= 0 then
      gameManager.changeRound()
    end
    winner = gameManager.checkForWinner()
    if (winner ~= nil) then
      gameManager.game.goToWinnerScreen(playersInf, winner)
    end
  end
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  playerManager.draw(of)
  bulletManager.draw(of)
  if gameManager.paused then
    love.graphics.setColor(0,0,0,100)
    love.graphics.rectangle("fill", 0,0, 1920, 1080)
    love.graphics.setColor(255,255,255)
    love.graphics.print("PAUSED", love.graphics.getWidth()/2+50, 0.3*love.graphics.getHeight()/2, 0, 3, 3, (#"PAUSE")*20)
  else
    love.graphics.print("ROUND "..gameManager.round.." - "..math.ceil(gameManager.timer).."", love.graphics.getWidth()/2  , 0.005*love.graphics.getHeight(), 0, 1, 1, (#"ROUND 1 - 00")*10)
    love.graphics.print(n_players, 10, 400)
    love.graphics.print(gameManager.n_dead, 10, 450)
    for i, v in ipairs(playerManager.list) do
      love.graphics.print("Player"..i..": "..tostring(v.score), 1100, 300+50*i)
    end
    love.graphics.print(tostring(winner), 10, 500)
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
  if gameManager.timer <= 0 then
    gameManager.resetPlayersNoScore()
  else
    gameManager.resetPlayers()
  end
  gameManager.timer = 90
  
end
function gameManager.checkForWinner()
  for i,v in ipairs(playerManager.list) do
    if v.score >= 3 then
      return i
    end
  end
end
function gameManager.resetPlayers()
  for i, v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
      v.score = v.score + 1
    else
      v:setState(v.states.alive)
    end
    local p = arenaPos[i]
    v.x = p.x
    v.y = p.y
  end
end

function gameManager.resetPlayersNoScore()
  for i, v in ipairs(playerManager.list) do
    if v.curr_state:is_a(PlayerDeadState) then
      v:setState(v.states.alive)
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