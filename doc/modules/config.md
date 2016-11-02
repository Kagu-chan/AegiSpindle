Spindle.Config
--------------
Config cache for AegiSpindle

* Shortname: Config
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-config.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-config.lua)

> This Module provides a configurator for the library.

###Spindle.config.keyValues
Table with cached config values (config collection)


###Spindle.config.set(string key, mixed value)
Cache the given value with given key
```lua
Spindle.config.set("floatingpoint_precision", 3)
```

###Spindle.config.setIfEmpty(string key, mixed value)
Sets a config value if not setted
```lua
Spindle.config.setIfEmpty("floatingpoint_precision", 3)
```

###Spindle.config.get(string key)
Returns saved value key or false is not set
```lua
Spindle.math.round(3.14156, Spindle.config.get("floatingpoint_precision"))
```

###Spindle.config.getOrDefault(string key, mixed default)
Returns saved value key or default is not set
```lua
Spindle.math.round(3.14156, Spindle.config.getOrDefault("floatingpoint_precision", 3))
```

###Spindle.config.unset(string key)
Remove a given key from config collection
```lua
Spindle.config.unset("floatingpoint_precision")
```

###Spindle.config.buildWrapper()
Wrapper function for core application

