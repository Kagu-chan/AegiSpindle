--[[
name:Math
fullname:Spindle.Math
description:Math module
fulldescription:This module provides various math functions.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/math.md
docInternal:
	Spindle.math.randomsteps(number min, number max, number step) Returns a random value between min and max, but in given steps
	Spindle.math.trim(number x, number min, number max) Trims a number value to be not lesser then min and not greater then max
	Spindle.math.round(number x[, number dec]) Rounds a number to integer numbers or given decimal points if dec is given
	Spindle.math.pythagoras(nil | bool | number a, nil | bool | number b[, number c]) Calculates all sides of a triangle - only one parameter can be false or nil, all number values have to greater than zero
	Spindle.math.between(number x, number min, number max) Checks if x is between min and max or the same as one of them
	Spindle.math.buildWrapper() Wrapper function for core application
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local math = _G.math

Spindle.math = {
	randomsteps = function(min, max, step)
		Spindle.assert({"number", "number", "number"}, {min, max, step})
		return math.min(min + math.random(0, math.ceil((max - min) / step)) * step, max)
	end,
	trim = function(x, min, max)
		Spindle.assert({"number", "number", "number"}, {x, min, max})
		return x < min and min or x > max and max or x
	end,
	round = function(x, dec)
		Spindle.assertOverrides({"number"}, {"number", "number"}, {x, dec})
		if dec and dec >= 1 then
			dec = 10^math.floor(dec)
			return math.floor(x * dec + 0.5) / dec
		else
			return math.floor(x + 0.5)
		end
	end,
	pythagoras = function(a, b, c)
		local function cancel() error("Only numbers greater than zero accepted - the missing value has to be `nil` or `false`", 3) end
		local result = Spindle.assert({"number", "number", "boolean"}, a and b and {a, b, c and 1 or false} or a and c and {a, c, b and 1 or false} or b and c and {b, c, a and 1 or false}, true)
		if not result[1] then cancel() end
		if a and a <= 0 or b and b <= 0 or c and c <= 0 then cancel() end

		local avail, missing = nil, nil
		if a and b then
			c = math.pow((math.pow(a, 2) + math.pow(b, 2)), 0.5)
		else
			avail = a and a or b
			missing = math.pow((math.pow(c, 2) - math.pow(avail, 2)), 0.5)
			a = a and a or missing
			b = b and b or missing
		end
		return a, b, c
	end,
	between = function(val, min, max)
		Spindle.assert({"number", "number", "number"}, {val, min, max})
		return val >= min and val <= max
	end,
	buildWrapper = function()
		math.randomsteps = Spindle.math.randomsteps
		math.trim = Spindle.math.trim
		math.round = Spindle.math.round
	end,
}