-- reboot and delete

function rebootlua()
	startup = startup + 1
end

function reboot()
	local doReboot = love.window.showMessageBox("Reboot?", "Do you want to reboot your game such that it can permanently deleted?\nThe data can not be regained unless any backups saved externally by you.\nAre you sure?", { "Yes", "No" })
	if doReboot == 1 then
		love.filesystem.remove("tbrx.txt")
		love.filesystem.remove("tbry.txt")
		love.filesystem.remove("tbs.txt")
		love.filesystem.remove("tbr.txt")
		love.filesystem.remove("tba.txt")
		love.filesystem.remove("tbm.txt")
		love.filesystem.remove("tbfx.txt")
		love.filesystem.remove("tbhs.txt")
		love.filesystem.remove("tbscrc.txt")
		love.event.quit("quit")
	else
		return
	end
end