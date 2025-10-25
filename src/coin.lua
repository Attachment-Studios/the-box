-- coin.lua

require "jumping platformer"
require "player"
require "window"

function coinlua()
	startup = startup + 1
end

collY = -1000
collX = -1000
coinTableX = {}
coinTableY = {}
--coinImg = love.graphics.line()--love.graphics.newImage("The Box Coin.png")
maxCoinEntityOnScreen = 10
maxCoinDistance = love.math.random(500, 700)
coinSpeed = 100

function coinMove()
	if gS == "Play" then
		for i = 1, #coinTableX do
			coinTableX[i] = coinTableX[i]-(coinSpeed) * love.timer.getDelta()
		end
		collX = collX-(coinSpeed) * love.timer.getDelta()
	end
end

function coinReset()
	if gS ~= "Play" then
		coinSpeed = 100
	end
end

function coinSpawn()
	if #coinTableX <= maxCoinEntityOnScreen then
		if ( #coinTableX >= 1 and coinTableX[#coinTableX] <= maxCoinDistance ) or #coinTableX == 0 then
			if gS == "Play" then
				table.insert(coinTableX, width+100)
				table.insert(coinTableY, groundHeight - math.random(50, 150))
				maxCoinDistance = love.math.random(500, 700)
			end
		end
	end
end

function coinDraw()
	for kx, x in pairs(coinTableX) do
		--for ky, y in pairs(coinTableY) do
		love.graphics.line(x-10, coinTableY[kx], x, coinTableY[kx]+10, x+10, coinTableY[kx], x, coinTableY[kx]-10, x-10, coinTableY[kx])
		--love.graphics.draw(coinImg, x, y, 0, 0.05, 0.05)
		--end
	end
end

function coinDespawn()
	for CoinNum, position in pairs(coinTableX) do
		if position < -30 then
			table.remove(coinTableX, CoinNum)
			table.remove(coinTableY, CoinNum)
		end
	end
	for CoinNum, position in pairs(coinTableX) do
		if position-10 < p.x+p.w and position+10 > p.x then
			if p.y+p.h > coinTableY[CoinNum]-10 and p.y < coinTableY[CoinNum]+10 then
				ps.collParticles:emit(25)
				collY = coinTableY[CoinNum]
				collX = coinTableX[CoinNum]
				table.remove(coinTableX, CoinNum)
				table.remove(coinTableY, CoinNum)
			end
		end
	end
	if gS ~= "Play" then
		for i = 1, #coinTableX do
			table.remove(coinTableX, #coinTableX)
			table.remove(coinTableY, #coinTableY)
		end
	end
end

function coinUpdate()
	coinReset()
	coinSpawn()
	coinDespawn()
	coinMove()
	coinSpeed = coinSpeed+0.01
end