require "Player/player"

playerManager = {}
playerManager.list = {}

local orderByHeight, sortDraw

function playerManager.load()
end

function playerManager.start(nPlayers)
  for i=1,nPlayers do
    table.insert(playerManager.list,Player.new(i,bulletManager.randomBullet()))
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
    v:draw(of)
  end
end

function playerManager.killPlayer(player)
  for i,v in ipairs(playerManager.list) do
    if v==player then
      table.remove(playerManager.list,i)
      break
    end
  end
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