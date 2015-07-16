--[[
name:Math-Vectors
fullname:Spindle.Math.Vectors
description:Math-Vectors module
fulldescription:This module extends the Spindle.Math module by vector mathematics.
extends:Math
depends:Math,Vectors
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/math-vectors.md
docInternal:
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