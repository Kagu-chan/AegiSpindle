--[[
name:Math-Vectors
description:Math-Vectors module
extends:Math
depends:Math,Vectors
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/math-vectors.md
docInternal:
	Spindle.math Math module
	Spindle.math.buildWrapper() Wrapper function for core application
]]

Spindle.modules.require("math")
Spindle.modules.require("vectors")

Spindle.math_vectors = {
	
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper and Code!")
	end,
}

Spindle.modules.import(Spindle.math, Spindle.math_vectors)