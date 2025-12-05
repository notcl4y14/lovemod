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

-- Constants
local SAFE_ENV = (function()
	local t = {}

	for _, v in pairs({
		"_VERSION", "assert", "error", "ipairs", "next", "pairs",
		"pcall", "select", "tonumber", "tostring", "type", "unpack", "xpcall",
		"print",

		"coroutine.create", "coroutine.resume", "coroutine.running", "coroutine.status",
		"coroutine.wrap", "coroutine.yield",

		"math.abs", "math.acos", "math.asin", "math.atan", "math.atan2", "math.ceil",
		"math.cos", "math.cosh", "math.deg", "math.exp", "math.fmod", "math.floor",
		"math.frexp", "math.huge", "math.ldexp", "math.log", "math.log10", "math.max",
		"math.min", "math.modf", "math.pi", "math.pow", "math.rad", "math.random",
		"math.sin", "math.sinh", "math.sqrt", "math.tan", "math.tanh",

		"os.clock", "os.difftime", "os.time",

		"string.byte", "string.char", "string.find", "string.format", "string.gmatch",
		"string.gsub", "string.len", "string.lower", "string.match", "string.reverse",
		"string.sub", "string.upper",

		"table.insert", "table.maxn", "table.remove", "table.sort",

		"love.audio",
		"love.data",
		"love.font",
		"love.graphics",
		"love.image",
		"love.joystick",
		"love.keyboard",
		"love.math",
		"love.mouse",
		"love.physics",
		"love.sound",
		"love.system",
		"love.thread",
		"love.timer",
		"love.touch",
		-- "love.video",
		-- "love.window",
	}) do
		-- https://github.com/APItools/sandbox.lua/blob/master/sandbox.lua#L75
		local a, b = v:match('([^%.]+)%.([^%.]+)')

		if a then
			t[a]    = t[a] or {}
			t[a][b] = _G[a][b]
		else
			t[v] = _G[v]
		end
	end

	return t
end)()

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
	local env = env

	if env == nil then
		env = SAFE_ENV
	else
		env = merge_tables(SAFE_ENV, env)
	end

	-- Environment replacement functions
	env["require"] = function (module)
		return require(path.."/"..module)
	end

	-- Sandbox the functions
	setfenv(module, env)

	local ok, result = pcall(module)

	if not ok then
		return nil, result
	end

	return result, ""
end


lm.LoadMod = LoadMod

return lm
