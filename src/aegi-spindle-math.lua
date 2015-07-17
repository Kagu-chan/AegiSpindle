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
	buildWrapper = function()
		math.randomsteps = Spindle.math.randomsteps
		math.trim = Spindle.math.trim
		math.round = Spindle.math.round
	end,
}