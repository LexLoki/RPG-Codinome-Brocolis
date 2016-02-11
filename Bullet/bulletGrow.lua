require "bullet/bullet"

BulletGrow = class_extends(Bullet,"grow")
BulletGrow.growSpeed = 50
BulletGrow.speed = 400
BulletGrow.color = {0,0,255}

function BulletGrow.new(x,y,dir)
  local self = BulletGrow.newObject(x,y,dir,BulletGrow.speed)
  return self
end

function BulletGrow:update(dt)
  self.super:update(dt)
  local inc = BulletGrow.growSpeed*dt
  self.width = self.width+inc
  self.height = self.height+inc
  self.x = self.x-inc/2
  self.y = self.y-inc/2
end