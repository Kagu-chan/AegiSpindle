Spindle.Matrix
--------------
Matrix Vectoring Module

* Shortname: Matrix
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Spindle.Vectors](../modules/vectors.md), [Spindle.OOP](../modules/oop.md), [Spindle.Table](../modules/table.md)
* Source: [aegi-spindle-matrix.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-matrix.lua)

> Create and work with vector based 4D matrixes

###Matrix
Matrix Object


###Matrix.new()
Creates a new Instance of Matrix
```lua
local matrix = Matrix.new()
Spindle.debug(matrix)
--[[
	[Matrix](
		[Vector4D] p1 (
			x = 1
			y = 0
			z = 0
			w = 0
		)
		[Vector4D] p2 (
			x = 0
			y = 1
			z = 0
			w = 0
		)
		[Vector4D] p3 (
			x = 0
			y = 0
			z = 1
			w = 0
		)
		[Vector4D] p4 (
			x = 0
			y = 0
			z = 0
			w = 1
		)
	)
]]
```

###Matrix.fromtable(table t)
Creates instance from given table
```lua
local t = {
	p1 = Vector4D.new(1, 0, 0, 0),
	p2 = Vector4D.new(0, 1, 0, 0),
	p3 = Vector4D.new(0, 0, 1, 0),
	p4 = Vector4D.new(0, 0, 0, 1),
}
local matrix = Matrix.fromtable(t) -- Results in the same matrix as Matrix.new would
```

###Matrix.extendProperty(string name, mixed _type)
Add new property and respective getter / setter to the object
```lua
Matrix.extendProperty("test", 0)
-- Creates the property "test" with default value `0` and type int to Matrix
-- Also two new methods are available:
instance:test() -- Gets value of test
instance:test(int value) -- Sets value of test
-- The last parameter has to be a value of the desired type.
-- You can also use a table with element type and the desired type as string
Matrix.extendProperty("test", {type = "number"})
```

###Matrix:totable()
Returns table representation of instance
```lua
local matrix = Matrix.new()
matrix:totable()
--[[
	{
		p1 {
			x = 1
			y = 0
			z = 0
			w = 0
		},
		p2 {
			x = 0
			y = 1
			z = 0
			w = 0
		},
		p3 {
			x = 0
			y = 0
			z = 1
			w = 0
		},
		p4 {
			x = 0
			y = 0
			z = 0
			w = 1
		}
	}
]]
```

###Matrix:p1([Vector4D p1])
Sets or gets p1 value of instance
```lua
local matrix = Matrix.new()
matrix:p1(Vector4D.new(2, 3, 4, 5))
matrix:p1() -- {x = 2, y = 3, z = 4, w = 5}
```

###Matrix:p2([Vector4D p2])
Sets or gets p2 value of instance
```lua
local matrix = Matrix.new()
matrix:p2(Vector4D.new(2, 3, 4, 5))
matrix:p2() -- {x = 2, y = 3, z = 4, w = 5}
```

###Matrix:p3([Vector4D p3])
Sets or gets p3 value of instance
```lua
local matrix = Matrix.new()
matrix:p3(Vector4D.new(2, 3, 4, 5))
matrix:p3() -- {x = 2, y = 3, z = 4, w = 5}
```

###Matrix:p4([Vector4D p4])
Sets or gets p4 value of instance
```lua
local matrix = Matrix.new()
matrix:p4(Vector4D.new(2, 3, 4, 5))
matrix:p4() -- {x = 2, y = 3, z = 4, w = 5}
```

###Matrix:identity()
Resets the Matrix to its default values


###Matrix:toArray()
Returns a list with the 16 single coordinates of the matrix
```lua
local matrix = Matrix.new()
matrix:toArray() -- {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
```

###Matrix:fromArray(table arr)
Rebuilds the matrix from a 16 elements sized number values table
```lua
local arr = {1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}
local matrix = Matrix.new()
matrix:fromArray(arr) -- Values transported to matrix
```

###Matrix:get(int i)
Returns the value at position i in a list representation of the matrix
```lua
local matrix = Matrix.new()
matrix:get(1) -- 1
```

###Matrix:set(int i, number v)
Sets the value at position i in a list representation of the matrix
```lua
local matrix = Matrix.new()
matrix:set(3, 7)
matrix:get(3) -- 7
matrix:p1():z() -- 7
```

###Matrix:multiply(Matrix mat)
Multiply with an other matrix
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:toArray() -- {627, 0, 64, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 4, 0, 1}
```

###Matrix:translate(Vector3D vector)
Apply a point translation to the matrix
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:translate(Vector3D.new(3, 6, 9))
matrix:toArray() --[[ 
{
	627,
	0,
	64,
	0,
	0,
	1,
	0,
	0,
	0,
	0,
	1,
	0,
	1881,
	10,
	201,
	1
}
]]
```

###Matrix:scale(Vector3D vector)
Apply a point scale to the matrix
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:translate(Vector3D.new(3, 6, 9))
matrix:scale(Vector3D.new(3, 6, 9))
matrix:toArray() --[[
{
	1881,
	0,
	192,
	0,
	0,
	6,
	0,
	0,
	0,
	0,
	9,
	0,
	1881,
	10,
	201,
	1
}
]]
```

###Matrix:rotate(string axis, number angle)
Rotate the Matrix by given angle at given axis
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:translate(Vector3D.new(3, 6, 9))
matrix:scale(Vector3D.new(3, 6, 9))
matrix:rotate("x", 13)
matrix:rotate("y", 13)
matrix:rotate("z", 13)
matrix:toArray() --[[
{
	1785.8158005444,
	-1.0192772853748,
	184.66176598851,
	0,
	412.28806355513,
	5.7646812968701,
	40.554714163689,
	0,
	-423.13293322081,
	1.3151134403672,
	-34.646029225676,
	0,
	1881,
	10,
	201,
	1
}
]]
```

###Matrix:inverse()
Inverse a matrix if possible
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:translate(Vector3D.new(3, 6, 9))
matrix:scale(Vector3D.new(3, 6, 9))
matrix:rotate("x", 13)
matrix:rotate("y", 13)
matrix:rotate("z", 13)
matrix:inverse()
matrix:toArray() --[[
{
	-0.0024913596624627, 
	0.002043212433844, 
	-0.010887163325289, 
	0, 
	-0.028313257927079, 
	0.16013003602417, 
	0.03653092889909, 
	0, 
	0.029352315355427, 
	-0.018875505284719, 
	0.10548855812773, 
	0, 
	-0.93043528207764, 
	-1.6506063860738, 
	-1.0897552577966, 
	1
}
]]
```

###Matrix:transform(Vector3D | Vector4D vector)
Transform a point with the matrix
```lua
local matrix = Matrix.new()
matrix:set(1, 33)
local matrixB = Matrix.new()
matrixB:set(3, 64)
matrixB:set(1, 19)
matrixB:set(14, 4)
matrix:multiply(matrixB)
matrix:translate(Vector3D.new(3, 6, 9))
matrix:scale(Vector3D.new(3, 6, 9))
matrix:rotate("x", 13)
matrix:rotate("y", 13)
matrix:rotate("z", 13)
matrix:inverse()

local point = Vector4D.new(3, 6, 9, 12)
point = matrix:transform(point) -- {-19.010246327001, -11.078406173283, -11.941141986991, 12}
```


`only if module "type" is loaded:`

###Spindle.type.ismatrix(mixed object)
Returns is x is a matrix type

