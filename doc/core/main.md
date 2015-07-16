Spindle.Main
------------
AegiSpindle Core

* Shortname: Main
* Version: 1.0
* Author: Kagu-chan

> Core Module of AegiSpindle. In this Module all sub modules will be stored except pseudo classes.

###Spindle.debug(...)
Debug function (Wrapper for print(...))

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

###Spindle.generateWrapper()
Iterates all registered modules and call buildWrapper if exists in module

###Spindle.initializeAegisub()
Iterates all registered modules and call initAegisub if exists in module

###Spindle.assert(table types, table values[, bool silent_or_nil])
Check function parameters. Refer function comment for more details

###Spindle.assertOverrides(...)
Check function parameters with optional parameter checks. Refer function comment for more details

###Spindle.dev
Development Sub Module

###Spindle.dev.deeperTrace(int i)
Overwrite Spindle.library.devTracebackDefault for next dev call

###Spindle.dev.setDebug(string key, bool state)
Set print flag for given key to given state

###Spindle.dev.disable(...)
Disable print for given keys

###Spindle.dev.enable(...)
Enable print for given keys

###Spindle.dev.from()
Catch traceback function at Spindle.library.devTracebackDefault position for dev message

###Spindle.dev.todo(string message)
Print out a TODO-Message is print enabled

###Spindle.dev.fixme(string message)
Print out a FIXME-Message is print enabled

###Spindle.dev.deprecated(string message)
Print out a DEPRECATED-Message is print enabled
