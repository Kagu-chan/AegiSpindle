--[[
name:FFI
fullname:Spindle.FFI
description:FFI module for C-Library-Calls
fulldescription:This Module provides the FFI library and some short cuts.
extends:
depends:Cache,OOP,Table
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/ffi.md
docInternal:
	FFIObject FFIObject Object
	FFIObject.new(string name, string cdef, function init_callback, table functions, string load_library) Creates a new Instance of FFIObject
	FFIObject.fromtable(table t) Creates instance from given table
	FFIObject:name([string name]) Sets or gets name value of instance
	FFIObject:cdef([string cdef]) Sets or gets cdef value of instance
	FFIObject:init_callback([function init_callback]) Sets or gets init_callback value of instance
	FFIObject:functions([table functions]) Sets or gets functions value of instance
	FFIObject:load_library([string load_library]) Sets or gets load_library value of instance
	FFIObject:lib([cdata lib]) Sets or gets lib value of instance
	FFIObject:initialized([boolean initialized]) Sets or gets initialized value of instance
	FFIObject:totable() Returns table representation of instance
	Spindle.ffi.new(string name, string cdef, function init_callback, table functions[, string load_library]) Add new library with CDEF to ffi module
	Spindle.ffi.send(string ffi_name, string function_name[, ...]) Sends a method to libraries function table and ensure initialization of library. Tupel represents the parameters for this function-
	Spindle.ffi.initialize() FFI initialization function
	Spindle.ffi.ffi() Wrapper for 'require("ffi")`
	Spindle.ffi.load(...) Wrapper for 'Spindle.ffi.ffi().load(...)`
	Spindle.ffi.cdef(...) Wrapper for 'Spindle.ffi.ffi().cdef(...)`
	Spindle.ffi.cache([table cache]) Sets or gets ffi_cache table in Spindle.cache
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local require, type, pairs, pcall = _G.require, _G.type, _G.pairs, _G.pcall

Spindle.modules.require("cache")
Spindle.modules.require("oop")
Spindle.modules.require("table")

Spindle.oop.generateClass("FFIObject", {
	initialized = false,
	lib = {type = "cdata"},
}, {}, {
	name = "string",
	cdef = "string",
	init_callback = "function",
	functions = "table",
	load_library = "string"
}, "name", "cdef", "init_callback", "functions", "load_library")

Spindle.ffi = {
	new = function(name, cdef, init_callback, functions, load_library)
		Spindle.assertOverrides(
			{"string", "string", "function", "table", "string"},
			{"string", "string", "function", "table"},
			{name, cdef, init_callback, functions, load_library}
		)
		local object = FFIObject.new(name, cdef, init_callback, functions, load_library or "")
		
		object:initialized(false)
		local ffi_cache = Spindle.ffi.cache()
		ffi_cache[name] = object
		Spindle.ffi.cache(ffi_cache)
	end,
	send = function(ffi_name, function_name, ...)
		Spindle.ffi.initialize()
		local object = Spindle.ffi.cache()[ffi_name]
		local functions = object:functions()
		return functions[function_name](...)
	end,
	initialize = function()
		local cache = Spindle.ffi.cache()
		for name, object in pairs(Spindle.table.select(cache, function(e) return not e:initialized() end)) do
			Spindle.ffi.cdef(object:cdef())
			if not object:load_library() == "" then
				pcall(function() Spindle.ffi.load(object:load_library()) end)
			end
			object:init_callback()
			object:initialized(true)
			cache[name] = object
		end
		Spindle.ffi.cache(cache)
	end,
	ffi = function()
		return require("ffi")
	end,
	load = function(...)
		return Spindle.ffi.ffi().load(...)
	end,
	cdef = function(...)
		return Spindle.ffi.ffi().cdef(...)
	end,
	cache = function(cache)
		if cache then
			Spindle.cache.set("ffi_cache", cache)
		else
			return Spindle.cache.getOrDefault("ffi_cache", {})
		end
	end,
}