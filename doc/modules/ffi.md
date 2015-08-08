Spindle.FFI
-----------
FFI module for C-Library-Calls

* Shortname: FFI
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Cache](../modules/cache.md), [OOP](../modules/oop.md), [Table](../modules/table.md)
* Source: [aegi-spindle-ffi.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-ffi.lua)
> This Module provides the FFI library and some short cuts.

###FFIObject
FFIObject Object

###FFIObject.new(string name, string cdef, function init_callback, table functions, string load_library)
Creates a new Instance of FFIObject
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
```

###FFIObject.fromtable(table t)
Creates instance from given table
```lua
local t = {name = "example", cdef = [[typedef unsigned int UINT;]], init_callback = function() end, functions = {}, load_library = ""}
local ffi_object = FFIObject.fromtable(t)
```

###FFIObject:name([string name])
Sets or gets name value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:name("test")
ffi_object:name() -- "test"
```

###FFIObject:cdef([string cdef])
Sets or gets cdef value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:cdef([[typedef int INT;]])
ffi_object:cdef() -- [[typedef int INT;]]
```

###FFIObject:init_callback([function init_callback])
Sets or gets init_callback value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:init_callback(function() print(self:name()) end)
ffi_object:init_callback() -- func
```

###FFIObject:functions([table functions])
Sets or gets functions value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:functions({test = function() return 0 end})
ffi_object:functions() -- {test = func}
```

###FFIObject:load_library([string load_library])
Sets or gets load_library value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:load_library("advapi")
ffi_object:load_library() -- "advapi"
```

###FFIObject:lib([cdata lib])
Sets or gets lib value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:lib(Spindle.ffi.load("advapi"))
ffi_object:lib() -- cdata object
```

###FFIObject:initialized([boolean initialized])
Sets or gets initialized value of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
ffi_object:initialized(true)
ffi_object:initialized() -- true
```

###FFIObject:totable()
Returns table representation of instance
```lua
local ffi_object = FFIObject.new("example", [[typedef unsigned int UINT;]], function() end, {}, "")
local t = ffi_object:totable() -- {name = "example", cdef = [[typedef unsigned int UINT;]], init_callback = function() end, functions = {}, load_library = ""}
```

###Spindle.ffi.new(string name, string cdef, function init_callback, table functions[, string load_library])
Add new library with CDEF to ffi module
```lua
Spindle.ffi.new(
	"example",
	[[
typedef unsigned int UINT;
	]],
	function() end,
	{
		func = function(v)
			return v
		end,
	}
)
```

###Spindle.ffi.send(string ffi_name, string function_name[, ...])
Sends a method to libraries function table and ensure initialization of library. Tupel represents the parameters for this function-
```lua
local utf16_string = Spindle.ffi.send("utf8_ffi", "utf8_to_utf16", "Hello World")
-- Otherwhise (Example from FFI.UTF8_FFI Module):
Spindle.ffi.initialize() -- send method ensure initialization of all library definitions. Here you have to do it manually!
local utf16_string = Spindle.cache.get("ffi_cache").utf8_ffi:functions()["utf8_to_utf16"]("Hello World")
```

###Spindle.ffi.initialize()
FFI initialization function
```lua
Spindle.ffi.initialize()
```

###Spindle.ffi.ffi()
Wrapper for 'require("ffi")`
```lua
local cp_utf = Spindle.ffi.ffi().C.CP_UTF8 -- Normally 65001 for utf8 functions - Must be defined via CDEF before
```

###Spindle.ffi.load(...)
Wrapper for 'Spindle.ffi.ffi().load(...)`
```lua
local advapi = Spindle.ffi.ffi().load("Advapi32")
```

###Spindle.ffi.cdef(...)
Wrapper for 'Spindle.ffi.ffi().cdef(...)`
```lua
Spindle.ffi.cdef([[
enum{CP_UTF8 = 65001};
]])
```

###Spindle.ffi.cache([table cache])
Sets or gets ffi_cache table in Spindle.cache
```lua
local ffi_cache = Spindle.ffi.cache() -- Getter
Spindle.ffi.cache(ffi_cache) -- Setter
```
