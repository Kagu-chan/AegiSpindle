Spindle.Config
--------------
Config cache for AegiSpindle

* Shortname: Config
* Version: 1.0
* Author: Kagu-chan

###Spindle.config.keyValues
Table with cached config values (config collection)

###Spindle.config.set(string key, mixed value)
Cache the given value with given key

###Spindle.config.setIfEmpty(string key, mixed value)
Sets a config value if not setted

###Spindle.config.get(string key)
Returns saved value key or false is not set

###Spindle.config.getOrDefault(string key, mixed default)
Returns saved value key or default is not set

###Spindle.config.unset(string key)
Remove a given key from config collection

###Spindle.config.buildWrapper()
Wrapper function for core application
