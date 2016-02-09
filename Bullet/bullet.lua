require "entity"
require "Direction"

Bullet = class_extends(Entity,"bullet")
Bullet.width = 50
Bullet.height = 50
Bullet.color = {0,255,0}
Bullet.speed = 800

function Bullet.load()
  
end

function Bullet.new(x,y,player)
  self = Bullet.newObject(x-Bullet.width/2,y-Bullet.height/2)
  self.speed = Direction.getSpeed(player.dir)
  self.speed.x = Bullet.speed*self.speed.x
  self.speed.y = Bullet.speed*self.speed.y
  return self
end

function Bullet:update(dt)
  
end