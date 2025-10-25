-- player(box)

function playerlua()
	startup = startup + 1
end

p = {} -- player table
p.x = 100
p.y = 350
p.w = 20
p.h = 20

function p.draw()
	love.graphics.rectangle("fill", p.x, p.y, p.w, p.h)
end

