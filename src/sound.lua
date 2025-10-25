-- settings.lua

require "menu"
require "sfx"

function soundlua()
	startup = startup + 1
end

sfxImg = love.graphics.newImage("sfx.png")
song1 = love.audio.newSource("/TB Music/1.ogg", "stream") -- original
song2 = love.audio.newSource("/TB Music/2.ogg", "stream") -- seriously cool
song3 = love.audio.newSource("/TB Music/3.ogg", "stream") -- upgraded classic
song4 = love.audio.newSource("/TB Music/4.ogg", "stream") -- retro box
song5 = love.audio.newSource("/TB Music/5.ogg", "stream") -- never-ending road
song6 = love.audio.newSource("/TB Music/6.ogg", "stream") -- forest vibes
song7 = love.audio.newSource("/TB Music/7.ogg", "stream") -- dangerous
song8 = love.audio.newSource("bgm.ogg", "stream") -- bgm
songPlaying = 1
songName = "Original"
songPlaying = getSave("tbm.txt", 1)
songPlaying = tonumber(songPlaying)
song1:play()
song2:play()
song3:play()
song4:play()
song5:play()
song6:play()
song7:play()
song8:play()
love.audio.stop(song1)
love.audio.stop(song2)
love.audio.stop(song3)
love.audio.stop(song4)
love.audio.stop(song5)
love.audio.stop(song6)
love.audio.stop(song7)
love.audio.stop(song8)

function soundsDraw()
	if gState("Sounds") then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.draw(audioicon, 0, 60, 0, 0.3, 0.3)
	love.graphics.draw(sfxImg, 90, 60, 0, 0.3, 0.3)
	love.graphics.print("Music :    < > "..songPlaying.." : "..songName, 25, 140, 0, 0.5, 0.5)
	if not audio and gS == "Sounds" then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.setLineWidth(5)
	love.graphics.line(25, 85, 70, 122.5)
	if not sfx and gS == "Sounds" then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.setLineWidth(5)
	love.graphics.line(110, 85, 155, 122.5)
end

function playSong()
	if songPlaying == 1 then
		song1:play()
		songName = "Original"
	elseif songPlaying == 2 then
		song2:play()
		songName = "Seriously Cool"
	elseif songPlaying == 3 then
		song3:play()
		songName = "Upgraded Classic"
	elseif songPlaying == 4 then
		song4:play()
		songName = "Retro Box"
	elseif songPlaying == 5 then
		song5:play()
		songName = "Never Ending Road"
	elseif songPlaying == 6 then
		song6:play()
		songName = "Forest Vibes"
	elseif songPlaying == 7 then
		song7:play()
		songName = "Dangerous"
	elseif songPlaying == 8 then
		song8:play()
		songName = "First BGM"
	end
end

function nextSong()
	love.audio.stop()
	songPlaying = songPlaying + 1
	if songPlaying > 7 then
		songPlaying = 1
	end
	save("tbm.txt", songPlaying)
	songPlaying = tonumber(songPlaying)
end

function prevSong()
	love.audio.stop()
	songPlaying = songPlaying - 1
	if songPlaying < 1 then
		songPlaying = 7
	end
	save("tbm.txt", songPlaying)
	songPlaying = tonumber(songPlaying)
end