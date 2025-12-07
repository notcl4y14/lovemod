local lm = require("lm")

local api = {
	mods = {}
}

local MODULE_FILENAME = "module.lua"

local function LoadModDirectory(mods_dir)
	for _, mod_dir in pairs(love.filesystem.getDirectoryItems(mods_dir)) do
		local item_info = love.filesystem.getInfo(mods_dir.."/"..mod_dir)

		if item_info.type == "directory" then
			local ok, res = api.LoadMod(mods_dir.."/"..mod_dir)

			if not ok then
				print(res)
			end
		end
	end
end

local function LoadMod(directory)
	-- Directory
	local dir_info = love.filesystem.getInfo(directory)

	if dir_info == nil then
		return false, "Mod directory \""..directory.."\" does not exist"
	end

	if dir_info.type ~= "directory" then
		return false, "\""..directory.."\" is not a directory"
	end

	-- Module
	local module_info = love.filesystem.getInfo(directory.."/"..MODULE_FILENAME)

	if module_info == nil then
		return false, "Mod \""..directory.."\" does not have module.lua file"
	end

	if module_info.type ~= "file" then
		return false, "Why do you have a directory \"module.lua\" in mod directory \""..directory.."\""
	end

	-- Reading the module
	local module_data, err = love.filesystem.read(directory.."/"..MODULE_FILENAME)

	if module_data == nil then
		return false, err
	end

	local module_func = assert(loadstring(module_data))
	local res, err = lm.LoadMod(module_func, directory)

	if res == nil then
		return false, directory..": "..err
	end

	if res._NAME == nil then
		return false, "\""..directory.."\" lacks _NAME in module.lua"
	end

	table.insert(api.mods, res)

	return true, ""
end

local function UnloadMod(name)
	local mod = GetMod(name)

	if mod == nil then
		return false
	end

	mod = nil
	return true
end

local function GetMods()
	return api.mods
end

local function GetMod(name)
	for _, mod in pairs(api.mods) do
		if mod._NAME == name then
			return mod
		end
	end

	return nil
end


api.LoadModDirectory = LoadModDirectory
api.LoadMod = LoadMod
api.UnloadMod = UnloadMod
api.GetMods = GetMods
api.GetMod = GetMod

return api
