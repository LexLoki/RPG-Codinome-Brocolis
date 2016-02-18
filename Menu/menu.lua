require "Menu/buttons"
menu = {}

function menu.load()
  buttons.load()
end

function menu.start(nPlayers)
  love.graphics.setColor(255, 255, 255)
  buttons.start()
end

function menu.update(dt)
  buttons.update(dt)
end

function menu.draw()
  buttons.draw()
end

function menu.keypressed(key)
  buttons.keypressed(key)
  if key == "return" then
    game.goToGameManager(3)
    --menuManager.goToInstruct() 
  end
end