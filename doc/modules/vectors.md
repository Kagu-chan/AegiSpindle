Spindle.Vectors
---------------
Vector Classes Module

* Shortname: Vectors
* Version: 1.0
* Author: Kagu-chan
* Depends on: [OOP](../modules/oop.md)
* Source: [aegi-spindle-vectors.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-vectors.lua)

> This module will generate the Vector classes for working with shapes and similar tasks.

###Vector2D
Vector2D Object

###Vector2D.new(int x, int y)
Creates a new Instance of Vector2D
```lua
local vector = Vector2D.new(2, 3)
```

###Vector2D.fromtable(table t)
Creates instance from given table
```lua
local vector = Vector2D.fromtable({x=1, y=2})
```

###Vector2D:x([int x])
Sets or gets x value of instance
```lua
local vector = Vector2D.new(2, 3)
vector:x(5)
vector:x() -- 5
```

###Vector2D:y([int y])
Sets or gets y value of instance
```lua
local vector = Vector2D.new(2, 3)
vector:y(5)
vector:y() -- 5
```

###Vector2D:totable()
Returns table representation of instance
```lua
local vector = Vector2D.new(2, 3)
vector:totable() -- {x = 2, y = 3}
```

###Vector2D:distance()
Returns distance length of instance
```lua
local vector = Vector2D.new(2, 3)
vector:distance() -- 3.60555
```

###Vector2D:to3d()
Parse instance to Vector3D
```lua
local vector = Vector2D.new(2, 3)
vector:to3d() -- {x = 2, y = 3, z = 0}
```

###Vector2D:to4d()
Parse instance to Vector4D
```lua
local vector = Vector2D.new(2, 3)
vector:to4d() -- {x = 2, y = 3, z = 0, w = 1}
```

###Vector3D
Vector3D Object

###Vector3D.new(int x, int y, int z)
Creates a new Instance of Vector3D
```lua
local vector = Vector3D.new(2, 3, 4)
```

###Vector3D.fromtable(table t)
Creates instance from given table
```lua
local vector = Vector3D.fromtable({x=1, y=2, z=3})
```

###Vector3D:x([int x])
Sets or gets x value of instance
```lua
local vector = Vector3D.new(2, 3, 4)
vector:x(5)
vector:x() -- 5
```

###Vector3D:y([int y])
Sets or gets y value of instance
```lua
local vector = Vector3D.new(2, 3, 4)
vector:y(5)
vector:y() -- 5
```

###Vector3D:z([int z])
Sets or gets z value of instance
```lua
local vector = Vector3D.new(2, 3, 4)
vector:z(5)
vector:z() -- 5
```

###Vector3D:totable()
Returns table representation of instance
```lua
local vector = Vector3D.new(2, 3, 4)
vector:totable() -- {x = 2, y = 3, z = 4}
```

###Vector3D:distance()
Returns distance length of instance
```lua
local vector = Vector3D.new(2, 3, 4)
vector:distance() -- 5.385
```

###Vector3D:to2d()
Parse instance to Vector2D
```lua
local vector = Vector3D.new(2, 3, 4)
vector:to2d() -- {x = 2, y = 3}
```

###Vector3D:to4d()
Parse instance to Vector4D
```lua
vector:to4d() -- {x = 2, y = 3, z = 4, w = 1}
local vector = Vector3D.new(2, 3, 4)
```

###Vector4D
Vector4D Object

###Vector4D.new(int x, int y, int z, int w)
Creates a new Instance of Vector4D
```lua
local vector = Vector4D.new(2, 3, 4, 5)
```

###Vector4D.fromtable(table t)
Creates instance from given table
```lua
local vector = Vector4D.fromtable({x=1, y=2, z=3, w=4})
```

###Vector4D:x([int x])
Sets or gets x value of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:x(5)
vector:x() -- 5
```

###Vector4D:y([int y])
Sets or gets y value of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:y(5)
vector:y() -- 5
```

###Vector4D:z([int z])
Sets or gets z value of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:z(5)
vector:z() -- 5
```

###Vector4D:w([int w])
Sets or gets w value of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:w(5)
vector:w() -- 5
```

###Vector4D:totable()
Returns table representation of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:totable() -- {x = 2, y = 3, z = 4, w = 5}
```

###Vector4D:distance()
Returns distance length of instance
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:distance() -- 7.348
```

###Vector4D:to2d()
Parse instance to Vector2D
```lua
local vector = Vector4D.new(2, 3, 4, 5)
vector:to2d() => {x = 0.4, y = 0.6}
```

###Vector4D:to3d()
Parse instance to Vector3D
```lua
vector:to3d() => {x = 0.4, y = 0.6, z = 0.8}
local vector = Vector4D.new(2, 3, 4, 5)
```


`only if module "type" is loaded:`

###Spindle.type.isvector2d(mixed object)
Returns is x is a vector2d type
```lua
if Spindle.type.isvector2d(value) then ... end
```

###Spindle.type.isvector3d(mixed object)
Returns is x is a vector3d type
```lua
if Spindle.type.isvector3d(value) then ... end
```

###Spindle.type.isvector4d(mixed object)
Returns is x is a vector4d type
```lua
if Spindle.type.isvector4d(value) then ... end
```
