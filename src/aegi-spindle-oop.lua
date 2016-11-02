--[[
name:OOP
fullname:Spindle.OOP
description:Module for pseudo OOP support
fulldescription:This module provides pseudo class generation for OOP style code.
extends:
depends:Table
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/oop.md
docInternal:
	Spindle.oop.generateClass(string name, table properties, table functions, table constructor, ...) Generate a class construct named by name, with given properties and functions. constructor contains name - type relation for constructor parameters, tupel parameter the order of constructor variables
	Spindle.oop.addMetaFunctions(table meta, table order) Add meta functions to meta table
	Spindle.oop.addType(table meta, string name) Add type function to meta table
	Spindle.oop.addExtendMethod(table meta) Add extendPropertyMethod to meta table
	Spindle.oop.addProperties(table meta, table properties) Add properties to meta table
	Spindle.oop.addFunctions(table meta, table functions) Add functions to meta table
	Spindle.oop.createConstructor(table meta, table constructor, table properties, table order) Add constructor function to meta table
	rawtype(mixed object) type() function
	type(midex object) type() function extended by meta table type getter
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local type, error, pairs, ipairs, unpack, setmetatable = _G.type, _G.error, _G.pairs, _G.ipairs, _G.unpack, _G.setmetatable

Spindle.modules.require("table")

Spindle.oop = {
	generateClass = function(name, properties, functions, constructor, ...)
		Spindle.assert({"string", "table", "table", "table"}, {name, properties, functions, constructor})
		local meta = {}
		order = {...}
		Spindle.oop.addMetaFunctions(meta, order)
		Spindle.oop.addType(meta, name)
		Spindle.oop.addExtendMethod(meta)
		Spindle.oop.addProperties(meta, constructor)
		Spindle.oop.addProperties(meta, properties)
		Spindle.oop.addFunctions(meta, functions)
		Spindle.oop.createConstructor(meta, constructor, properties, order)
		_G[name] = meta
	end,
	addMetaFunctions = function(meta, order)
		meta.__index = meta
		meta.__newindex = function(object, key, value)
			if type(object[key]) == "function" and object["_" .. key] then
				object[key](object, value)
			else
				error("Not allowed to set or overwrite property definitions!", 2)
			end
		end
		meta.__metatable = function() error("Get Metatable is not allowed!", 2) end
		meta.__tostring = function(self)
			return Spindle.table.tostring(self:totable())
		end
		function meta:totable()
			local result = {}
			for _k, _v in pairs(self) do
				result[_k:sub(2)] = _v
			end
			return result
		end
		function meta.fromtable(_t)
			local args = {}
			for _i, _n in ipairs(order) do
				args[_i] = _t[_n]
			end
			return meta.new(unpack(args))
		end
	end,
	addType = function(meta, name)
		function meta:type()
			return name:lower()
		end
	end,
	addExtendMethod = function(meta)
		meta.extendProperty = function(name, _type)
			local key = "_" .. name
			_type = (type(_type) == "table" and _type.type) and (type(_type.type) == "function" and _type.type() or _type.type) or type(_type)
			meta[name] = function(self, value)
				if value ~= nil then
					Spindle.assert({_type}, {value})
					self[key] = value
				end
				return self[key]
			end
		end
	end,
	addProperties = function(meta, properties)
		for name, _type in pairs(properties) do
			meta.extendProperty(name, _type)
		end
	end,
	addFunctions = function(meta, functions)
		for name, func in pairs(functions) do
			meta[name] = func
		end
	end,
	createConstructor = function(meta, constructor, properties, order)
		meta.propDefaults = properties
		meta.new = function(...)
			local assertArray, inp, cons = {}, {...}, {}
			for _, key in ipairs(order) do
				assertArray[#assertArray+1] = constructor[key]
				cons["_" .. key] = inp[#assertArray]
			end
			for key, value in pairs(properties) do
				if (type(value) == "table" and value.type) then
					if type(value.type) == "function" then
						cons["_" .. key] = value
					else
						cons["_" .. key] = value.default and value.default or value.type
					end
				else
					cons["_" .. key] = value
				end
			end
			Spindle.assert(assertArray, inp)
			return setmetatable(cons, meta)
		end
	end,
	getPropertyTypeRelations = function(properties)
		rel = {}
		for name, value in pairs(properties) do
			rel[name] = type(value)
		end
		return rel
	end,
}

_G.rawtype = type
_G.type = function(obj)
	return obj and rawtype(obj) == "table" and obj.type and rawtype(obj.type) == "function" and obj:type() or rawtype(obj)
 end