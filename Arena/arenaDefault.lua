require "Arena/destructTile"
arenaComum = {index=1}

local preparePositions, round, evaluate, readTxt

function arenaComum.start(arena)
  arena.testObstacles()
end
function arenaComum.update(dt)
  
end
function arenaComum.destroy(block)
 
end
function readTxt()
 
end
function preparePositions(inputs)
  
end
function evaluate(input)
  
end
function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end