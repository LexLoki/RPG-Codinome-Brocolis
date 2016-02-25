require "Utils/animations"


local arenaAssets = {}

function arenaAssets.load()
  local s = love.graphics.newImage("/Assets/Stages/TileSet.png")
  --animations.loadQuads(quant,nCol,sprite_width,sprite_height)
  local quads = animations.loadMatrixQuads(s:getHeight()/64,s:getWidth()/64,s:getWidth(),s:getHeight())
  arenaAssets.sheet = s
  arenaAssets.maps = {
    --brocolis, robo, alien, pirata
    {
      defaultFloor = quads[3][2],
      defaultWall = quads[3][1],
      destruct = quads[2][1]
    }
  }
end

return arenaAssets