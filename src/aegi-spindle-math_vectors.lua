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

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local math = _G.math

Spindle.modules.require("math")
Spindle.modules.require("vectors")

Spindle.math_vectors = {
	degree = function(v1, v2)
		Spindle.assert({"vector3d", "vector3d"}, {v1, v2})
		local degree = math.deg(
			math.acos(
				(
					v1:x() * v2:x() +
					v1:y() * v2:y() +
					v1:z() * v2:z()
				) / (
					v2:distance() * v2:distance()
				)
			)
		)
		return (v1:x() * v2:y() - v2:y() * v2:x()) < 0 and -degree or degree
	end,
	ortho = function(v1, v2)
		Spindle.assert({"vector3d", "vector3d"}, {v1, v2})
		return Vector3D.new(
			v1:y() * v2:z() - v1:z() * v2:y(),
			v1:z() * v2:x() - v1:x() * v2:z(),
			v1:x() * v2:y() - v1:y() * v2:x()
		)
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper and Code!")
	end
}

Spindle.modules.import(Spindle.math, Spindle.math_vectors)