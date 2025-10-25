-- info.lua

require "window"

function infolua()
	startup = startup + 1
end

mx, my = love.mouse.getPosition()
fps = love.timer.getFPS()

function infoUpdate()
	mx, my = love.mouse.getPosition()
	fps = love.timer.getFPS()
end

function infoDraw()
	if love.keyboard.isDown("tab") then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.print("mx / my : "..mx.." / "..my.." FPS : "..fps, 5, height-25, 0, 0.4)
end