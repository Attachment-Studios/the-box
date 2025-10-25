-- The Box

require "player"
require "jumping platformer"
require "menu"
require "settings"
require "sfx"
require "coin"
require "display"
require "info"
require "sls"
require "sound"
require "reboot"
require "window"
require "log"
require "particles"
require "console"
require "shaders"
local moonshine = require "moonshine"

startup = 1

function love.load()
	if love.system.getOS() == "Windows" then
		love.window.setMode(16*50, 9*50, { resizable = false })
		love.window.setFullscreen(false)
	end
	log.setup()
	bgm = love.audio.newSource("bgm.ogg", "stream")
	score = 0
	hscore = getSave("tbhs.txt", 0)
	ww, wh = love.window.getMode()
	audio = true
	audio = getSave("tba.txt", "true")
	function toboolean(value)
		if value == 1 or value == "1" or value == "true" or value == true then
			return true
		else
			return false
		end
	end
	sfx = getSave("tbfx.txt", "true")
	sfx = toboolean(sfx)
	shader = love.graphics.newShader(shader_code)
	effect = moonshine(moonshine.effects.glow)
	effect.glow.min_luma = .01
	effect.glow.strength = 10

	clikX = {}
	clikY = {}
	cp = {}
end

hscorebreak = false
hscorebreakpause = false
hscorebreaktext = ''
hscorebreaktexta = ''
hstt = 0

function love.update(dt)
	audio = toboolean(audio)
	if love.audio.getActiveSourceCount() == 0 and audio then
		playSong()
	end
	if not audio then
		love.audio.stop(song1)
		love.audio.stop(song2)
		love.audio.stop(song3)
		love.audio.stop(song4)
		love.audio.stop(song5)
		love.audio.stop(song6)
		love.audio.stop(song7)
		love.audio.stop(song8)
	end
	if gS == 'Menu' and hscorebreak == true then
		for i = 1, 4 do
			table.insert(cp, ps.clikParticles:clone())
			table.insert(clikX, math.floor((love.graphics.getWidth()/4) * i) - (love.graphics.getWidth()/8))
			table.insert(clikY, love.graphics.getHeight() / 3)
			cp[#cp]:emit(25)
		end
		if hscorebreaktexta == 'New Highscore!' and not(pause) then
			hscorebreaktext = 'New Highscore!'
			hstt = love.timer.getTime()
			pause = true
		end
		hscorebreak = false
	end
	if math.floor((love.timer.getTime()-hstt)*100)/100 >= 1.75 and gS ~= 'Play' then
		hscorebreaktext = ''
		hscorebreaktexta = ''
		pause = false
	end
	if love.keyboard.isDown("space") or love.keyboard.isDown("space") then
		jump()
	end
	fall()
	enemyUpdate()
	coinUpdate()
	infoUpdate()
	if gS == "Play" then
		score = score + 0.05
	elseif gS == "Menu" then
		score = 0
	end
	if tonumber(score) > tonumber(hscore) then
		hscorebreak = true
		hscorebreaktexta = 'New Highscore!'
	end
	ps.jumpParticles:update(dt)
	ps.fallParticles:update(dt)
	ps.collParticles:update(dt)
	ps.clikParticles:update(dt)
	ps.enCollParticles:update(dt)
	for i = 1, #cp do
		cp[i]:update(dt)
	end
	for i = 1, #cp do
		if cp[i]:getCount() == 0 then
			table.remove(cp, i)
			table.remove(clikX, i)
			table.remove(clikY, i)
			break
		end
	end
	width, height = love.graphics.getDimensions()
end

local img = love.graphics.newImage("/Particles/sq.png")

function love.draw()
	love.graphics.setShader(shader)
	shader:send("screen", {love.graphics.getWidth(), love.graphics.getHeight()})
	effect(function()
		--godplayz(function()
		--love.graphics.draw(img, 0, 0)
		love.graphics.setBackgroundColor(0, 0, 0, 1)
		--love.graphics.setShader()
		menu()
		displayDraw()
		settings.draw()
		infoDraw()
		soundsDraw()
		love.graphics.setColor(255, 255, 255, 255)
		ps.draw(1)
		love.graphics.print(math.floor(hscore), width-(string.len(math.floor(hscore))*25)-15, 5)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(ps.jumpParticles, p.x, height*5/8, 0, 0.005, 0.005)
		love.graphics.draw(ps.fallParticles, p.x, height*5/8, 0, 0.005, 0.005)
		love.graphics.draw(ps.collParticles, collX, collY, 0, 0.005, 0.005)
		for i = 1, #cp do
			love.graphics.draw(cp[i], clikX[i], clikY[i], 0, 0.005, 0.005)
		end
		love.graphics.draw(ps.enCollParticles, p.x+(p.w/2), p.y+(p.h/2), 0, 0.005, 0.005)
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print(hscorebreaktext, (love.graphics.getWidth()/2)-(font:getWidth(hscorebreaktext)/2), love.graphics.getHeight()/3)
		p.draw()
		ground()
		enemyDraw()
		coinDraw()
		if gS == "Play" then
			love.graphics.setColor(255, 255, 255, 255)
		else
			love.graphics.setColor(255, 255, 255, 0)
		end
		love.graphics.print(math.floor(score), 5, 5)
		love.graphics.setColor(255, 255, 255, 255)
		--end)
	end)
	love.graphics.setShader()
end

function love.keypressed(key)
	if key == " " then
		jump()
	end
	if key == "up" then
		if gS == "Play" then
			jump()
		end
	end
	if key == "w" then
		if gS == "Play" then
			jump()
		end
	end
	if key == "home" then
		log.screenshot()
	end
end

function love.touchpressed(id, x, y)
	table.insert(cp, ps.clikParticles:clone())
	table.insert(clikX, x)
	table.insert(clikY, y)
	cp[#cp]:emit(25)
	if gS == "Play" then
		jump()
	end
	button(tonumber(x), tonumber(y))
	if buttonPressed(95, 70, 70, 70, x, y) then
		if gS == "Sounds" then
			sfx = not(sfx)
			sfx = toboolean(sfx)
			save("tbfx.txt", tostring(sfx))
			sfx = toboolean(sfx)
		end
	end
	if buttonPressed(175, 145, 15, 15, x, y) then
		if gState("Sounds") then
			nextSong()
		end
	elseif buttonPressed(145, 145, 15, 15, x, y) then
		if gState("Sounds") then
			prevSong()
		end
	end
	if buttonPressed(25, 155, 95, 25, x, y) then
		if gState("Settings") then
			reboot()
		end
	end
end

function love.mousepressed(x, y)
	table.insert(cp, ps.clikParticles:clone())
	table.insert(clikX, x)
	table.insert(clikY, y)
	cp[#cp]:emit(25)
	if gS == "Play" then
		jump()
	end
	button(tonumber(x), tonumber(y))
	if buttonPressed(95, 70, 70, 70, x, y) then
		if gS == "Sounds" then
			sfx = not(sfx)
			sfx = toboolean(sfx)
			save("tbfx.txt", tostring(sfx))
			sfx = toboolean(sfx)
		end
	end
	if buttonPressed(175, 145, 15, 15, x, y) then
		if gState("Sounds") then
			nextSong()
		end
	elseif buttonPressed(145, 145, 15, 15, x, y) then
		if gState("Sounds") then
			prevSong()
		end
	end
	if buttonPressed(25, 155, 95, 25, x, y) then
		if gState("Settings") then
			reboot()
		end
	end
end
