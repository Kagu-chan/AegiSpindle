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

###Spindle.ffi.no_windows_callback
Optional Callback for non windows initialization

###Spindle.ffi.initialize()
FFI initialization function

###Spindle.ffi.load(...)
Wrapper for Spindle.ffi.ffi().load(...)

###Spindle.ffi.cdef(...)
Wrapper for Spindle.ffi.ffi().cdef(...)

###Spindle.ffi.ffi()
Wrapper for Spindle.cache.get("ffi")

###Spindle.ffi.advapi()
Wrapper for Spindle.cache.get("advapi")

###Spindle.ffi.libpng()
Wrapper for Spindle.cache.get("libpng")

###Spindle.ffi.defines
Table with CDEF definitions
