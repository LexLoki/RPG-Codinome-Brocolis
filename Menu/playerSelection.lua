local playerSelection = {}
local grid = {}

function playerSelection.load(menuManager)
  playerSelection.menuManager = menuManager
  grid.data = {}
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
  for i, row in ipairs(playerSelection) do
    for j, p in ipairs(row) do
      playerSelection.selection(p, key)
      if key == p.keys[1].confirm and playerSelection.confirmados == playerSelection.n_players then
        --game.goToGameManager(playerSelection.n_players)
      end
    end
  end
end

function playerSelection.create(n_rows, n_cols)
  for i=1, n_rows do
    playerSelection[i] = {}
    for j=1, n_cols do
      playerSelection[i][j] = {connected = false, id = 0, key = {}}
    end
  end
end
function playerSelection.loadData(string)
  table.insert(grid.data,{name=string,img=love.graphics.newImage("Assets/Menu/"..string..".png")})
end
function playerSelection.selection(player, key)
  local pk = player.keys
  if key == pk.up and player.connected then
    player.id = player.id + 1
    if player.id >= #grid.data + 1 then
      player.id = 1
    end
  elseif key == pk.down and player.connected then
    player.id = player.id - 1
    if player.id <= 0 then
      player.id = #grid.data
    end
  elseif key == pk.attack then
    player.connected = true
    playerSelection.n_players = playerSelection.n_players + 1
  elseif key == pk.confirm then
    audioManager.playCharacterSelectSound()
    playerSelection.confirmados = playerSelection.confirmados + 1
    playerSelection.menuManager.game.goToGameManager(playerSelection.n_players)  
  end
end
return playerSelection
