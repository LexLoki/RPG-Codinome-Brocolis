require "Arena/tile"

SolidTile = class_extends(Tile,"solidTile")
SolidTile.color = {255,0,0,255}

function SolidTile.new(x,y)
  local self = SolidTile.newObject(x,y)
  return self
end

function SolidTile:canMove(entity)
  return false
end