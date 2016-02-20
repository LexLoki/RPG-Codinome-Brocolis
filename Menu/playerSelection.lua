playerSelection = {}
grid = {}

local n_players = love.joystick.getJoystickCount() + 1

function playerSelection.load()
  grid.name = {"Brócolis", "  AK-49", "   Godo", "Cpt. Rubi"}
end

function playerSelection.start(n_players)
  audioManager.play(audioManager.characterSelectMusic)
  playerSelection.create(2, 2)
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.print("Character Selection", 450, 50, 0, 2, 2)
  local k = 0
  for i=1, 2 do
    for j=1, 2 do
      if grid[i][j] ~= nil then
        love.graphics.draw(grid[i][j], 200 + 320*k, 200)
        love.graphics.print(grid.name[k+1], 270 + 320*k, 600)
      end
      k = k + 1
    end
  end
end

function playerSelection.keypressed(key)
  if key == "return" then
    game.goToGameManager(n_players) 
  end
end

function playerSelection.create(n_cols, n_rows)
  for i=1, n_rows do
    grid[i] = {}
    for j=1, n_cols do
      filename = "Assets/Menu/pers_"..i.."_"..j..".png"
      if love.filesystem.exists(filename) then
        grid[i][j] = love.graphics.newImage(filename)
      end
    end
  end
end