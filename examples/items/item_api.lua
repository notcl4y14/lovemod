local item_reg = require("item_reg")

local item_api = {}

function item_api.AddItem(mod, item)
	if mod == nil then
		error("item_api.AddItem(): first arugment should be the mod table")
	end

	item._MOD = mod._NAME

	table.insert(item_reg.items, item)
end

function item_api.RemoveItem(item_name)
	for _, v in pairs(item_reg.items) do
		if v.name == item_name then
			v = nil
			return
		end
	end
end

return item_api
