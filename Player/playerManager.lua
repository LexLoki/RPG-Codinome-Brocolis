--  playerManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

local player = require "Player/player"
local playerAssets = require "Player/playerAssets"
local playerIcon = require "Player/playerIcon"
playerManager = {}
playerManager.list = {}

local orderByHeight, sortDraw
local HpArt = love.graphics.newImage("/Assets/HUD/Heart_HUD_2.png")

playerManager.keys = {
  keyboard = {
    {left="left",up="up",right="right",down="down",attack=",",confirm="m"},
    {left="a",up="w",right="d",down="s",jump="space",attack="space",confirm="return"}
  },
  joy = {left="dpleft",up="dpup",right="dpright",down="dpdown",jump="dpju",attack="a",confirm="start"}
}


function playerManager.load()
  
end

function playerManager.start(players)
  for i,v in ipairs(players) do
    table.insert(playerManager.list,Player.new(i,bulletManager.randomBullet(),playerAssets[v.id],v.keys,playerIcon[v.id],v.joy))
  end
end

function playerManager.update(dt)
  for i,v in ipairs(playerManager.list) do
    v:update(dt)
  end
  arena.handleMovements(dt,playerManager.list)
end

function playerManager.keypressed(key)
  for i,v in ipairs(playerManager.list) do
    if v.joy == nil then v:keypressed(key) end
  end
end

function playerManager.gamepadpressed(joystick,button)
  for i,v in ipairs(playerManager.list) do
    if v.joy == joystick then
      v:keypressed(button)
    end
  end
end

function playerManager.draw(of)
  local players = sortDraw(playerManager.list)
  for i,v in ipairs(players) do
    --love.graphics.print(tostring(v.hp), 0 , i*50)
    --drawHud(HpArt)
    love.graphics.draw(v.icon, v.data[i].pos.x, v.data[i].pos.y)
    for j=1, v.hp do
      love.graphics.draw(HpArt,v.data[i].pos.x + 50*(j-1), v.data[i].pos.y)
    end
    v:draw(of)
    
  -- 50,0 
  end
end

function playerManager.killPlayer(player)
  for i,v in ipairs(playerManager.list) do
    if v==player then
      v = nil
      --table.remove(playerManager.list,i)
      --audioManager.playDeathSound()
      break
    end
  end
end

function playerManager.getAlivePlayers()
  local list = {}
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then table.insert(list,v) end
  end
  return list
end

function sortDraw(players)
  draw = {}
  for i,v in ipairs(players) do table.insert(draw,v) end
  table.sort(draw,orderByHeight)
  return draw
end

function orderByHeight(a,b)
  return a.y<b.y
end
function playerManager.getLastPlayer()
  local alive_players = {}  
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
      table.insert(alive_players,v)  
    end
  end
  return alive_players
end

function playerManager.getLastPlayer()
  local alive_players = {}  
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
      table.insert(alive_players,v)  
    end
  end
  return alive_players
end
--return playerManager
