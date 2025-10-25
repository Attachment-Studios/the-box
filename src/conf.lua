require 'display'

function conflua()
	startup = startup + 1
end

function love.conf(t)

	t.externalstorage = true

	t.window.title = "The Box"
	t.window.icon ="The Box Logo.png"
	--if string.match("OS X Windows Linux", love.system.getOS()) then
		--t.window.width = 16 * 50
		--t.window.height = 9 * 50
	--end
	--t.window.minwidth = 320
	--t.window.minheight = 180
	t.window.resizable = false
	t.window.border = false
	t.window.fullscreen = true

	t.modules.physics = false
	t.modules.joystick = false
	t.modules.video = false

	t.console = false

	t.identity = 'Attachment Studios/The Box'
end
