audioManager={}

function audioManager.load()
  audioManager.bulletSound = love.audio.newSource("/Assets/Sfx/b1.wav")
  --audioManager.deathSound = love.audio.newSource("/Assets/Sfx/Dragonite.wav")
  audioManager.explodeSound = love.audio.newSource("/Assets/Sfx/shieldBreak.wav")
  audioManager.stageMusic = love.audio.newSource("/Assets/Music/Undertale OST - Bonetrousle .mp3")
  audioManager.bulletSound:setVolume(0.3)
  --audioManager.deathSound:setVolume(0.3)
  audioManager.explodeSound:setVolume(0.3)
  audioManager.musicPlaying = nil
end

function audioManager.playBulletSound()
  audioManager.playSfx(audioManager.bulletSound)
end

function audioManager.playExplodeSound()
  audioManager.playSfx(audioManager.explodeSound)
end

function audioManager.playDeathSound()
  audioManager.playSfx(audioManager.deathSound)
end

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