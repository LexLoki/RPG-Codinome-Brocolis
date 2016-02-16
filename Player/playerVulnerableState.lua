require "Player/playerAliveState"

playerVulnerableState = class_extends(playerAliveState, "vulnerable")

function PlayerVulnerableState.new()
  local self = PlayerVulnerableState.newObject() 
  return self   
end

function PlayerVulnerableState.load()
  
end

function PlayerVulnerableState.update(dt)
  
end

function PlayerVulnerableState.draw()
  
  
  end