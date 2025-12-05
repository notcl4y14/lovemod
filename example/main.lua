local modapi = require("api")

function love.load()
	modapi.LoadModDirectory("mods")

	for _, mod in pairs(modapi.GetMods()) do
		if mod.load then mod.load() end
	end
end

function love.update(dt)
	for _, mod in pairs(modapi.GetMods()) do
		if mod.update then mod.update(dt) end
	end
end

function love.draw()
	for _, mod in pairs(modapi.GetMods()) do
		if mod.draw then mod.draw() end
	end
end
