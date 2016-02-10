require "bullet/bullet"

BulletStraight = class_extends(Bullet,"straight")
BulletStraight.speed = 400
BulletStraight.color = {0,0,255}


function BulletStraight.new(x,y,dir)
  local self = BulletStraight.newObject(x,y,dir,BulletStraight.speed)
  return self
end