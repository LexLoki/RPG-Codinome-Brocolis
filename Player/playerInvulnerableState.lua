require "Player/playerAliveState"

playerInvulnerableState = class_extends(playerAliveState, "vulnerable")



function playerInvulnerableState.new()
  local self = playerInvulnerableState.newObject() 
  self.timer = 2
  
  return self   
end

function playerInvulnerableState.load()
  
end

function playerInvulnerableState.update(dt)
  self.timer = self.timer - dt
  if self.timer < 0 then
  PlayerAliveState:setVulnerability(vulnerable)
  end
end

function playerInvulnerableState.draw()
  
  
end

