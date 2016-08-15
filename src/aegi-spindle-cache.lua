--[[
name:Cache
fullname:Spindle.Cache
description:Value cache for AegiSpindle
fulldescription:This module provides various caching functions to store variables in global context without using the global context itself.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/cache.md
docInternal:
	Spindle.cache.keyValues Table with cached variables (cache collection)
	Spindle.cache.set(string key, mixed value) Cache the given value with given key
	Spindle.cache.getOrDefault(string key, mixed default) Returns saved value key or default is not set
	Spindle.cache.get(string key) Returns saved value key or false is not set
	Spindle.cache.unset(string key) Remove a given key from cache collection
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

Spindle.cache = {
	keyValues = {},
	set = function(key, value)
		Spindle.assert({"string", true}, {key, value})
		Spindle.cache.keyValues[key] = value
	end,
	getOrDefault = function(key, default)
		Spindle.assert({"string", true}, {key, default})
		return Spindle.cache.keyValues[key] or default
	end,
	get = function(key)
		Spindle.assert({"string"}, {key})
		return Spindle.cache.getOrDefault(key, false)
	end,
	unset = function(key)
		Spindle.assert({"string"}, {key})
		Spindle.cache.keyValues[key] = nil
	end,
}