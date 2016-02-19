require "Arena/destructTile"

arenaBrocolis = {}

local preparePositions, round, evaluate, readTxt

arenaBrocolis.spawnTime = 3

function arenaBrocolis.start(arena)
  --Read txt with inputs
  arenaBrocolis.arena = arena
  local txtData = readTxt()
  preparePositions(txtData)
end

function arenaBrocolis.update(dt)
  print(#arenaBrocolis.destroyed)
  for i,v in ipairs(arenaBrocolis.destroyed) do
    v.timer = v.timer - dt
    if v.timer<0 then
      v.timer = nil
      table.insert(arenaBrocolis.blocks,table.remove(arenaBrocolis.destroyed,i))
      local obs = arena.obstacles
      local pos = arenaBrocolis.pos[v.index]
      arenaBrocolis.arenaReplacement[v.index] = obs[pos.row][pos.col]
      obs[pos.row][pos.col] = v
    end
  end
end

function arenaBrocolis.destroy(block)
  for i,v in ipairs(arenaBrocolis.blocks) do
    if v == block then
      table.insert(arenaBrocolis.destroyed,table.remove(arenaBrocolis.blocks,i))
      block.timer = arenaBrocolis.spawnTime
      local pos = arenaBrocolis.pos[block.index]
      local obs = arena.obstacles
      obs[pos.row][pos.col] = arenaBrocolis.arenaReplacement[block.index]
    end
  end
end

function readTxt()
  local file = love.filesystem.read("/Assets/Stages/Brocolis_Stage1.txt")
  local data = {}
  for line in file:gmatch('([^\n]+)') do
    local words = {}
    for w in line:gmatch("%S+") do table.insert(words,w) end
    table.insert(data,{x=tonumber(words[1]),y=tonumber(words[3])})
  end
  return data
end

function preparePositions(inputs)
  arenaBrocolis.pos = {}
  arenaBrocolis.blocks = {}
  arenaBrocolis.arenaReplacement = {}
  arenaBrocolis.destroyed = {}
  for i,v in ipairs(inputs) do
    evaluate(v)
  end
end

function evaluate(input)
  local col,row = round(input.x*arenaBrocolis.arena.nCol), round(input.y*arenaBrocolis.arena.nRow)
  table.insert(arenaBrocolis.pos,{col=col,row=row})
  local v = DestructTile.new(col*arenaBrocolis.arena.tileSize.width,row*arenaBrocolis.arena.tileSize.height,arenaBrocolis)
  v.index = #arenaBrocolis.pos
  table.insert(arenaBrocolis.blocks,v)
  local obs = arena.obstacles
  local pos = arenaBrocolis.pos[v.index]
  arenaBrocolis.arenaReplacement[v.index] = obs[pos.row][pos.col]
  obs[pos.row][pos.col] = v
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end