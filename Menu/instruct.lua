local instruct = {}

function instruct.load(menuManager)
  instruct.menuManager = menuManager
end

function instruct.start(n_players)
  
end

function instruct.update(dt)
  
end

function instruct.draw()
  love.graphics.print("Instructions", 400, 300)
end

function instruct.keypressed(key)
  if key == "return" then
    instruct.menuManager.goToPlayerSelection()
    audioManager.playOptionSelectSound()
  end
end
return instruct
