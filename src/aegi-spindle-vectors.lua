--[[
name:Vectors
fullname:Spindle.Vectors
description:Vector Classes Module
fulldescription:This module will generate the Vector classes for working with shapes and similar tasks.
extends:
depends:OOP
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/vectors.md
docInternal:
	Vector2D Vector2D Object
	Vector2D.new(int x, int y) Creates a new Instance of Vector2D
	Vector2D.fromtable(table t) Creates instance from given table
	Vector2D:x([int x]) Sets or gets x value of instance
	Vector2D:y([int y]) Sets or gets y value of instance
	Vector2D:totable() Returns table representation of instance
	Vector2D:distance() Returns distance length of instance
	Vector2D:to3d() Parse instance to Vector3D
	Vector2D:to4d() Parse instance to Vector4D
	Vector3D Vector3D Object
	Vector3D.new(int x, int y, int z) Creates a new Instance of Vector3D
	Vector3D.fromtable(table t) Creates instance from given table
	Vector3D:x([int x]) Sets or gets x value of instance
	Vector3D:y([int y]) Sets or gets y value of instance
	Vector3D:z([int z]) Sets or gets z value of instance
	Vector3D:totable() Returns table representation of instance
	Vector3D:distance() Returns distance length of instance
	Vector3D:to2d() Parse instance to Vector2D
	Vector3D:to4d() Parse instance to Vector4D
	Vector4D Vector4D Object
	Vector4D.new(int x, int y, int z, int w) Creates a new Instance of Vector4D
	Vector4D.fromtable(table t) Creates instance from given table
	Vector4D:x([int x]) Sets or gets x value of instance
	Vector4D:y([int y]) Sets or gets y value of instance
	Vector4D:z([int z]) Sets or gets z value of instance
	Vector4D:w([int w]) Sets or gets w value of instance
	Vector4D:totable() Returns table representation of instance
	Vector4D:distance() Returns distance length of instance
	Vector4D:to2d() Parse instance to Vector2D
	Vector4D:to3d() Parse instance to Vector3D
#only if module "type" is loaded:
	Spindle.type.isvector2d(mixed object) Returns is x is a vector2d type
	Spindle.type.isvector3d(mixed object) Returns is x is a vector3d type
	Spindle.type.isvector4d(mixed object) Returns is x is a vector4d type
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local math, type = _G.math, _G.type

Spindle.modules.require("oop")

Spindle.oop.generateClass("Vector2D", {}, {}, {x = "number", y = "number"}, "x", "y")
Spindle.oop.generateClass("Vector3D", {}, {}, {x = "number", y = "number", z = "number"}, "x", "y", "z")
Spindle.oop.generateClass("Vector4D", {}, {}, {x = "number", y = "number", z = "number", w = "number"}, "x", "y", "z", "w")

function Vector2D:distance()
	return math.sqrt(self:x() * self:x() + self:y() * self:y())
end
function Vector2D:to3d()
	return Vector3D.new(self:x(), self:y(), 0)
end
function Vector2D:to4d()
	return Vector2D.new(self:x(), self:y(), 0, 1)
end

function Vector3D:distance()
	return math.sqrt(self:x() * self:x() + self:y() * self:y() + self:z() * self:z())
end
function Vector3D:to2d()
	return Vector2D.new(self:x(), self:y())
end
function Vector3D:to4d()
	return Vector2D.new(self:x(), self:y(), self:z(), 1)
end

function Vector4D:distance()
	return math.sqrt(self:x() * self:x() + self:y() * self:y() + self:z() * self:z() + self:w() * self:w())
end
function Vector4D:to2d()
	return Vector2D.new(self:x() / self:w(), self:y() / self:w())
end
function Vector4D:to3d()
	return Vector2D.new(self:x() / self:w(), self:y() / self:w(), self:z() / self:w())
end

if Spindle.modules.loaded("type") then
	Spindle.type.isvector2d = function(object) return type(object) == "vector2d" end
	Spindle.type.isvector3d = function(object) return type(object) == "vector3d" end
	Spindle.type.isvector4d = function(object) return type(object) == "vector4d" end
end