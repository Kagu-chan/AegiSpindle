Spindle.OOP
-----------
Module for pseudo OOP support

* Shortname: OOP
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Table](../modules/table.md)
* Source: [aegi-spindle-oop.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-oop.lua)

> This module provides pseudo class generation for OOP style code.

###Spindle.oop.generateClass(string name, table properties, table functions, table constructor, ...)
Generate a class construct named by name, with given properties and functions. constructor contains name - type relation for constructor parameters, tupel parameter the order of constructor variables
```lua
Spindle.oop.generateClass("Vector4D", {}, {}, {x = "number", y = "number", z = "number", w = "number"}, "x", "y", "z", "w")
Spindle.oop.generateClass("FFIObject", {
	initialized = false, -- Default value for initialized is false and boolean type
	lib = {type = "ctype"}, -- Default value for lib is false (No default) and ctype type
}, {}, {
	name = "string",
	cdef = "string",
	init_callback = "function",
	functions = "table",
	load_library = "string"
}, "name", "cdef", "init_callback", "functions", "load_library")
```

###Spindle.oop.addMetaFunctions(table meta, table order)
Add meta functions to meta table

###Spindle.oop.addType(table meta, string name)
Add type function to meta table

###Spindle.oop.addProperties(table meta, table properties)
Add properties to meta table

###Spindle.oop.addFunctions(table meta, table functions)
Add functions to meta table

###Spindle.oop.createConstructor(table meta, table constructor, table properties, table order)
Add constructor function to meta table

###rawtype(mixed object)
type() function
```lua
local t = rawtype(Vector2D.new(2, 2)) -- Will result "table"
```

###type(midex object)
type() function extended by meta table type getter
```lua
local t = type(Vector2D.new(2, 2)) -- Will result "vector2d", but only if OOP module is loaded!
```
