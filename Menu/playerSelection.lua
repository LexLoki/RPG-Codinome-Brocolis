playerSelection = {}
grid = {}

io.stdout:setvbuf("no")

function playerSelection.load()
  
end

function playerSelection.start()
  
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.print("Player Selection", 400, 300)
end

function playerSelection.keypressed(key)
  if key == "return" then
    game.goToGameManager(3) 
  end
end

function playerSelection.create(n_cols, n_rows)
  for i=1, n_rows do
    grid[i] = {}
    for j=1, n_cols do
      filename = "pers_"..i.."_"..j..".png"
      if love.filesystem.exists(filename) then
        grid[i][j] = love.graphics.newImage(filename)
      end
    end
  end
end