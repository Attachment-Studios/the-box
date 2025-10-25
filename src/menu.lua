-- menu.lua

require "display"
require "sls"
require "reboot"

function menulua()
	startup = startup + 1
end

audioicon = love.graphics.newImage("audio.png")
optionsicon = love.graphics.newImage("options.png")
gS = "Menu"
font = love.graphics.newFont("font.ttf", 50)
shopicon = love.graphics.newImage("shop.png")

function gState(gState)
	if gS == gState then
		return true
	else
		return false
	end
end

function menu()
	love.graphics.setFont(font)
	if not ( gS == "Play" or gS == "Menu" ) then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.setLineWidth(5)
	love.graphics.line((0.82*40)+15, 22.5, (0.82*40)+15, 52.5, 25, 37.5, (0.82*40)+15, 22.5)
	if gS == "Menu" then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.setLineWidth(5)
	love.graphics.line(25, 22.5, 25, 52.5, (0.82*40)+15, 37.5, 25, 22.5)
	love.graphics.line(85, 20, 120, 57.5)
	love.graphics.line(85, 57.5, 120, 20)
	love.graphics.draw(optionsicon, 140, 10, 0, 0.2, 0.2)
	love.graphics.setLineWidth(1)
	if gS == "Menu" then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.setLineWidth(5)
	love.graphics.line(25, 22.5, 25, 52.5, (0.82*40)+15, 37.5, 25, 22.5)
	love.graphics.line(85, 20, 120, 57.5)
	love.graphics.line(85, 57.5, 120, 20)
	love.graphics.draw(shopicon, 210, 10, 0, 0.2, 0.2)
	love.graphics.setLineWidth(1)
end
function gSChanger(newGS)
	gS = newGS
end
function buttonPressed(x, y, w, h, xInput, yInput)
	if xInput > x and xInput < x + w and yInput > y and yInput < y + h then
		return true
	else
		return false
	end
end
function button(xInput, yInput)
	if buttonPressed(10, 75, 55, 55, xInput, yInput) then
		if gS == "Sounds" then
			audio = not(audio)
			save("tba.txt", tostring(audio))
			audio = toboolean(audio)
		end
	end
	if buttonPressed(10, 10, 55, 55, xInput, yInput) then
		if gState("Menu") then
			gSChanger("Play")
			score = 0
		elseif gState("Settings") then
			gSChanger("Menu")
		elseif gState("Shop") then
			gSChanger("Menu")
		elseif gState("Display") then
			gSChanger("Settings")
		elseif gState("Sounds") then
			gSChanger("Settings")
		end
	elseif buttonPressed(75, 10, 55, 55, xInput, yInput) then
		if gState("Menu") then
			love.event.quit("quit")
		end
	elseif buttonPressed(145, 10, 45, 55, xInput, yInput) then
		if gState("Menu") then
			gSChanger("Settings")
		end
	elseif buttonPressed(215, 10, 45, 55, xInput, yInput) then
		if gState("Menu") then
			gSChanger("Shop")
		end
	elseif buttonPressed(10, 75, 55, 55, xInput, yInput) then
		if gState("Settings") then
			gS = "Sounds"
		end
	--[[elseif buttonPressed(110, 75, 75, 55, xInput, yInput) then
		if gState("Settings") then
			gSChanger("Display")
		end]]
	elseif buttonPressed(350, 80, 15, 15, xInput, yInput) then
		if gState("Display") then
			if rx..ry == "169" then
				rx = 18
				ry = 9
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "189" then
				rx = 3
				ry = 2
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "32" then
				rx = 4
				ry = 3
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "43" then
				rx = 16
				ry = 9
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			end
			print(rx..ry)
		end
	elseif buttonPressed(245, 80, 15, 15, xInput, yInput) then
		if gState("Display") then
			if rx..ry == "169" then
				rx = 4
				ry = 3
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "43" then
				rx = 3
				ry = 2
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "32" then
				rx = 18
				ry = 9
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			elseif rx..ry == "189" then
				rx = 16
				ry = 9
				love.filesystem.write("tbrx.txt", rx)
				love.filesystem.write("tbry.txt", ry)
			end
		end
	elseif buttonPressed(245, 110, 15, 15, xInput, yInput) then
		if gState("Display") then
			r = r - 1
			if r < 1 then
				r = 50
			end
			love.filesystem.write("tbr.txt", r)
		end
	elseif buttonPressed(245, 140, 15, 15, xInput, yInput) then
		if gState("Display") then
			s = s - 1
			if s < 1 then
				s = 50
			end
			love.filesystem.write("tbs.txt", s)
		end
	elseif buttonPressed(275, 110, 15, 15, xInput, yInput) then
		if gState("Display") then
			r = r + 1
			if r > 50 then
				r = 1
			end
			love.filesystem.write("tbr.txt", r)
		end
	elseif buttonPressed(275, 140, 15, 15, xInput, yInput) then
		if gState("Display") then
			s = s + 1
			if s > 50 then
				s = 1
			end
			love.filesystem.write("tbs.txt", s)
		end
	elseif buttonPressed(20, 160, 75, 25, xInput, yInput) then
		if gState("Display") then
			r = 4
			s = 10
			rx = 18
			ry = 9
			love.filesystem.write("tbr.txt", r)
			love.filesystem.write("tbs.txt", s)
			love.filesystem.write("tbrx.txt", rx)
			love.filesystem.write("tbry.txt", ry)
		end
	end
end

