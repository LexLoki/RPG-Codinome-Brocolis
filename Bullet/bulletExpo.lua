require "bullet/bullet"

BulletExpo = class_extends(Bullet,"expo")
BulletExpo.speed = 100
BulletExpo.damping = 20
-- y = exp^x


function BulletExpo.new(x,y,dir)
  local self = BulletExpo.newObject(x,y,dir,BulletExpo.speed)
  self.x0 = x
  self.y0 = y
  self.speed = 
  {
    x = BulletExpo.speed,
    y = 0
  }
  self:prepare(dir)
  return self
end

function BulletExpo:prepare(dir)
  local pi = math.pi
end

function BulletExpo:update(dt)
    
    local x = self.x-self.x0
    
    local NextY = math.exp(x/self.damping) + self.y0
    
    self.speed.y = (NextY-self.y)/dt
    
  end
