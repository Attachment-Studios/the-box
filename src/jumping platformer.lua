-- jumping platformer

require "player"
require "menu"
require "sfx"
require "window"

function jumpingplatformerlua()
	startup = startup + 1
end

gravity = 0.1
groundHeight = love.graphics.getHeight()*5/8
jumpHeight = -5
enemies = {}
enemySpeed = 100
maxEntityOnScreen = 15
maxEnemyDistance = love.math.random(400, 600)

function enemyReset()
	if gS ~= "Play" then
		enemySpeed = 100
	end
end
function enemySpawn()
	if #enemies <= maxEntityOnScreen then
		if ( #enemies >= 1 and enemies[#enemies] <= maxEnemyDistance ) or #enemies == 0 then
			if gS == "Play" then
				table.insert(enemies, width+100)
				maxEnemyDistance = love.math.random(500, 700)
			end
		end
	end
end
function enemyDraw()
	if gS == "Play" then
		for EnemyNum, position in pairs(enemies) do
			love.graphics.line(enemies[EnemyNum], groundHeight, enemies[EnemyNum]+10, groundHeight-20, enemies[EnemyNum]+20, groundHeight)
		end
	end
end
function enemyDespawn()
	for EnemyNum, position in pairs(enemies) do
		if position < -30 then
			table.remove(enemies, EnemyNum)
		end
	end
	if gS ~= "Play" then
		for i = 1, #enemies do
			table.remove(enemies, #enemies)
		end
	end
end
function enemyMove()
	if gS == "Play" then
		for i = 1, #enemies do
			enemies[i] = enemies[i]-(enemySpeed) * love.timer.getDelta()
		end
	end
end
function enemyUpdate()
	enemyReset()
	enemySpawn()
	enemyDespawn()
	enemyMove()
	playerDeath()
	groundHeight = height*5/8
	enemySpeed = enemySpeed + 0.01
end
function fall()
	gravity = ( gravity + 0.1 )
	p.y = p.y + gravity
end
jumpstate = false
function jump()
	if gravity == 0 then
		gravity = jumpHeight
		sfxjump()
		jumpstate = true
		ps.jumpParticles:emit(32)
	else
		return
	end
	p.y = p.y + gravity
end
function ground()
	love.graphics.line(-100, groundHeight, width+100, groundHeight)
	if ( p.y + p.h ) > groundHeight or ( p.y + p.h ) == groundHeight then
		gravity = 0
		p.y = groundHeight - p.h
		if jumpstate == true then
			ps.fallParticles:emit(10)
			jumpstate = false
		end
	end
end
function playerDeath()
	for EnemyNum, position in pairs(enemies) do
		if position < 120 and position > 80 then
			if p.y > groundHeight-40 then
				table.remove(enemies, EnemyNum)
				gSChanger("Menu")
				sfxdead()
				ps.enCollParticles:emit(25)
				if tonumber(hscore) < score then
					hscore = score
					save("tbhs.txt", hscore)
					hscore = tonumber(hscore)
				end
			end
		end
	end
end

