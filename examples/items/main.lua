local modding = require("modding")
local item_api = require("item_api")
local item_reg = require("item_reg")

function love.load()
	modding.LoadModDirectory("mods")

	for _, mod in pairs(modding.GetMods()) do
		mod:LoadItems(item_api)
	end
end

function love.update(dt)
	if love.keyboard.isDown("d") then
		modding.UnloadMod("Food")
	end
end

function love.draw()
	for i, item in pairs(item_reg.items) do
		love.graphics.print("[" .. item._MOD .. "]\t(" .. item.type .. ")\t" .. item.name, 0, (i-1) * 12)
	end
end
