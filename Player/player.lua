require "Utils/animationManager"
--require "animatedEntity"
require "armedAnimatedEntity"
require "Direction"
require "Weapon/weapon"
require "Player/playerAliveState" 
require "Player/playerDeadState"

Player = class_extends(ArmedAnimatedEntity, "alive")

function Player.load()
  Player.data = {
    {color = {255,255,255}, keys = {left="left",up="up",right="right",down="down",jump="space",attack=",",confirm="m"}, pos = {x=100 , y=100},playerID = 1},
    {color = {0,255,0}, keys = {left="a",up="w",right="d",down="s",jump="space",attack="c",confirm="x"}, pos = {x=1190 , y=100},playerID = 2},
    {color = {100,100,255}, keys = {left="k",up="o",right=";",down="l",jump="space",attack="]",confirm="["}, pos = {x= 100, y=600}},
    {color = {100,100,255}, keys = {left="f",up="t",right="h",down="g",jump="space",attack="v",confirm="["}, pos = {x=1190 , y= 600}},
    {color = {0,0,0}}
  }
  --Player.score = 0 
  Player.width = 48
  Player.height = 96
  Player.speed = 280
  Player.maxHP = 4 
  Player.score = 0
  Player.deathId = "death"
  Player.idleId = "idle"
  Player.walkId = "walk"
end
function Player:tookHit()
 self.curr_state:tookHit()
end

function Player.new(index,bulletClass,assetInfo,keys,icon)
  local self = Player.newObject(Player.data[index].pos.x,Player.data[index].pos.y,Player.width,Player.height,assetInfo)
  --Init properties
  self.color = Player.data[index].color
  --self.dir = Direction.Left
  self.speed = {x=0,y=0}
  --self.aComp = animationManager_new(4,0.5,true)
  self.keys = keys--Player.data[index].keys
  self.hp = Player.maxHP
  self.score = Player.score
  self.weapon = Weapon.new(self,bulletClass)
  --ele deve receber algo vindo do playerSelection.lua
  self.icon = icon
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
  love.graphics.setColor(0,0,0)
  if config.debugBoundingBoxMode then love.graphics.rectangle("line",self.x+of.x,self.y+of.y,self.width,self.height) end
  love.graphics.setColor(255,255,255)
end

function Player:setState(state)
  self.curr_state = state
  self.curr_state:start()
end