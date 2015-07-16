Spindle.Modules
---------------
Module support module.

* Shortname: Modules
* Version: 1.0
* Author: Kagu-chan

> This Core Module will load the core application and load or merge all other modules.

###Spindle.modules.autoLoadRequires
Indicates is this module autoload required modules or raise an exception is not loaded

###Spindle.modules.trace
Indicates the trace level. TRUE will print all module actions, FALSE only critical messages

###Spindle.modules.modules
Table with loaded module names

###Spindle.modules.modules.add(string name)
Mark a module as loaded

###Spindle.modules.loaded(string name)
Returns if a module is loaded or not

###Spindle.modules.load(string name)
Load a module

###Spindle.modules.require(string name)
Check is the given module is loaded or not. If Spindle.modules.autoLoadRequires is true, it will load in case the module is not loaded. Otherwise it will reaise an exception.

###Spindle.modules.requireAegisub()
Check is aegisub environment is given. If not, then it will raise an exception.

###Spindle.modules.import(table | string target, table | string source)
Imports source module into target module. buildWrapper functions of booth modules will be merged

###Spindle.modules.printLoadedModules()
prints a list of loaded modules
