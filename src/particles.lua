-- particles.lua

function particleslua()

end

ps = {}

ps.snowimg = love.graphics.newImage("/Particles/snow.png")
ps.forceParticles = love.graphics.newImage("/Particles/sq.png")

-- seasons
ps.snow = love.graphics.newParticleSystem(ps.snowimg, 32)
ps.snow:setParticleLifetime(10, 15)
ps.snow:setEmissionRate(5)
ps.snow:setLinearAcceleration(-200, -200, 0, 0)
ps.snow:setColors(255, 255, 255, 255, 255, 255, 255, 0)

-- jump particles
ps.jumpParticles = love.graphics.newParticleSystem(ps.forceParticles, 100)
ps.jumpParticles:setParticleLifetime(2, 5)
ps.jumpParticles:setLinearAcceleration(500, 500, -50000, 50000)
ps.jumpParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0)

-- fall particles
ps.fallParticles = love.graphics.newParticleSystem(ps.forceParticles, 100)
ps.fallParticles:setParticleLifetime(2, 5)
ps.fallParticles:setLinearAcceleration(500, 500, -50000, -15000)
ps.fallParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0)

-- coin collision particles
ps.collParticles = love.graphics.newParticleSystem(ps.forceParticles, 100)
ps.collParticles:setParticleLifetime(1, 2)
ps.collParticles:setLinearAcceleration(10000, 10000, -10000, -10000)
ps.collParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0)

-- enemy collision particles
ps.enCollParticles = love.graphics.newParticleSystem(ps.forceParticles, 100)
ps.enCollParticles:setParticleLifetime(1, 2)
ps.enCollParticles:setLinearAcceleration(100000, 100000, -100000, -100000)
ps.enCollParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0)

-- click particles
ps.clikParticles = love.graphics.newParticleSystem(ps.forceParticles, 100)
ps.clikParticles:setParticleLifetime(1, 2)
ps.clikParticles:setLinearAcceleration(10000, 10000, -10000, -10000)
ps.clikParticles:setColors(255, 255, 255, 255, 255, 255, 255, 0)

function ps.draw(psval, x, y)
	if psval == 1 then
		love.graphics.setColor(255, 255, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 0)
	end
	love.graphics.draw(ps.snow, x, y, 0, 0.01, 0.01)
end

function ps.update(val)
	ps.snow:update(val)
	ps.jumpParticles:update(val)
end
