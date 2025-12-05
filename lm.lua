local lm = {
	_VERSION      = "lovemod 0.1",
	_DESCRIPTION  = "A LÖVE library for integrating mod support.",
	_URL          = "https://github.com/notcl4y14/lovemod",
	_LICENSE      = [[
	MIT License

	Copyright (c) 2025 notcl4y14

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
	]],
}

-- Util. functions

local function merge_tables(t1, t2)
	local t = {}

	for k, v in pairs(t1) do
		t[k] = v
	end

	for k, v in pairs(t2) do
		t[k] = v
	end

	return t
end

-- Library functions

local function LoadMod(module, path, env)
	local env = env or merge_tables(_G, { "lm" })

	-- Encapsulates a require function that exclusively
	-- uses the mod's path, A.K.A relative path
	env["require"] = function (module)
		local old_path = package.path

		local res = require(path.."/"..module)

		-- Return package.path to its old state
		-- to prevent further conflicts
		package.path = old_path

		return res
	end

	-- Disable all of the functions
	setfenv(module, { ["require"] = env["require"] })

	local ok, result = pcall(module)

	if not ok then
		return nil, result
	end

	-- Let all the functions have access to the environment
	for _, item in pairs(result) do
		if type(item) == "function" then
			-- TODO: sandbox the environment
			setfenv(item, env)
		end
	end

	return result, ""
end


lm.LoadMod = LoadMod

return lm
