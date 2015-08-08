Spindle.Fileutils
-----------------
Fileutils module

* Shortname: Fileutils
* Version: 1.0
* Author: Kagu-chan
* Depends on: [FFI](../modules/ffi.md), [UTF8_FFI](../modules/utf8-ffi.md)
* Source: [aegi-spindle-fileutils.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-fileutils.lua)

> Fileutils providing directory search and similar functions

###Spindle.fileutils.readdir(string dir_name)
Returns a table with directories files and sub directories
```lua
local files = Spindle.fileutils.readdir("C:\\Users")
```
