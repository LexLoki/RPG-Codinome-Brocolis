require "entity"
require "Direction"

Bullet = class_extends(Entity,"bullet")

function Bullet.load()
  Bullet.width = 50
  Bullet.height = 50
  Bullet.color = {0,255,0}
end

function Bullet.new(x,y,player)
  self = Bullet.newObject(x-Bullet.width/2,y-Bullet.height/2)
  self.speed = Direction.getSpeed(player.dir)
  self.speed.x = 400*self.speed.x
  self.speed.y = 400*self.speed.y
  return self
end

function Bullet:update(dt)
  self.x = self.x+self.speed.x*dt
  self.y = self.y+self.speed.y*dt
end