--  destructTile.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/solidTile"

destructTile = class_extends(SolidTile,"destructTile")
destructTile.color = {255,0,0,255}

function destructTile.new(x,y,manager)
  local self = destructTile.newObject(x,y)
  self.manager = manager
  return self
end

function destructTile:tookHit()
  self.manager.destroy(self)
end