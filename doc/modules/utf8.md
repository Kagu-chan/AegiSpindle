Spindle.UTF8
------------
UTF8 Text Module

* Shortname: UTF8
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-utf8.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-utf8.lua)
> This module provides some functions for working with binary data or characters.

###Spindle.utf8.charrange(string s, int i)
Returns bytes charrange
```lua
local charrange = Spindle.utf8.charrange("$")
```

###Spindle.utf8.chars(string s)
Iterator function through texts characters
```lua
for c in Spindle.utf8.chars("Hello") do
	Spindle.debug(c)
end
```

###Spindle.utf8.chartable(string s)
Returns a table of texts characters
```lua
local char_table = Spindle.utf8.chartable("Hello")
```

###Spindle.utf8.len(string s)
Returns strings lentgh
```lua
local len = Spindle.utf8.len("Hello")
```

###Spindle.utf8.bton(string s)
return texts bytes as binary unsignet integer representation
```lua
local n = Spindle.utf8.bton(_binary_data_string_)
```

###Spindle.utf8.buildWrapper()
Wrapper function for core application
