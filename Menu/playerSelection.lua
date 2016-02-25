require "Player/playerManager"

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
  playerSelection.keys = playerManager.keys
  audioManager.play(audioManager.characterScreenMusic)
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.print("Character Selection", 450, 50, 0, 2, 2)
  --love.graphics.print(tostring(playerConnected[1]), 450, 700, 0, 2, 2)
  --love.graphics.print(playerSelection[1][1], 450, 800, 0, 2, 2)
  --[[
  local i = 1
  for j = 1, 4 do
  ]]
  for i,v in ipairs(playerSelection) do
    for j,p in ipairs(v) do
      love.graphics.draw(grid.data[p.id].img, 200 + 320*(j-1), 200)
      love.graphics.print(grid.data[p.id].name, 270 + 320*(j-1), 600)
    end
  end
end

function playerSelection.startGame()
  local players = {}
  for i,v in ipairs(playerSelection) do
    for j,w in ipairs(v) do
      table.insert(players,w)
    end
  end
  playerSelection.menuManager.game.goToGameManager(players)  
end

function playerSelection.keypressed(key)
  local foundPlayer = false
  for i, row in ipairs(playerSelection) do
    for j, p in ipairs(row) do
      if p.joy==nil and playerSelection.selection(p, key) then
        foundPlayer = true
        break
      end
    end
  end
  if not foundPlayer then
    local k = playerSelection.keys.keyboard
    for i,v in ipairs(k) do
      if key == v.confirm then
        playerSelection.newPlayer(v)
        break
      end
    end
  end
end

function playerSelection.gamepadpressed(joystick, button)
  local foundPlayer = false
  for i, row in ipairs(playerSelection) do
    for j, p in ipairs(row) do
      if p.joy~=nil then
        if p.joy==joystick then
          playerSelection.selection(p, button)
          foundPlayer = true
          break
        end
      end
    end
  end
  if not foundPlayer then
    local v = playerSelection.keys.joy
    if v.confirm == button then
      playerSelection.newPlayer(v,joystick)
    end
  end
end

function playerSelection.newPlayer(keys, joy)
  for i,v in ipairs(playerSelection) do
    local last = #v
    if last<playerSelection.n_cols then
      v[last+1] = {id = 1, keys = keys, joy=joy}
      break
    end
  end
end

function playerSelection.create(n_rows, n_cols)
  playerSelection.n_rows = n_rows
  playerSelection.n_cols = n_cols
  for i=1, n_rows do
    playerSelection[i] = {}
    for j=1, n_cols do
      --playerSelection[i][j] = {connected = false, id = 0, key = {}}
    end
  end
end
function playerSelection.loadData(string)
  table.insert(grid.data,{name=string,img=love.graphics.newImage("Assets/Menu/"..string..".png")})
end
function playerSelection.selection(player, key)
  local pk = player.keys
  if key == pk.up then
    player.id = player.id + 1
    if player.id >= #grid.data + 1 then
      player.id = 1
    end
    do return true end
  elseif key == pk.down then
    player.id = player.id - 1
    if player.id <= 0 then
      player.id = #grid.data
    end
    do return true end
    --[[
  elseif key == pk.attack then
    player.connected = true
    playerSelection.n_players = playerSelection.n_players + 1
    --]]
  elseif key == pk.confirm then
    audioManager.playCharacterSelectSound()
    --playerSelection.confirmados = playerSelection.confirmados + 1
    playerSelection.startGame()
    do return true end
  end
  return false
end
return playerSelection
