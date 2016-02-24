--  playerManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Player/player"
require "Player/playerAssets"

playerManager = {}
playerManager.list = {}

local orderByHeight, sortDraw
local pirataMaroto = love.graphics.newImage("/Assets/HUD/pirata_placeholder.png")
local hpMaroto = love.graphics.newImage("/Assets/HUD/redcross.png")

function playerManager.load()
end

function playerManager.start(nPlayers)
  local nPlayers = 2
  for i=1,nPlayers do
    table.insert(playerManager.list,Player.new(i,bulletManager.randomBullet(),playerAssets[i]))
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
    --love.graphics.print(tostring(v.hp), 0 , i*10)
    --[[if i == 1 then
    if v.charID == 1 then
      love.graphics.print("Minha rola", 30, 10)
    end]]--
    drawHud(1, 1, hpMaroto)
    --end
    v:draw(of)
    
  -- 50,0 
  end
end

function playerManager.killPlayer(player)
  for i,v in ipairs(playerManager.list) do
    if v==player then
      table.remove(playerManager.list,i)
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

function drawHud(playerID,charID,hpArt)
  for i,v in ipairs(playerManager.list) do
    if i == 1 then
      if v.charID == 1 then
        love.graphics.draw(pirataMaroto,20,100)
      end
      for i=0,v.hp-1 do
        love.graphics.draw(hpArt,20 + 50*i, 0, 0, 0.25, 0.25)
      end
    end
    
    if i == 2 then
      if v.charID == 1 then
        love.graphics.draw(pirataMaroto,1650,100)
      end
      for i=0,v.hp-1 do
        love.graphics.draw(hpArt, 1650+ 50*i, 0, 0, 0.25, 0.25)
      end
    end
    
    if i == 3 then
      if v.charID == 1 then
        love.graphics.draw(pirataMaroto,1650,800)
      end
      for i=0,v.hp-1 do
        love.graphics.draw(hpArt, 1650+ 50*i, 750, 0, 0.25, 0.25)
      end
    end
    
    
    
  end
end

function playerManager.getLastPlayer()
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
    return v
  end
end
end