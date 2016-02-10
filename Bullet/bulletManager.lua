require "Bullet/bullet"
require "Bullet/bulletSenoid"
require "Bullet/bulletGrow"
require "Direction"
require "Utils/animations"

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
  animations.load()
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
  animations.update(dt)
  for i,v in ipairs(bulletManager.list) do
    v:update(dt)
    if not arena.handleHorizontal(dt,v) or not arena.handleVertical(dt,v) then
      bulletManager.bulletCollided(i)
    else
      bulletManager.searchPlayerContact(i,v)
    end
  end
end

--[[ bulletManager.searchPlayerContact
Verifies if a bullet is touching one of the players
-
Parameters:
  - v: the bullet
]]
function bulletManager.searchPlayerContact(i,v)
  for j,p in ipairs(playerManager.list) do
    if v:checkPlayerContact(p) then
      bulletManager.bulletCollided(i)
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
  bulletManager.offset = offset
  for i,v in ipairs(bulletManager.list) do
    v:draw(offset)
  end
  animations.draw()
end

function bulletManager.bulletCollided(bulletIndex)
  local of = bulletManager.offset
  local bullet = table.remove(bulletManager.list,bulletIndex)
  animations.createSplash(of.x+bullet.x+bullet.width/2,of.y+bullet.y+bullet.height/2)
end