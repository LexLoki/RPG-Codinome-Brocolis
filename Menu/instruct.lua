instruct = {}

function instruct.load()
  
end

function instruct.start()
  
end

function instruct.update(dt)
  
end

function instruct.draw()
  love.graphics.print("Instructions", 400, 300)
end

function instruct.keypressed(key)
  if key == "return" then
    menuManager.goToPlayerSelection() 
  end
end