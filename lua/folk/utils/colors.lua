local M = {}

local hsluv = require "folk.lib.hsluv"

local function parse_hex(color)
	color = color:lower()
	local r, g, b = color:match("^#(%x%x)(%x%x)(%x%x)$")
	if not r then error("Invalid hex color: " .. color) end
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function to_hex(r, g, b)
	return string.format("#%02x%02x%02x",
		math.floor(math.min(255, math.max(0, r)) + 0.5),
		math.floor(math.min(255, math.max(0, g)) + 0.5),
		math.floor(math.min(255, math.max(0, b)) + 0.5)
	)
end

function M.blend(color1, color2, ratio)
	local r1, g1, b1 = parse_hex(color1)
	local r2, g2, b2 = parse_hex(color2)

	local r = r1 * ratio + r2 * (1 - ratio)
	local g = g1 * ratio + g2 * (1 - ratio)
	local b = b1 * ratio + b2 * (1 - ratio)

	return to_hex(r, g, b)
end

function M.darken(color, amount, base)
	return M.blend(color, base or "#000000", 1 - math.abs(amount))
end

function M.lighten(color, amount, base)
	return M.blend(color, base or "#ffffff", 1 - math.abs(amount))
end


function M.vary_color(palettes, default)
	local flvr = require("folk").flavour

	if palettes[flvr] ~= nil then return palettes[flvr] end
	return default
end


return M
