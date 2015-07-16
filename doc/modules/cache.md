Spindle.Cache
-------------
Value cache for AegiSpindle

* Shortname: Cache
* Version: 1.0
* Author: Kagu-chan

> This module provides various caching functions to store variables in global context without using the global context itself.

###Spindle.cache.keyValues
Table with cached variables (cache collection)

###Spindle.cache.set(string key, mixed value)
Cache the given value with given key

###Spindle.cache.getOrDefault(string key, mixed default)
Returns saved value key or default is not set

###Spindle.cache.get(string key)
Returns saved value key or false is not set

###Spindle.cache.unset(string key)
Remove a given key from cache collection
