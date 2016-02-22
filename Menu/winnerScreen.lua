winnerScreen = {}

function winnerScreen.load()
  
end

function winnerScreen.start()
  
end

function winnerScreen.update(dt)
  
end

function winnerScreen.draw()
  love.graphics.print("And the winner is ...", 100, 300, 0, 2, 2)
end

function winnerScreen.keypressed(key)
  if key == "return" then
    menuManager.goToPlayerSelection() 
  end
end