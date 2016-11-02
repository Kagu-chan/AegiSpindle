Spindle.Fileutils
-----------------
Fileutils module

* Shortname: Fileutils
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Spindle.FFI](../modules/ffi.md), [Spindle.UTF8.FFI](../modules/utf8-ffi.md)
* Source: [aegi-spindle-fileutils.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-fileutils.lua)

> Fileutils providing directory search and similar functions

###Spindle.fileutils.readdir(string dir_name)
Returns a table with directories files and sub directories
```lua
local files = Spindle.fileutils.readdir("C:\\Users")
```
