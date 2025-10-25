-- log.lua

require "sls"

function loglua()
	startup = startup + 1
end

log = {}

log.screenshotcount = getSave("tbscrc.txt", 0)
log.screenshotcount = tonumber(log.screenshotcount)

function log.setup()
	return
end

function log.screenshot()
	local screenshotimg = love.graphics.newScreenshot()
	screenshotimg:encode('tbs'..tostring(log.screenshotcount)..'.png', 'png')
	print("screenshot saved as "..'"tbs'..tostring(log.screenshotcount)..'.png"')
	log.screenshotcount = tonumber(log.screenshotcount)
	log.screenshotcount = log.screenshotcount + 1
	save("tbscrc.txt", log.screenshotcount)
	log.screenshotcount = tonumber(log.screenshotcount)
end