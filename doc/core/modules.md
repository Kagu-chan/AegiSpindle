Spindle.Modules
---------------
Module support module.

* Shortname: Modules
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-modules.lua](https://github.com/Kagurame/AegiSpindle/blob/master/src/aegi-spindle-modules.lua)

> This Core Module will load the core application and load or merge all other modules.

###Spindle.modules.autoLoadRequires
Indicates is this module autoload required modules or raise an exception is not loaded
```lua
Spindle.modules.autoLoadRequires = false -- Will raise an exception is any dependency is not given
Spindle.modules.autoLoadRequires = true -- Will try to autoload module is any dependency is not given
```

###Spindle.modules.trace
Indicates the trace level. TRUE will print all module actions, FALSE only critical messages
```lua
Spindle.module.trace = true -- Will print all module actions (e.g. module load)
Spindle.module.trace = false -- Will print only critical messages from modules module (e.g. module not found)
```

###Spindle.modules.modules
Table with loaded module names

###Spindle.modules.modules.add(string name)
Mark a module as loaded

###Spindle.modules.loaded(string name)
Returns if a module is loaded or not
```lua
if Spindle.modules.loaded("math") then
	Spindle.debug("Module Math is loaded (:")
else
	Spindle.debug("Module Math is not loaded ):")
end
```

###Spindle.modules.load(string name)
Load a module
```lua
Spindle.modules.load("ffi")
```

###Spindle.modules.require(string name)
Check is the given module is loaded or not. If Spindle.modules.autoLoadRequires is true, it will load in case the module is not loaded. Otherwise it will reaise an exception.
```lua
Spindle.modules.require("ffi") -- Will raise an exception is module is not loaded and Spindle.modules.autoLoadRequires is set to false
```

###Spindle.modules.requireAegisub()
Check is aegisub environment is given. If not, then it will raise an exception.
```lua
Spindle.modules.requireAegisub()
```

###Spindle.modules.import(table | string target, table | string source)
Imports source module into target module. buildWrapper functions of booth modules will be merged
```lua
Spindle.modules.import("math", Spindle.math_vectors) -- This function will also merge the buildWrapper() functions is defined in both modules
```

###Spindle.modules.printLoadedModules()
prints a list of loaded modules
```lua
Spindle.modules.printLoadedModules() -- A list of all loaded modules will be printed out
```
