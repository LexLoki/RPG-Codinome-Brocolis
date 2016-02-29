local destructTile = require "Arena/destructTile"

local arenaAlien = {index = 3}

local preparePositions, round, evaluate, readTxt

function arenaAlien.start(arena)
  --Read txt with inputs
  arenaAlien.arena = arena
  local txtData = readTxt()
  preparePositions(txtData)
end

function arenaAlien.update(dt)
  local ps = playerManager.getAlivePlayers()
  local inContact = {}
  for i,pan in ipairs(arenaAlien.ovnis) do
    for j,pl in ipairs(ps) do
      if contact.isInContact(pan,pl) then
        table.insert(inContact,pl)
        table.remove(ps,j)
      end
    end
  end
  for i,v in ipairs(arenaAlien.inContact) do
    for j,w in ipairs(inContact) do
      local exists = false
      if v==w then exists = true break end
    end
    if exists then
      table.remove(inContact,j)
    else
      table.remove(arenaAlien.inContact,i)
    end
  end
  
  for i,v in ipairs(inContact) do
    table.insert(arenaAlien.inContact,v)
    arenaAlien.teletransport(v)
  end
end

function arenaAlien.teletransport(p)
  
end

function readTxt()
  local file = love.filesystem.read("/Assets/Stages/Alien_Stage1.txt")
  local data = {}
  for line in file:gmatch('([^\n]+)') do
    local words = {}
    for w in line:gmatch("%S+") do table.insert(words,w) end
    table.insert(data,{x=tonumber(words[3]),y=tonumber(words[1])})
  end
  return data
end

function preparePositions(inputs)
  arenaAlien.pos = {}
  arenaAlien.ovnis = {}
  for i,v in ipairs(inputs) do
    evaluate(v)
  end
end

function evaluate(input)
  local a = arenaAlien.arena
  local col,row = round(input.x*arenaAlien.arena.nCol), round(input.y*arenaAlien.arena.nRow)
  table.insert(arenaAlien.pos,{col=col,row=row})
  local v = SolidTile.new(col*arenaAlien.arena.tileSize.width,row*arenaAlien.arena.tileSize.height,a.sheet,a.mapInfo.destruct,arenaAlien)
  v.index = #arenaAlien.pos
  table.insert(arenaAlien.blocks,v)
  local obs = arenaAlien.arena.obstacles 
  local pos = arenaAlien.pos[v.index]
  obs[pos.row][pos.col] = v
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end
return arenaAlien
