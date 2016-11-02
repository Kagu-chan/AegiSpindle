--[[
name:Matrix
fullname:Spindle.Matrix
description:Matrix Vectoring Module
fulldescription:Create and work with vector based 4D matrixes
extends:
depends:Vectors,OOP,Table
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/matrix.md
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
Spindle.modules.require("table")

Spindle.oop.generateClass("Matrix", {
	p1 = Vector4D.new(1, 0, 0, 0),
	p2 = Vector4D.new(0, 1, 0, 0),
	p3 = Vector4D.new(0, 0, 1, 0),
	p4 = Vector4D.new(0, 0, 0, 1)
}, {}, {})

function Matrix:identity()
	self:p1(Vector4D.new(1, 0, 0, 0))
	self:p2(Vector4D.new(0, 1, 0, 0))
	self:p3(Vector4D.new(0, 0, 1, 0))
	self:p4(Vector4D.new(0, 0, 0, 1))
	return self
end
function Matrix:toArray()
	local a1, a2, a3, a4
	a1 = self:p1()
	a2 = self:p2()
	a3 = self:p3()
	a4 = self:p4()
	return {
		a1:x(), a1:y(), a1:z(), a1:w(),
		a2:x(), a2:y(), a2:z(), a2:w(),
		a3:x(), a3:y(), a3:z(), a3:w(),
		a4:x(), a4:y(), a4:z(), a4:w()
	}
end
function Matrix:fromArray(arr)
	Spindle.assert({"table"}, {arr})
	self:p1(Vector4D.new(arr[1], arr[2], arr[3], arr[4]))
	self:p2(Vector4D.new(arr[5], arr[6], arr[7], arr[8]))
	self:p3(Vector4D.new(arr[9], arr[10], arr[11], arr[12]))
	self:p4(Vector4D.new(arr[13], arr[14], arr[15], arr[16]))
	return self
end
function Matrix:get(i)
	Spindle.assert({"number"}, {i})
	return self:toArray()[i]
end
function Matrix:set(i, v)
	Spindle.assert({"number", "number"}, {i, v})
	local arr = self:toArray()
	arr[i] = v

	return self:fromArray(arr)
end
function Matrix:multiply(mat)
	Spindle.assert({"matrix"}, {mat})
	
	local newMat = Matrix.new()
	local newMatArr = {
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0,
		0, 0, 0, 0
	}

	local selfArr = self:toArray()
	local matArr = mat:toArray()

	for i=1, 16 do
		for j=0, 3 do
			newMatArr[i] = newMatArr[i] + selfArr[1 + (i-1) % 4 + j * 4] * matArr[1 + math.floor((i-1) / 4) * 4 + j]
		end
	end

	return self:fromArray(newMatArr)
end
function Matrix:translate(vector)
	Spindle.assert({"vector3d"}, {vector})
	local tmpMatrix = Matrix.new()
	local v4d = vector:to4d()
	tmpMatrix:p4(v4d)

	return self:multiply(tmpMatrix)
end
function Matrix:scale(vector)
	Spindle.assert({"vector3d"}, {vector})
	local tmpMatrix = Matrix.new()
	tmpMatrix:set(1, vector:x())
	tmpMatrix:set(6, vector:y())
	tmpMatrix:set(11, vector:z())

	return self:multiply(tmpMatrix)
end
function Matrix:rotate(axis, angle)
	Spindle.assert({"string", "number"}, {axis, angle})
	local tmpMatrix = Matrix.new()
	local applies = {}

	angle = math.rad(angle)

	if axis == "x" then
		applies[6] = math.cos(angle)
		applies[7] = -math.sin(angle)
		applies[10] = math.sin(angle)
		applies[11] = math.cos(angle)
	elseif axis == "y" then
		applies[1] = math.cos(angle)
		applies[3] = math.sin(angle)
		applies[9] = -math.sin(angle)
		applies[11] = math.cos(angle)
	else
		applies[1] = math.cos(angle)
		applies[2] = -math.sin(angle)
		applies[5] = math.sin(angle)
		applies[6] = math.cos(angle)
	end
	for i, v in pairs(applies) do tmpMatrix:set(i, v) end
	return self:multiply(tmpMatrix)
end
function Matrix:inverse()
	local matrix = self:toArray()

	local inv_matrix = {
		matrix[6] * matrix[11] * matrix[16] - matrix[6] * matrix[15] * matrix[12] - matrix[7] * matrix[10] * matrix[16] + matrix[7] * matrix[14] * matrix[12] +matrix[8] * matrix[10] * matrix[15] - matrix[8] * matrix[14] * matrix[11],
		-matrix[2] * matrix[11] * matrix[16] + matrix[2] * matrix[15] * matrix[12] + matrix[3] * matrix[10] * matrix[16] - matrix[3] * matrix[14] * matrix[12] - matrix[4] * matrix[10] * matrix[15] + matrix[4] * matrix[14] * matrix[11],
		matrix[2] * matrix[7] * matrix[16] - matrix[2] * matrix[15] * matrix[8] - matrix[3] * matrix[6] * matrix[16] + matrix[3] * matrix[14] * matrix[8] + matrix[4] * matrix[6] * matrix[15] - matrix[4] * matrix[14] * matrix[7],
		-matrix[2] * matrix[7] * matrix[12] + matrix[2] * matrix[11] * matrix[8] +matrix[3] * matrix[6] * matrix[12] - matrix[3] * matrix[10] * matrix[8] - matrix[4] * matrix[6] * matrix[11] + matrix[4] * matrix[10] * matrix[7],
		-matrix[5] * matrix[11] * matrix[16] + matrix[5] * matrix[15] * matrix[12] + matrix[7] * matrix[9] * matrix[16] - matrix[7] * matrix[13] * matrix[12] - matrix[8] * matrix[9] * matrix[15] + matrix[8] * matrix[13] * matrix[11],
		matrix[1] * matrix[11] * matrix[16] - matrix[1] * matrix[15] * matrix[12] - matrix[3] * matrix[9] * matrix[16] + matrix[3] * matrix[13] * matrix[12] + matrix[4] * matrix[9] * matrix[15] - matrix[4] * matrix[13] * matrix[11],
		-matrix[1] * matrix[7] * matrix[16] + matrix[1] * matrix[15] * matrix[8] + matrix[3] * matrix[5] * matrix[16] - matrix[3] * matrix[13] * matrix[8] - matrix[4] * matrix[5] * matrix[15] + matrix[4] * matrix[13] * matrix[7],
		matrix[1] * matrix[7] * matrix[12] - matrix[1] * matrix[11] * matrix[8] - matrix[3] * matrix[5] * matrix[12] + matrix[3] * matrix[9] * matrix[8] + matrix[4] * matrix[5] * matrix[11] - matrix[4] * matrix[9] * matrix[7],
		matrix[5] * matrix[10] * matrix[16] - matrix[5] * matrix[14] * matrix[12] - matrix[6] * matrix[9] * matrix[16] + matrix[6] * matrix[13] * matrix[12] + matrix[8] * matrix[9] * matrix[14] - matrix[8] * matrix[13] * matrix[10],
		-matrix[1] * matrix[10] * matrix[16] + matrix[1] * matrix[14] * matrix[12] + matrix[2] * matrix[9] * matrix[16] - matrix[2] * matrix[13] * matrix[12] - matrix[4] * matrix[9] * matrix[14] + matrix[4] * matrix[13] * matrix[10],
		matrix[1] * matrix[6] * matrix[16] - matrix[1] * matrix[14] * matrix[8] - matrix[2] * matrix[5] * matrix[16] + matrix[2] * matrix[13] * matrix[8] + matrix[4] * matrix[5] * matrix[14] - matrix[4] * matrix[13] * matrix[6],
		-matrix[1] * matrix[6] * matrix[12] + matrix[1] * matrix[10] * matrix[8] + matrix[2] * matrix[5] * matrix[12] - matrix[2] * matrix[9] * matrix[8] - matrix[4] * matrix[5] * matrix[10] + matrix[4] * matrix[9] * matrix[6],
		-matrix[5] * matrix[10] * matrix[15] + matrix[5] * matrix[14] * matrix[11] + matrix[6] * matrix[9] * matrix[15] - matrix[6] * matrix[13] * matrix[11] - matrix[7] * matrix[9] * matrix[14] + matrix[7] * matrix[13] * matrix[10],
		matrix[1] * matrix[10] * matrix[15] - matrix[1] * matrix[14] * matrix[11] - matrix[2] * matrix[9] * matrix[15] + matrix[2] * matrix[13] * matrix[11] + matrix[3] * matrix[9] * matrix[14] - matrix[3] * matrix[13] * matrix[10],
		-matrix[1] * matrix[6] * matrix[15] + matrix[1] * matrix[14] * matrix[7] + matrix[2] * matrix[5] * matrix[15] - matrix[2] * matrix[13] * matrix[7] - matrix[3] * matrix[5] * matrix[14] + matrix[3] * matrix[13] * matrix[6],
		matrix[1] * matrix[6] * matrix[11] - matrix[1] * matrix[10] * matrix[7] - matrix[2] * matrix[5] * matrix[11] + matrix[2] * matrix[9] * matrix[7] + matrix[3] * matrix[5] * matrix[10] - matrix[3] * matrix[9] * matrix[6]
	}
	local determinant = matrix[1] * inv_matrix[1] +
						matrix[5] * inv_matrix[2] +
						matrix[9] * inv_matrix[3] +
						matrix[13] * inv_matrix[4]
	
	if determinant == 0 then
		Spindle.debug("Inversion of Matrix not possible - Nothing changed!")
		return self
	end

	determinant = 1 / determinant
	for i = 1, 16 do
		matrix[i] = inv_matrix[i] * determinant
	end

	return self:fromArray(matrix)
end
function Matrix:transform(vector)
	Spindle.assert({{"vector3d", "vector4d"}}, {vector})
	if type(vector) == "vector3d" then
		vector = vector:to4d()
	end
	local matrix = self:toArray()

	return Vector4D.new(
		vector:x() * matrix[1] + vector:y() * matrix[5] + vector:z() * matrix[9] + vector:w() * matrix[13],
		vector:x() * matrix[2] + vector:y() * matrix[6] + vector:z() * matrix[10] + vector:w() * matrix[14],
		vector:x() * matrix[3] + vector:y() * matrix[7] + vector:z() * matrix[11] + vector:w() * matrix[15],
		vector:x() * matrix[4] + vector:y() * matrix[8] + vector:z() * matrix[12] + vector:w() * matrix[16]
	)
end

if Spindle.modules.loaded("type") then
	Spindle.type.ismatrix = function(object) return type(object) == "matrix" end
end