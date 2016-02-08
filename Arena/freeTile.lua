require "Arena/tile"

FreeTile = class_extends(Tile,"freeTile")
FreeTile.color = {255,255,255}

function FreeTile.new(x,y)
  local self = FreeTile.newObject(x,y)
  return self
end

function FreeTile:canMove(entity)
  return true
end