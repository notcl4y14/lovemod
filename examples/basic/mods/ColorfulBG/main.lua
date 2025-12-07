local time = 0.0

local function load()
end

local function update(dt)
	time = time + dt
end

local function draw()
	love.graphics.clear(
		math.sin(time) + 0.5,
		math.sin(time - 1.0) + 0.5,
		math.sin(time - 2.0) + 0.5,
		1.0
	)
end

return { load=load, update=update, draw=draw }
