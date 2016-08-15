Spindle.UTF8.FFI
----------------
UTFS8 ffi extension module

* Shortname: UTF8-FFI
* Version: 1.0
* Author: Kagu-chan
* Extends: [Spindle.UTF8](../modules/utf8.md)
* Depends on: [Spindle.UTF8](../modules/utf8.md), [Spindle.FFI](../modules/ffi.md)
* Source: [aegi-spindle-utf8_ffi.lua](https://github.com/Kagurame/AegiSpindle/tree/beta/src/aegi-spindle-utf8_ffi.lua)

> This module extends the Spindle.UTF8 module by C-Functions.

###Spindle.utf8.utf8_to_utf16(string s)
Returns utf16 representation of utf8 string
```lua
local dir_handle = Spindle.ffi.ffi().gc(Spindle.ffi.ffi().C.FindFirstFileW(Spindle.utf8.utf8_to_utf16(dir_name.."\\*"), find_data), Spindle.ffi.ffi().C.FindClose) -- This example is taken from the old create_dokumentation-script and catch a directory handle (which is internally utf16 in windows)
```

###Spindle.utf8.utf16_to_utf8(string s)
Returns utf8 representation of utf16 string
```lua
local name = Spindle.utf8.utf16_to_utf8(find_data[0].cFileName) -- This example is taken from the old create_dokumentation-script and catch the file name from a directory handle object which is internally utf16 in windows
```

###Spindle.utf8.buildWrapper()
Wrapper function for core application

