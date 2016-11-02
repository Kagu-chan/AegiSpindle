--[[
name:Shape
fullname:Spindle.Shape
description:Drawing Module
fulldescription:Draw, identify and manipulate drawing shapes
extends:Vectors
depends:Vectors,OOP,Math
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/shape.md
docInternal:
	Matrix Matrix Object
	Matrix.new() Creates a new Instance of Matrix
	Matrix.fromtable(table t) Creates instance from given table
	Matrix.extendProperty(string name, mixed _type) Add new property and respective getter / setter to the object
	Matrix:totable() Returns table representation of instance
	Matrix:p1([Vector4D p1]) Sets or gets p1 value of instance
	Matrix:p2([Vector4D p2]) Sets or gets p2 value of instance
	Matrix:p3([Vector4D p3]) Sets or gets p3 value of instance
	Matrix:p4([Vector4D p4]) Sets or gets p4 value of instance
	Matrix:identity() Resets the Matrix to its default values
	Matrix:toArray() Returns a list with the 16 single coordinates of the matrix
	Matrix:fromArray(table arr) Rebuilds the matrix from a 16 elements sized number values table
	Matrix:get(int i) Returns the value at position i in a list representation of the matrix
	Matrix:set(int i, number v) Sets the value at position i in a list representation of the matrix
	Matrix:multiply(Matrix mat) Multiply with an other matrix
	Matrix:translate(Vector3D vector) Apply a point translation to the matrix
	Matrix:scale(Vector3D vector) Apply a point scale to the matrix
	Matrix:rotate(string axis, number angle) Rotate the Matrix by given angle at given axis
	Matrix:inverse() Inverse a matrix if possible
	Matrix:transform(Vector3D | Vector4D vector) Transform a point with the matrix
#only if module "type" is loaded:
	Spindle.type.ismatrix(mixed object) Returns is x is a matrix type
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local math = _G.math

Spindle.modules.require("vectors")

Spindle.oop.generateClass("Move", {
	x = 0,
	y = 0
}, {}, {p = "point"}, "p")

_G.Point = _G.Vector2D

function Point:type()
	return "point"
end
function Point:to2d()
	return Vector2D.new(self:x(), self:y())
end
function Point:toMove()
	return Move.new(self)
end
function Vector2D:toPoint()
	return Point.new(self:x(), self:y())
end
function Vector2D:toMove()
	return Move.new(self)
end
function Vector3D:toPoint()
	return Point.new(self:x(), self:y())
end
function Vector3D:toMove()
	return Move.new(Point.new(self:x(), self:y()))
end
function Vector4D:toPoint()
	return Point.new(self:x() / self:w(), self:y() / self:w())
end
function Vector4D:toMove()
	return Move.new(Point.new(self:x(), self:y()))
end

Move.new = function(param)
	Spindle.assert({{"point", "vector2d"}}, {param})
	local meta = _G["Move"]
	local cons = {}
	
	for key, value in pairs(meta.propDefaults) do
		if (type(value) == "table" and value.type) then
			if type(value.type) == "function" then
				cons["_" .. key] = value
			else
				cons["_" .. key] = value.default and value.default or value.type
			end
		else
			cons["_" .. key] = value
		end
	end

	cons["_x"] = param:x()
	cons["_y"] = param:y()
	return setmetatable(cons, meta)
end

function Move:point(val)
	if val then
		Spindle.assert({"point"}, {val})
		self:x(val:x())
		self:y(val:y())
	else
		return Point.new(self:x(), self:y())
	end
end

function Move:vector2d(val)
	if val then
		Spindle.assert({"vector2d"}, {val})
		self:x(val:x())
		self:y(val:y())
	else
		return Vector2D.new(self:x(), self:y())
	end
end

Spindle.oop.generateClass("Line", {
	point = Point.new(0, 0)
}, {}, {to = "point"}, "to")

Line.new = function(param)
	Spindle.assert({{"point", "vector2d"}}, {param})
	local meta = _G["Line"]
	local cons = {}
	
	for key, value in pairs(meta.propDefaults) do
		if (type(value) == "table" and value.type) then
			if type(value.type) == "function" then
				cons["_" .. key] = value
			else
				cons["_" .. key] = value.default and value.default or value.type
			end
		else
			cons["_" .. key] = value
		end
	end

	cons["_point"] = Point.new(param:x(), param:y())
	return setmetatable(cons, meta)
end

function Line:vector2d(val)
	if val then
		Spindle.assert({"vector2d"}, {val})
		self:point(val:toPoint())
	else
		return self:point():to2d()
	end
end

Spindle.oop.generateClass("Bezier", {
	point1 = Point.new(0, 0),
	point2 = Point.new(0, 0),
	point3 = Point.new(0, 0)
}, {}, {p1 = "point", p2  = "point", p3 = "point"}, "p1", "p2", "p3")

Bezier.new = function(param1, param2, param3)
	Spindle.assert({{"point", "vector2d"}, {"point", "vector2d"}, {"point", "vector2d"}}, {param1, param2, param3})
	local meta = _G["Bezier"]
	local cons = {}
	
	for key, value in pairs(meta.propDefaults) do
		if (type(value) == "table" and value.type) then
			if type(value.type) == "function" then
				cons["_" .. key] = value
			else
				cons["_" .. key] = value.default and value.default or value.type
			end
		else
			cons["_" .. key] = value
		end
	end

	cons["_point1"] = Point.new(param1:x(), param1:y())
	cons["_point2"] = Point.new(param2:x(), param2:y())
	cons["_point3"] = Point.new(param3:x(), param3:y())
	return setmetatable(cons, meta)
end

function Bezier:p1(val)
	if val then
		Spindle.assert({"point"}, {val})
		self:point1(val)
	else
		return self:point1()
	end
end

function Bezier:p2(val)
	if val then
		Spindle.assert({"point"}, {val})
		self:point2(val)
	else
		return self:point2()
	end
end

function Bezier:p3(val)
	if val then
		Spindle.assert({"point"}, {val})
		self:point3(val)
	else
		return self:point3()
	end
end

function Bezier:v1(val)
	if val then
		Spindle.assert({"vector2d"}, {val})
		self:point1(val:toPoint())
	else
		return self:point1():to2d()
	end
end

function Bezier:v2(val)
	if val then
		Spindle.assert({"vector2d"}, {val})
		self:point2(val:toPoint())
	else
		return self:point2():to2d()
	end
end

function Bezier:v3(val)
	if val then
		Spindle.assert({"vector2d"}, {val})
		self:point3(val:toPoint())
	else
		return self:point3():to2d()
	end
end

Spindle.oop.generateClass("Shape", {
	chain = {Move.new(Point.new(0, 0))},
	precision = 0
}, {}, {})

function Shape:__tostring()
	local chain = self:chain()
	local str = ""
	local last = ""
	local round = self:precision() ~= 0
	local addC = function(o)
		str = str .. (round and Spindle.math.round(o:x(), self:precision()) or o:x()) .. " "
		str = str .. (round and Spindle.math.round(o:x(), self:precision()) or o:y()) .. " "
	end
	for i = 1, #chain do
		local o = chain[i]
		local add = type(o) ~= last
		if type(o) == "move" then
			if add then str = str .. "m " end
			addC(o:point())
		elseif type(o) == "line" then
			if add then str = str .. "l " end
			addC(o:point())
		else
			if add then str = str .. "b " end
			addC(o:p1())
			addC(o:p2())
			addC(o:p3())
		end
		last = type(o)
	end
	str = str .. "c"
	return str
end
function Shape:append(object)
	Spindle.assert({{"move", "line", "bezier"}}, {object})
	local chain = self:chain()
	chain[#chain + 1] = object
	self:chain(chain)
end
function Shape:prepend(object)
	Spindle.assert({{"move", "line", "bezier"}}, {object})
	local chain = self:chain()
	local i = #chain
	while i > 0 do
		chain[i + 1] = chain[i]
		i = i - 1
	end
	chain[1] = object
	self:chain(chain)
end
function Shape:insert(i, object)
	Spindle.assert({"number", {"move", "line", "bezier"}}, {i, object})
	local chain = self:chain()
	local j = #chain
	while j >= i do
		chain[j + 1] = chain[j]
		j = j - 1
	end
	chain[i] = object
	self:chain(chain)
end
function Shape:replace(i, object)
	Spindle.assert({"number", {"move", "line", "bezier"}}, {i, object})
	local chain = self:chain()
	chain[i] = objects
	self:chain(chain)
end
function Shape:remove(index)
	Spindle.assert({"number"}, {index})
	local chain = self:chain()
	for i = index, #chain do
		chain[i] = chain[i + 1]
	end
	self:chain(chain)
end

if Spindle.modules.loaded("type") then
	Spindle.type.ispoint = function(object) return type(object) == "point" end
	Spindle.type.ismove = function(object) return type(object) == "move" end
	Spindle.type.isline = function(object) return type(object) == "line" end
	Spindle.type.isbezier = function(object) return type(object) == "bezier" end
	Spindle.type.isshape = function(object) return type(object) == "shape" end
end