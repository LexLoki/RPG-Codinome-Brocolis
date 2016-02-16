

PlayerDeadState = class_new("dead")


function PlayerDeadState.new(player)
  local self = PlayerDeadState.newObject()
  self.player = player
  return self   
end
function PlayerDeadState:tookHit(dt)
end
function PlayerDeadState:keypressed(key)
end
function PlayerDeadState:attack()
end
function PlayerDeadState:update(dt)
  
end

function PlayerDeadState:draw(of)

end
