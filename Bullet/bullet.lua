require "entity"
require "contact"

Bullet = class_extends(Entity,"bullet")
Bullet.width = 25
Bullet.height = 25
Bullet.color = {0,255,0}
Bullet.speed = 800

function Bullet.load()
  
end

--[[ Bullet.new
Creates a new bullet shot by the given player
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - direction: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function Bullet.new(x,y,direction)
  self = Bullet.newObject(x,y)
  self.speed = {
    x = Bullet.speed * direction.x,
    y = Bullet.speed * direction.y
  }
  return self
end

--[[ Bullet:update
Updates the bullet behaviour. This function should be overrided by its subclasses
-
Parameters:
  - dt: the delta time since last frame update
]]
function Bullet:update(dt)
  
end

--[[ Bullet:checkPlayerContact
Check either or not the bullet is touching a given player
-
Parameters:
  - player: the Player entity to check if the bullet is in contact with

Returns: 
  - true: if the player is in contact with the bullet
  - false: otherwise
]]
function Bullet:checkPlayerContact(player)
  return contact.isInContact(self,player)
end