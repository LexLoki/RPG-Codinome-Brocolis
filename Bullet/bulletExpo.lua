require "bullet/bullet"

BulletExpo = class_extends(Bullet,"expo")
BulletExpo.speed = 500
BulletExpo.damping = 50

local horizontal = {}
local vertical = {}

function BulletExpo.new(x,y,dir)
  local self = BulletExpo.newObject(x,y,dir,BulletExpo.speed)
  self.x0 = x
  self.y0 = y
  self:prepare(dir)
  return self
end

function BulletExpo:prepare(dir)
  self.speed = {
      x = BulletExpo.speed*dir.x,
      y = BulletExpo.speed*dir.y
    }
  if dir.x ~= 0 then
    self.type = horizontal
    self.sign = dir.x
  else
    self.type = vertical
    self.sign = dir.y
  end
end

function BulletExpo:update(dt)
  self.super:update(dt)
  self.type.update(self,dt)
end
  
function horizontal.update(self,dt)
  local x = math.abs(self.x-self.x0)
  local NextY = math.exp(x/self.damping)/4*self.sign + self.y0
  self.speed.y = (NextY-self.y)/dt
end
function vertical.update(self,dt)
  local y = math.abs(self.y-self.y0)
  local NextX = math.exp(y/self.damping)/4*self.sign + self.x0
  self.speed.x = (NextX-self.x)/dt
end
  
