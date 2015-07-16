Spindle.FFI
-----------
FFI module for C-Library-Calls

* Shortname: FFI
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Config](../modules/config.md), [Cache](../modules/cache.md)

> This Module provides the FFI library and some short cuts. Also it provides the Advapi32.dll and libpng.dll

###Spindle.ffi.user_init
Optional Callback for initialization extension
```lua
Spindle.ffi.user_init = function() Spindle.debug("FFI initialized") end
```

###Spindle.ffi.no_windows_callback
Optional Callback for non windows initialization
```lua
Spindle.ffi.no_windows_callback = function() Spindle.debug("Add Unix initialization here") end
```

###Spindle.ffi.initialize()
FFI initialization function

###Spindle.ffi.load(...)
Wrapper for Spindle.ffi.ffi().load(...)
```lua
local advapi = Spindle.ffi.ffi().load("Advapi32")
```

###Spindle.ffi.cdef(...)
Wrapper for Spindle.ffi.ffi().cdef(...)
```lua
Spindle.ffi.cdef(Spindle.ffi.defines.misc.libpng)
```

###Spindle.ffi.ffi()
Wrapper for Spindle.cache.get("ffi")
```lua
local advapi = Spindle.ffi.ffi().load("Advapi32")
```

###Spindle.ffi.advapi()
Wrapper for Spindle.cache.get("advapi")
```lua
local advapi = Spindle.ffi.advapi() -- Advapi32 must be loaded before
```

###Spindle.ffi.libpng()
Wrapper for Spindle.cache.get("libpng")
```lua
local libpng = Spindle.ffi.libpng() -- libpng must be loaded before
```

###Spindle.ffi.defines
Table with CDEF definitions
