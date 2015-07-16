Spindle.Vectors
---------------
Vector Classes Module

* Shortname: Vectors
* Version: 1.0
* Author: Kagu-chan
* Depends on: [OOP](../modules/oop.md)

###Vector2D
Vector2D Object

###Vector2D.new(int x, int y)
Creates a new Instance of Vector2D

###Vector2D.fromtable(table t)
Creates instance from given table

###Vector2D:x([int x])
Sets or gets x value of instance

###Vector2D:y([int y])
Sets or gets y value of instance

###Vector2D:totable()
Returns table representation of instance

###Vector2D:distance()
Returns distance length of instance

###Vector2D:to3d()
Parse instance to Vector3D

###Vector2D:to4d()
Parse instance to Vector4D

###Vector3D
Vector3D Object

###Vector3D.new(int x, int y, int z)
Creates a new Instance of Vector3D

###Vector3D.fromtable(table t)
Creates instance from given table

###Vector3D:x([int x])
Sets or gets x value of instance

###Vector3D:y([int y])
Sets or gets y value of instance

###Vector3D:y([int z])
Sets or gets z value of instance

###Vector3D:totable()
Returns table representation of instance

###Vector3D:distance()
Returns distance length of instance

###Vector3D:to2d()
Parse instance to Vector2D

###Vector3D:to4d()
Parse instance to Vector4D

###Vector4D
Vector4D Object

###Vector4D.new(int x, int y, int z, int w)
Creates a new Instance of Vector4D

###Vector4D.fromtable(table t)
Creates instance from given table

###Vector4D:x([int x])
Sets or gets x value of instance

###Vector4D:y([int y])
Sets or gets y value of instance

###Vector4D:y([int z])
Sets or gets z value of instance

###Vector4D:y([int w])
Sets or gets w value of instance

###Vector4D:totable()
Returns table representation of instance

###Vector4D:distance()
Returns distance length of instance

###Vector4D:to2d()
Parse instance to Vector2D

###Vector4D:to3d()
Parse instance to Vector3D

####only
if module "type" is loaded:

###Spindle.type.isvector2d(mixed object)
Returns is x is a vector2d type

###Spindle.type.isvector3d(mixed object)
Returns is x is a vector3d type

###Spindle.type.isvector4d(mixed object)
Returns is x is a vector4d type
