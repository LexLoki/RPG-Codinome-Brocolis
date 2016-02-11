audioManager={}

function audioManager.load()
  audioManager.bulletSound = love .audio.newSource("/Assets/Sfx/b1.wav")
  audioManager.musicPlaying = nil
end

function audioManager.playBulletSound()
  audioManager.playSfx(audioManager.bulletSound)
end

function audioManager.play(music)
  if audioManager.musicPlaying ~= nil then
    love.audio.stop(audioManager.musicPlaying)
  end
  audioManager.musicPlaying = music
	music:setLooping(true)
  music:setVolume(0.3)
	love.audio.play(music)
end

function audioManager.playSfx(sfx)
  if sfx:isPlaying() then
    love.audio.stop(sfx)
  end
  love.audio.play(sfx)
end