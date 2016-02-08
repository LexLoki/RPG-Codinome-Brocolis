require "class"

Entity = class_new()

function Entity.new(x,y,width,height)
  local self = Entity.newObject()
  self.x = x
  self.y = y
  if width ~= nil then self.width = width end
  if height ~= nil then self.height = height end
  self.color = {0,0,0}
  return self
end

function Entity:update(dt)
  
end

function Entity:draw(of)
  if of == nil then of = {x=0,y=0} end
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill",self.x+of.x,self.y+of.y,self.width,self.height)
  love.graphics.setColor(255,255,255)
end