arenaBrocolis = {}

local preparePositions, round, evaluate

arenaBrocolis.spawnTime = 3

function arenaBrocolis.start(arena)
  --Read txt with inputs
  preparePositions({})
  arenaBrocolis.blocks = {}
  arenaBrocolis.arenaReplacement = {}
end

function arenaBrocolis.update(dt)
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

function preparePositions(inputs)
  arenaBrocolis.pos = {}
  for i,v in ipairs(inputs) do
    evaluate(v)
  end
end

function evaluate(input)
  table.insert(arenaBrocolis.pos,{col=round(input.x*arenaBrocolis.arena.nCol),row=round(input.y*arenaBrocolis.arena.nRow)})
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end