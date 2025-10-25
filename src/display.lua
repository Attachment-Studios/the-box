-- display.lua

require "sls"

os = "Windows"--love.system.getOS()

function displaylua()
	startup = startup + 1
end

rx, ry = 16, 9
r = 4
s = 10

if love.filesystem.getInfo("tbrx.txt") then
	rx = love.filesystem.read("tbrx.txt")
else
	print("error! no save file")
	love.filesystem.write("tbrx.txt", rx)
end
if love.filesystem.getInfo("tbry.txt") then
	rx = love.filesystem.read("tbry.txt")
else
	print("error! no save file")
	love.filesystem.write("tbry.txt", ry)
end
if love.filesystem.getInfo("tbr.txt") then
	rx = love.filesystem.read("tbr.txt")
else
	print("error! no save file")
	love.filesystem.write("tbr.txt", r)
end
if love.filesystem.getInfo("tbs.txt") then
	rx = love.filesystem.read("tbs.txt")
else
	print("error! no save file")
	love.filesystem.write("tbs.txt", s)
end

function displayDraw()
	if gState("Display") then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	local ratioText = rx..":"..ry
	if rx..ry == "43" then
		ratioText = " 4:3"
	end
	if rx..ry == "32" then
		ratioText = " 3:2"
	end
	love.graphics.print("Restart To Apply", 65, 20, 0, 0.4, 0.4)
	love.graphics.print("Aspect Ratio : < "..ratioText.." >", 20, 70, 0, 0.5, 0.5)
	love.graphics.print("Scale Factor : < > "..r, 20, 100, 0, 0.5, 0.5)
	love.graphics.print("Pixel Factor : < > "..s, 20, 130, 0, 0.5, 0.5)
	love.graphics.print("Reset", 20, 160, 0, 0.5, 0.5)
end
