-- save load system.lua

function slslua()
	startup = startup + 1
end

function save(filename, data)
	love.filesystem.write(filename, data)
end

function getSave(filename, Default)
	if not ( love.filesystem.getInfo(filename) ) then
		save(filename, Default)
		print("Save File = ??")
	end
	return love.filesystem.read(filename)
end
