Spindle.Main
------------
AegiSpindle Core

* Shortname: Main
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-main.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-main.lua)

> Core Module of AegiSpindle. In this Module all sub modules will be stored except pseudo classes.

###Spindle.debug(...)
Debug function (Wrapper for print(...))
```lua
Spindle.debug("Hello ", "World")
```

###Spindle.sayHello()
Welcome Message, print out core version and used lua environment version


###Spindle.library
Internal Core Cache Table


###Spindle.library.version
Core Version


###Spindle.library.devTracebackDefault
Default TraceBack steps


###Spindle.library.devPrintTodo
Indicates if AegiSpindle print out TODO-Messages or not


###Spindle.library.devPrintFixme
Indicates if AegiSpindle print out FIXME-Messages or not


###Spindle.library.devPrintDeprecated
Indicates if AegiSpindle print out DEPRECATED-Messages or not


###Spindle.initialize(bool printTodo, bool printFixme, bool printDeprecated)
Initialize Core with given debug flags and generate Wrapper functions
```lua
Spindle.initialize()
Spindle.initialize(true, false, true)
```

###Spindle.generateWrapper()
Iterates all registered modules and call buildWrapper if exists in module
```lua
Spindle.generateWrapper() -- Calls the buildWrapper() function in all modules including this function
```

###Spindle.initializeAegisub()
Iterates all registered modules and call initAegisub if exists in module
```lua
Spindle.initializeAegisub() -- Calls the initAegisub() function in all modules including this function
```

###Spindle.assert(table types, table values[, bool silent_or_nil])
Check function parameters.
```lua
-- Simple assert of types: every parameter has a defined type
-- First parameter has to be a string ("Hello World" in this case)
Spindle.assert({"string"}, {"Hello World"})
-- Complex assert of types: the type definition `true` (not "true") means that the parameter can be any type except nil (like `mixed` or `object` in other programming languages)
-- First parameter has to be a string ("Hello World" in this case), second can be any type except nil
Spindle.assert({"string", true}, {"Hello World", 33})
-- Assert with defined range of allowed types: A table instead of a type name means that any in this table listed type is allowed
-- First parameter has to be a string ("Hello World" in this case), second can be any type except nil, third parameter has to be a table or a string
Spindle.assert({"string", true, {"table, "string"}}, {"Hello World", 33, {a=1, b=2}})
```

###Spindle.assertOverrides(...)
Check function parameters, but with multiple method signatures.
```lua
-- If you use one parameter, it has to be a string.
-- If you use two parameters, first has to be string, second any type except nil (which means that case one will be valid)
-- If you use three parameters, first has to be string, second any type except nil and third has to be a table or string
Spindle.assertOverrides({"string"}, {"string", true}, {"string", true, {"table, "string"}}, {"Hello World", 33, {a=1, b=2}})
```

###Spindle.dev
Development Sub Module


###Spindle.dev.deeperTrace(int i)
Overwrite Spindle.library.devTracebackDefault for next dev call
```lua
Spindle.dev.deeperTrace(4)
```

###Spindle.dev.setDebug(string key, bool state)
Set print flag for given key to given state
```lua
Spindle.dev.setDebug("todo", false)
```

###Spindle.dev.disable(...)
Disable print for given keys
```lua
Spindle.dev.disable("todo", "fixme")
```

###Spindle.dev.enable(...)
Enable print for given keys
```lua
Spindle.dev.enable("todo", "fixme")
```

###Spindle.dev.from()
Catch traceback function at Spindle.library.devTracebackDefault position for dev message


###Spindle.dev.todo(string message)
Print out a TODO-Message is print enabled
```lua
Spindle.dev.todo("My TODO Message")
```

###Spindle.dev.fixme(string message)
Print out a FIXME-Message is print enabled
```lua
Spindle.dev.fixme("Fixme, im coded as bad as possible!")
```

###Spindle.dev.deprecated(string message)
Print out a DEPRECATED-Message is print enabled
```lua
Spindle.dev.deprecated("I'm deprecated since V0.1 and will be removed in V1.0")
```
