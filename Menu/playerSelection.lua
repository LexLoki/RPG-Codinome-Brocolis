playerSelection = {}
grid = {}

function playerSelection.load()
  grid.data = {}
  playerConnected = {false, false, false, false}
  playerSelection.create(1, 4)
  playerSelection.confirmados = 0
  playerSelection.n_players = 0
  playerSelection.loadData("Magnolio")
  playerSelection.loadData("VR-470")
  playerSelection.loadData("Godo")
  playerSelection.loadData("Cpt. Rubi")
end
function playerSelection.start()
  audioManager.play(audioManager.characterScreenMusic)
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.print("Character Selection", 450, 50, 0, 2, 2)
  love.graphics.print(tostring(playerConnected[1]), 450, 700, 0, 2, 2)
  love.graphics.print(playerSelection[1][1], 450, 800, 0, 2, 2)
  local i = 1
  for j = 1, 4 do
    local p = playerSelection[i][j]
    love.graphics.draw(grid.data[p].img, 200 + 320*(j-1), 200)
    love.graphics.print(grid.data[p].name, 270 + 320*(j-1), 600)
  end
end

function playerSelection.keypressed(key)
  if key == "w" and playerConnected[1] then
    playerSelection[1][1] = playerSelection[1][1] + 1
    if playerSelection[1][1] >= 5 then
      playerSelection[1][1] = 1
    end
  elseif key == "s" and playerConnected[1] then
    playerSelection[1][1] = playerSelection[1][1] - 1
    if playerSelection[1][1] <= 0 then
      playerSelection[1][1] = 4
    end
  elseif key == "space" then
    playerConnected[1]  = true
    playerSelection.n_players = playerSelection.n_players + 1
  elseif key == "return" then
    audioManager.playCharacterSelectSound()
    playerSelection.confirmados = playerSelection.confirmados + 1
    game.goToGameManager(playerSelection.n_players)  end
  if key == "return" and playerSelection.confirmados == playerSelection.n_players then
    --game.goToGameManager(playerSelection.n_players)
  end
end

function playerSelection.create(n_rows, n_cols)
  for i=1, n_rows do
    playerSelection[i] = {}
    for j=1, n_cols do
      playerConnected[j] = false
      playerSelection[i][j] = 1
    end
  end
end
function playerSelection.joystickpressed(joystick, button)
  if button == 3 then
    love.graphics.print("PIROCOPTERO", 400, 500)
  end
end
function playerSelection.loadData(string)
  table.insert(grid.data,{name=string,img=love.graphics.newImage("Assets/Menu/"..string..".png")})
end