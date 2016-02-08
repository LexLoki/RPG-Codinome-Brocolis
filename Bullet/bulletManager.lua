require "Bullet/bullet"

bulletManager = {}
bulletManager.list = {}

function bulletManager.load()
end

function bulletManager.start()
  
end

function bulletManager.update(dt)
  for i,v in ipairs(bulletManager.list) do
    v:update(dt)
    if not arena.handleHorizontal(dt,v) or not arena.handleVertical(dt,v) then
      table.remove(bulletManager.list,i)
    end
  end
end

function bulletManager.draw(of)
  for i,v in ipairs(bulletManager.list) do
    v:draw(of)
  end
end