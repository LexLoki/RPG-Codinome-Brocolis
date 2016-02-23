playerSelection = {}
grid = {}

function playerSelection.load()
  grid.data = {}
  playerSelection.loadData("Magnolio")
  playerSelection.loadData("VR-470")
  playerSelection.loadData("Godo")
  playerSelection.loadData("Cpt. Rubi")
end
function playerSelection.numberOfJoysticks(key)
  local number = 0
  --for i, p in ipairs(players) do
    if(love.joystick.getJoystickCount()>= 1) then --and key == p.keyAttack 
      number = number + 1
    end
 -- end
 return number
end
function playerSelection.start()
  audioManager.play(audioManager.characterScreenMusic)
  playerSelection.create(2, 2)
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.print("Character Selection", 450, 50, 0, 2, 2)
  local k = 0
  for i, v in ipairs(grid.data) do
    love.graphics.draw(v.img, 200 + 320*k, 200)
    love.graphics.print(v.name, 270 + 320*k, 600)
    k = k + 1
  end
end

function playerSelection.keypressed(key)
  n_players = playerSelection.numberOfJoysticks(key) + 2
  if key == "return" then
    audioManager.playCharacterSelectSound()
    game.goToGameManager(n_players)
  end
end

function playerSelection.create(n_cols, n_rows, index)
  for i=0, n_rows do
    playerSelection[i] = {}
    for j=0, n_cols do
      playerSelection[i][j] = index
    end
  end
end

function playerSelection.loadData(string)
  table.insert(grid.data,{name=string,img=love.graphics.newImage("Assets/Menu/"..string..".png")})
end