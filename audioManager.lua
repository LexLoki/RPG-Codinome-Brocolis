audioManager={}

function audioManager.load()
  audioManager.bulletSound = love.audio.newSource("/Assets/Sfx/b1.wav")
  --audioManager.deathSound = love.audio.newSource("/Assets/Sfx/Dragonite.wav")
  audioManager.explodeSound = love.audio.newSource("/Assets/Sfx/shieldBreak.wav")
  audioManager.characterSelectSound = love.audio.newSource("/Assets/Sfx/Character_select.wav")
  audioManager.optionSelectSound = love.audio.newSource("/Assets/Sfx/Clique.wav")
  audioManager.matchStartSound = love.audio.newSource("/Assets/Sfx/Match_Start.wav")
  audioManager.exitSound = love.audio.newSource("/Assets/Sfx/Voltar.wav")
  audioManager.stageMusic = love.audio.newSource("/Assets/Music/Undertale OST - Bonetrousle .mp3")
  audioManager.menuMusic = love.audio.newSource("/Assets/Music/Uncanny Arena - Título.mp3")
  audioManager.characterScreenMusic = love.audio.newSource("/Assets/Music/Uncanny Arena - Escolha de Personagem.mp3")
  
  audioManager.bulletSound:setVolume(0.5)
  --audioManager.deathSound:setVolume(0.5)
  audioManager.explodeSound:setVolume(0.5)
  audioManager.characterSelectSound:setVolume(0.5)
  audioManager.optionSelectSound:setVolume(0.5)
  audioManager.matchStartSound:setVolume(0.5)
  audioManager.exitSound:setVolume(0.5)

  audioManager.musicPlaying = nil
end

function audioManager.playBulletSound()
  audioManager.playSfx(audioManager.bulletSound)
end

function audioManager.playExplodeSound()
  audioManager.playSfx(audioManager.explodeSound)
end

function audioManager.playCharacterSelectSound()
  audioManager.playSfx(audioManager.characterSelectSound)
end

function audioManager.playOptionSelectSound()
  audioManager.playSfx(audioManager.optionSelectSound)
end

function audioManager.playMatchStartSound()
  audioManager.playSfx(audioManager.matchStartSound)
end

function audioManager.playExitSound()
  audioManager.playSfx(audioManager.exitSound)
end

--[[function audioManager.playDeathSound()
  audioManager.playSfx(audioManager.deathSound)
end]]--

function audioManager.play(music)
  if audioManager.musicPlaying ~= nil then
    love.audio.stop(audioManager.musicPlaying)
  end
  audioManager.musicPlaying = music
	music:setLooping(true)
  music:setVolume(0.5)
	love.audio.play(music)
end

function audioManager.playSfx(sfx)
  if sfx:isPlaying() then
    love.audio.stop(sfx)
  end
  love.audio.play(sfx)
end