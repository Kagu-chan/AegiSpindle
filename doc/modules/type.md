Spindle.Type
------------
Type utilities

* Shortname: Type
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-type.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-type.lua)

> This module provides many type check functions and some additional functionality.

###Spindle.type.isnil(mixed x)
Returns is x is a nil type
```lua
if Spindle.type.isnil(value) then ... end
```

###Spindle.type.isbool(mixed x)
Returns is x is a boolean type
```lua
if Spindle.type.isbool(value) then ... end
```

###Spindle.type.isboolean(mixed x)
Returns is x is a boolean type
```lua
if Spindle.type.isboolean(value) then ... end
```

###Spindle.type.isnum(mixed x)
Returns is x is a number type
```lua
if Spindle.type.isnum(value) then ... end
```

###Spindle.type.isnumber(mixed x)
Returns is x is a number type
```lua
if Spindle.type.isnumber(value) then ... end
```

###Spindle.type.isint(mixed x)
Returns is x is a integer type
```lua
if Spindle.type.isint(value) then ... end
```

###Spindle.type.isinteger(mixed x)
Returns is x is a integer type
```lua
if Spindle.type.isinteger(value) then ... end
```

###Spindle.type.isstring(mixed x)
Returns is x is a string type
```lua
if Spindle.type.isstring(value) then ... end
```

###Spindle.type.istext(mixed x)
Returns is x is a string type
```lua
if Spindle.type.istext(value) then ... end
```

###Spindle.type.istable(mixed x)
Returns is x is a table type
```lua
if Spindle.type.istable(value) then ... end
```

###Spindle.type.isfunc(mixed x)
Returns is x is a function type
```lua
if Spindle.type.isfunc(value) then ... end
```

###Spindle.type.isfunction(mixed x)
Returns is x is a function type
```lua
if Spindle.type.isfunction(value) then ... end
```

###Spindle.type.ispure(mixed x)
Returns is x is a pure function type
```lua
if Spindle.type.ispure(value) then ... end
```

###Spindle.type.isthread(mixed x)
Returns is x is a thread type
```lua
if Spindle.type.isthread(value) then ... end
```

###Spindle.type.isudata(mixed x)
Returns is x is a user data type
```lua
if Spindle.type.isudata(value) then ... end
```

###Spindle.type.isuserdata(mixed x)
Returns is x is a user data type
```lua
if Spindle.type.isuserdata(value) then ... end
```

###Spindle.type.iscdata(mixed x)
Returns is x is a cdata type
```lua
if Spindle.type.iscdata(value) then ... end
```

###Spindle.type.issame(mixed x, mixed y)
Returns is x is same as y
```lua
if Spindle.type.issame("x", "x") then ... end -- TRUE
if Spindle.type.issame("x", "y") then ... end -- FALSE
```

###Spindle.type.default(mixed x, mixed default)
Returns default is x is a nil type
```lua
local text = Spindle.type.default(loaded_text, "No text loaded before")
```

###Spindle.type.isarray(mixed x)
Returns is x is a array type with only integer keys greater then zero
```lua
if Spindle.type.isarray(value) then ... end
```

###Spindle.type.buildWrapper()
Wrapper function for core application
