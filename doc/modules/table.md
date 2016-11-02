Spindle.Table
-------------
Module for table functions

* Shortname: Table
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-table.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-table.lua)

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

###Spindle.table.count(table t)
Counts elements in a table
```lua
local t = {a = 1, 3 = 2, c = "Element"}
Spindle.table.count(t) -- 3
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

###Spindle.table.select(table table, function callback[, int max_items])
Returns a table only containing elements where callback returns true for. If optional parameter max_items is given, then the resulting table contains at maximum the given amount of elements.
```lua
local new_table = Spindle.table.select(t, function(e, i) return type(e) == "number" end)
local new_table = Spindle.table.select(t, function(e, i) return type(e) == "number" end, 3)
```

###Spindle.table.select_first(table table, function callback)
Returns first table value matching callback function. Returns empty table otherwise.
```lua
local new_table = Spindle.table.select_first(t, function(e, i) return type(e) == "number" end)
```

###Spindle.table.map(table table, function callback)
Applies the callback for each element in table
```lua
Spindle.table.map(t, function(e) return tostring(e) end)
```

###Spindle.table.reset_indexes(table table)
Reset all indexes and recount from 1 in a table
```lua
local t = {3 = "a", x = "b"}
Spindle.table.reset_indexes(t) -- => {1 = "a", 2 = "b"}
```

###Spindle.table.minmax(table table)
Returns the lowest and highest value from given table
```lua
local t = {-3, 2, 4, 9, 1}
Spindle.table.minmax(t) -- -3, 9
```

###Spindle.table.min(table table)
Returns the lowest value from given table
```lua
local t = {-3, 2, 4, 9, 1}
Spindle.table.min(t) -- -3
```

###Spindle.table.max(table table)
Returns the highest value from given table
```lua
local t = {-3, 2, 4, 9, 1}
Spindle.table.max(t) -- 9
```

###Spindle.table.buildWrapper()
Wrapper function for core application

