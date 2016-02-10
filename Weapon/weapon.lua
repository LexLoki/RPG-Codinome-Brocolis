require "class"

Weapon = class_new("Weapon")

-- Properties for subclasses to override
Weapon.cooldown = 0

function Weapon.new(player, bulletClass)
  local self = Weapon.newObject()
  self.player = player
  self.bulletClass = bulletClass
  self.timer=0
  return self
end

function Weapon:update(dt)
  if self.timer>0 then
    self.timer = self.timer-dt
  end
end

function Weapon:shoot()
  if self.timer<=0 then
    self.timer = self.cooldown
    bulletManager.newBullet(self.player,self.bulletClass)
  end
end