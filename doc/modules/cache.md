Spindle.Cache
-------------
Value cache for AegiSpindle

* Shortname: Cache
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-cache.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-cache.lua)
> This module provides various caching functions to store variables in global context without using the global context itself.

###Spindle.cache.keyValues
Table with cached variables (cache collection)

###Spindle.cache.set(string key, mixed value)
Cache the given value with given key
```lua
Spindle.cache.set("ffi", require("ffi"))
```

###Spindle.cache.getOrDefault(string key, mixed default)
Returns saved value key or default is not set
```lua
local ffi = Spindle.cache.getOrDefault("ffi", require("ffi"))
```

###Spindle.cache.get(string key)
Returns saved value key or false is not set
```lua
local ffi = Spindle.cache.get("ffi") -- Will internally call Spindle.cache.getOrDefault("ffi", false)
```

###Spindle.cache.unset(string key)
Remove a given key from cache collection
```lua
Spindle.cache.unset("ffi")
```
