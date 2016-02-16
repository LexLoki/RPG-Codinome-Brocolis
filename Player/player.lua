require "Utils/animationManager"
require "animatedEntity"
require "Direction"
require "Weapon/weapon"
require "Player/playerAliveState" 
require "Player/playerDeadState"

Player = class_extends(AnimatedEntity, "alive")



function Player.load()
  Player.data = {
    {color = {255,255,255}, keys = {left="left",up="up",right="right",down="down",jump="space",attack=",",run="m"}},
    {color = {0,255,0}, keys = {left="a",up="w",right="d",down="s",jump="space",attack="c",run="x"}},
    {color = {100,100,255}, keys = {left="k",up="o",right=";",down="l",jump="space",attack="]",run="["}},
    {color = {0,0,0}}
  }

  Player.width = 48
  Player.height = 96
  Player.speed = 280
  Player.maxHP = 4 
  
  
end
function Player:tookHit()
 self.curr_state:tookHit()
end

function Player.new(index,bulletClass)
  local pirate = {
    idle = {sheetFilename="/Assets/Player/Pirate/pirate_idle.png",
      animationTime = 0.5,
      nCol = 7,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    }
  }
  local self = Player.newObject(100,100,Player.width,Player.height,pirate)
  --Init properties
  self.color = Player.data[index].color
  --self.dir = Direction.Left
  self.speed = {x=0,y=0}
  --self.aComp = animationManager_new(4,0.5,true)
  self.keys = Player.data[index].keys
  self.hp = Player.maxHP
  self.weapon = Weapon.new(self,bulletClass)
  
  self.states = { 
    alive = PlayerAliveState.new(self),
    dead = PlayerDeadState.new(self)
  }
  self.curr_state = self.states.alive
  
  return self
end

function Player:keypressed(key)
  self.curr_state:keypressed(key)
end
function Player:attack()
  self.curr_state:attack()
end

function Player:update(dt)
   self.super:update(dt)
   self.curr_state:update(dt)
  
end
function Player:draw(of)
  self.curr_state:draw(of)  
  
end  

