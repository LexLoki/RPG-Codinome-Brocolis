require "bullet/bullet"

BulletSenoid = class_extends(Bullet,"senoid")
BulletSenoid.amp = 50
BulletSenoid.time = 0.6
--Bullet.sign = 1
BulletSenoid.speed = 400
BulletSenoid.color = {0,0,255}

local horizontal = {}
local vertical = {}

function BulletSenoid.new(x,y,dir)
  local self = BulletSenoid.newObject(x,y,dir,BulletSenoid.speed)
  self.x0 = x
  self.y0 = y
  self.type = dir.x ~= 0 and horizontal or vertical
  self.sign = (sign == nil and 1 or sign)
  self.type.start(self)
  return self
end

function BulletSenoid:update(dt)
  self.type.update(dt,self)
end

function horizontal.start(self)
  self.mult = math.pi*2/(BulletSenoid.time*self.speed.x)*self.sign
end
function horizontal.update(dt,self)
  local nextY = BulletSenoid.amp*math.sin((self.x-self.x0)*self.mult) + self.y0
  self.speed.y = (nextY-self.y)/dt
end
function vertical.start(self)
  self.mult = math.pi*2/(BulletSenoid.time*self.speed.y)*self.sign
end
function vertical.update(dt, self)
  local nextX = BulletSenoid.amp*math.sin((self.y-self.y0)*self.mult) + self.x0
  self.speed.x = (nextX-self.x)/dt
end

