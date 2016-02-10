require "Bullet/bullet"
require "Bullet/bulletSenoid"
require "Bullet/bulletGrow"
require "Direction"

bulletManager = {}
bulletManager.list = {}
bulletManager.bullets = {
  BulletGrow,
  BulletSenoid
}

--[[ bulletManager.randomBullet
Gets a random subclass of Bullet
-
Returns: a random Bullet subclass
]]
function bulletManager.randomBullet()
  return bulletManager.bullets[love.math.random(#bulletManager.bullets)]
end

function bulletManager.load()
  Bullet.load()
end

function bulletManager.start()
  
end

--[[ bulletManager.update
Updates bullets behaviour
-
Parameters:
  - dt: the delta time since last frame update
]]
function bulletManager.update(dt)
  for i,v in ipairs(bulletManager.list) do
    v:update(dt)
    if not arena.handleHorizontal(dt,v) or not arena.handleVertical(dt,v) then
      table.remove(bulletManager.list,i)
    else
      bulletManager.searchPlayerContact(v)
    end
  end
end

--[[ bulletManager.searchPlayerContact
Verifies if a bullet is touching one of the players
-
Parameters:
  - v: the bullet
]]
function bulletManager.searchPlayerContact(v)
  for j,p in ipairs(playerManager.list) do
    if v:checkPlayerContact(p) then
      table.remove(bulletManager.list,i)
      p:tookHit()
    end
  end
end

--[[ bulletManager.newBullet
Creates a new bullet shot by the given player
-
Parameters:
  - player: the Player entity that is shooting the bullet
]]
function bulletManager.newBullet(player,bClass,...)
  --local bClass = player.bulletClass
  local dir = Direction.getSpeed(player.dir)
  local pos_x = player.x+(player.width-bClass.width)/2+dir.x*(bClass.width+player.width)/2
  local pos_y = player.y+(player.height-bClass.height)/2+dir.y*(bClass.height+player.height)/2
  table.insert(bulletManager.list,bClass.new(pos_x,pos_y,dir,player,...))
end

--[[ bulletManager.draw
Draws all the bullets
-
Parameters:
  - offset: a table (x,y) with offset distance from the screen's top left corner
]]
function bulletManager.draw(offset)
  for i,v in ipairs(bulletManager.list) do
    v:draw(offset)
  end
end