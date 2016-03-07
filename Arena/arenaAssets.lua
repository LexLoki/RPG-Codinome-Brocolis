require "Utils/animations"


local arenaAssets = {}

function arenaAssets.load()
  local s = love.graphics.newImage("/Assets/Stages/TileSet.png")
  --animations.loadQuads(quant,nCol,sprite_width,sprite_height)
  local quads = animations.loadMatrixQuads(s:getHeight()/64,s:getWidth()/64,s:getWidth(),s:getHeight())
  arenaAssets.sheet = s
  arenaAssets.maps = {
    --brocolis
    {
      defaultFloor = quads[3][2],
      defaultWall = quads[3][1],
      destruct = quads[2][1]
    },
    --robo
    {
      defaultFloor = quads[6][1],
      defaultWall = quads[7][3],
      destruct = quads[6][3]
    },
    --alien
    {
      defaultFloor = quads[2][3],
      defaultWall = quads[2][4],
      destruct = quads[2][5]
    },
    --pirata
    {
      defaultFloor = quads[5][6],
      defaultWall = quads[5][5],
      destruct = quads[6][4]
    }
  }
  --default
  arenaAssets.maps[0] = {defaultFloor = quads[1][3],defaultWall = quads[1][2],destruct = quads[1][1]}
end

return arenaAssets