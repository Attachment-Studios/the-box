-- settings.lua

require "menu"

function settingslua()
	startup = startup + 1
end

SFX = false

settings = {}
ratio = love.graphics.newImage("Ratio.png")

function settings.draw()
	if gState("Settings") then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.draw(audioicon, 0, 60, 0, 0.3, 0.3)
	--love.graphics.draw(ratio, 100, 60, 0, 0.3, 0.3)
	love.graphics.print("Reboot", 25, 155, 0, 0.5, 0.5)
end
