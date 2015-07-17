--[[
name:Config
fullname:Spindle.Config
description:Config cache for AegiSpindle
fulldescription:This Module provides a configurator for the library.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/config.md
docInternal:
	Spindle.config.keyValues Table with cached config values (config collection)
	Spindle.config.set(string key, mixed value) Cache the given value with given key
	Spindle.config.setIfEmpty(string key, mixed value) Sets a config value if not setted
	Spindle.config.get(string key) Returns saved value key or false is not set
	Spindle.config.getOrDefault(string key, mixed default) Returns saved value key or default is not set
	Spindle.config.unset(string key) Remove a given key from config collection
	Spindle.config.buildWrapper() Wrapper function for core application
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

Spindle.config = {
	keyValues = {},
	set = function(key, value)
		Spindle.assert({"string", true}, {key, value})
		Spindle.config.keyValues[key] = value
		return value
	end,
	setIfEmpty = function(key, value)
		Spindle.assert({"string", true}, {key, value})
		if Spindle.config.getOrDefault(key, false) then
			Spindle.config.set(key, value)
		end
		return value
	end,
	get = function(key)
		Spindle.assert({"string"}, {key})
		return Spindle.config.getOrDefault(key, false)
	end,
	getOrDefault = function(key, default)
		Spindle.assert({"string", true}, {key, default})
		return Spindle.config.keyValues[key] or default
	end,
	unset = function(key)
		Spindle.assert({"string"}, {key})
		local keyValues = Spindle.config.keyValues
		keyValues[key] = nil
		Spindle.config.keyValues = keyValues
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper")
	end,
}