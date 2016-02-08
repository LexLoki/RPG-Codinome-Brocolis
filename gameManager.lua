require "Arena/arena"
require "Player/player"

gameManager = {}
gameManager.players = {}
gameManager.bullets = {}

local orderByHeight, sortDraw

function gameManager.load()
  arena.load(12,16)
  Player.load()
end

function gameManager.start(nPlayers)
  for i=1,nPlayers do
    table.insert(gameManager.players,Player.new(i))
  end
end

function gameManager.update(dt)
  for i,v in ipairs(gameManager.players) do
    v:update(dt)
  end
  for i,v in ipairs(gameManager.bullets) do
    v:update(dt)
    if not arena.handleHorizontal(dt,v) or not arena.handleVertical(dt,v) then
      print("removing")
      table.remove(gameManager.bullets,i)
    end
  end
  arena.update(dt,gameManager.players)
end

function gameManager.draw()
  arena.draw()
  local of = {x=arena.x,y=arena.y}
  local players = sortDraw(gameManager.players)
  for i,v in ipairs(players) do
    v:draw(of)
  end
  for i,v in ipairs(gameManager.bullets) do
    v:draw(of)
  end
end

function gameManager.keypressed(key)
  for i,v in ipairs(gameManager.players) do
    v:keypressed(key)
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