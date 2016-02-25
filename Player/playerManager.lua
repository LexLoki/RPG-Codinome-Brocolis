--  playerManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

local player = require "Player/player"
local playerAssets = require "Player/playerAssets"

playerManager = {}
playerManager.list = {}

local orderByHeight, sortDraw
local pirataMaroto = love.graphics.newImage("/Assets/HUD/pirata_placeholder.png")
local CptRubi = love.graphics.newImage("/Assets/HUD/Capita_Rubi_HUD.png")
local Magno = love.graphics.newImage("/Assets/HUD/Magnolio_HUD_2.png")
local Qsort = love.graphics.newImage("/Assets/HUD/Qsort_HUD.png")
local Godo = love.graphics.newImage("/Assets/HUD/Godo_HUD.png")
local HpArt = love.graphics.newImage("/Assets/HUD/Heart_HUD_2.png")

function playerManager.load()
end

function playerManager.start(nPlayers)
  nPlayers = 2
  for i=1,nPlayers do
    table.insert(playerManager.list,Player.new(i,bulletManager.randomBullet(),playerAssets[i],i))
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
    v:keypressed(key)
  end
end

function playerManager.draw(of)
  local players = sortDraw(playerManager.list)
  for i,v in ipairs(players) do
    --love.graphics.print(tostring(v.hp), 0 , i*50)
    drawHud(HpArt)
    
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

function drawHud(hpArt)
  for i,v in ipairs(playerManager.list) do
    
    if v.data[i].playerID == 1 then
      if v.charID == 1 then
        love.graphics.draw(Magno,20,100)
      end
      if v.charID == 2 then
        love.graphics.draw(Qsort,20,100)
      end
    end    
    
    if v.data[i].playerID == 2 then
     if v.charID == 1 then
        love.graphics.draw(Magno,1650,100)
      end
      if v .charID == 2 then
        love.graphics.draw(Qsort,1650,100)
      end      
    end
  end
  
    for i,v in ipairs(playerManager.list) do
    if i == 1 then
      for i=0,v.hp-1 do
        love.graphics.draw(hpArt,20 + 50*i, 0, 0)
      end
    
    for i,v in ipairs(playerManager.list) do
    if i == 2 then
      for i=0,v.hp-1 do
        love.graphics.draw(hpArt,1650+50*i, 0, 0)
      end
    end
    
    
    end
   end
  end
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
