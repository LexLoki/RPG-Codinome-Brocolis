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
  love.graphics.print("Game Logo", 400, 300)
end

function menu.keypressed(key)
  buttons.keypressed(key)
  if key == "return" and buttons.pressed == 1 then
    menuManager.goToInstruct() 
  elseif key == "return" and buttons.pressed == 2 then
    love.event.push("quit")
  end
end

function menu.mousepressed(x, y, button)
  mouse.x = x
  mouse.y = y
  if key == 1 and buttons[1].colliding then
    menuManager.goToInstruct() 
  elseif key == 1 and buttons[2].colliding then
    love.event.push("quit")
  end
end