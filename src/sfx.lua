-- sfx.lua

function sfxlua()
	startup = startup + 1
end

deadsfx = love.audio.newSource("/Sound Effects/dead.wav", "static")
jumpsfx = love.audio.newSource("/Sound Effects/jump.wav", "static")

function sfxjump()
	if sfx then
		jumpsfx:play()
	end
end

function sfxdead()
	if sfx then
		deadsfx:play()
	end
end