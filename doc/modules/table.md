Spindle.Table
-------------
Module for table functions

* Shortname: Table
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-table.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-table.lua)
> This module provides some functions for working with tables.

###Spindle.table.tostring(table t)
Returns tables string representation
```lua
Spindle.debug(Spindle.table.tostring({a=1, b=2})) -- Good for debugging (:
```

###Spindle.table.removekey(table table, string key)
Remove a key from a table
```lua
local t = {a = 1, b = 2}
Spindle.table.removekey(t, "a") -- t.a is nil now
```

###Spindle.table.copy(table table[, number depth])
Returns a copy of a table. Full copy if depth is not given
```lua
local t = {
	a = 1,
	b = 2,
	c = {
		x = 5,
		y = 6
	}
}
local ct = Spindle.table.copy(t) -- An exact copy will be returned
local ct = Spindle.table.copy(t, 1) -- The table will be copied, but no subtables, since there depth = 2 or higher
```

###Spindle.table.select(table table, function callback)
Returns a table only containing elements where callback returns true for
```lua
local new_table = Spindle.table.select(t, function(e, i) return type(e) == "number" end)
```

###Spindle.table.map(table table, function callback)
Applies the callback for each element in table
```lua
Spindle.table.map(t, function(e) return tostring(e) end)
```

###Spindle.table.buildWrapper()
Wrapper function for core application
