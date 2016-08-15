--[[
name:Table
fullname:Spindle.Table
description:Module for table functions
fulldescription:This module provides some functions for working with tables.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/beta/doc/modules/table.md
docInternal:
	Spindle.table.tostring(table t) Returns tables string representation
	Spindle.table.removekey(table table, string key) Remove a key from a table
	Spindle.table.count(table t) Counts elements in a table
	Spindle.table.copy(table table[, number depth]) Returns a copy of a table. Full copy if depth is not given
	Spindle.table.select(table table, function callback[, int max_items]) Returns a table only containing elements where callback returns true for. If optional parameter max_items is given, then the resulting table contains at maximum the given amount of elements.
	Spindle.table.select_first(table table, function callback) Returns first table value matching callback function. Returns empty table otherwise.
	Spindle.table.map(table table, function callback) Applies the callback for each element in table
	Spindle.table.buildWrapper() Wrapper function for core application
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local table, pairs, type = _G.table, _G.pairs, _G.type

Spindle.table = {
	tostring = function(t)
		Spindle.assert({"table"}, {t})
		local result, result_n = {}, 0
		local function convert_recursive(t, space)
			for key, value in pairs(t) do
				if type(key) == "string" then key = string.format("%q", key) end
				if type(value) == "string" then value = string.format("%q", value) end
				result_n = result_n + 1
				result[result_n] = string.format("%s[%s] = %s", space, key, tostring(value))
				if type(value) == "table" then
					convert_recursive(value, space .. "\t")
				end
			end
		end
		convert_recursive(t, "")
		return table.concat(result, "\n")
	end,
	removekey = function(t, key)
		Spindle.assert({"table", true}, {t, key})
		if type(t) ~= "table" then return nil end
		if t[key] == nil then return nil end
		local e = t[key]
		t[key] = nil
		return e
	end,
	copy = function(t, depth)
		Spindle.assertOverrides({"table"}, {"table", "number"}, {t, depth})
		depth = depth >= 1 and depth or nil
		local function copy_recursive(old_t)
			local new_t = {}
			for key, value in pairs(old_t) do
				new_t[key] = type(value) == "table" and copy_recursive(value) or value
			end
			return new_t
		end
		local function copy_recursive_n(old_t, depth)
			local new_t = {}
			for key, value in pairs(old_t) do
				new_t[key] = type(value) ~= "table" and value or depth >= 2 and copy_recursive_n(value, depth-1) or nil
			end
			return new_t
		end
		return depth and copy_recursive_n(t, depth) or copy_recursive(t)
	end,
	count = function(t)
		Spindle.assert({"table"}, {t})
		local c = 0
		for k, e in pairs(t) do
			c = c + 1
		end
		return c
	end,
	select = function(t, callback, max_items)
		Spindle.assertOverrides({"table", "function"}, {"table", "function", "number"}, {t, callback, max_items})
		local result, current_items, max_items = {}, 0, max_items or 0
		if max_items < 0 then
			error("max_items must be greater or equals to 0!", 2)
		end
		for i, e in pairs(t) do
			if callback(e, i) then 
				current_items = current_items + 1
				result[i] = e
				if current_items == max_items and max_items > 0 then goto end_for end
			end
		end
		::end_for::
		return result
	end,
	select_first = function(t, callback)
		Spindle.assert({"table", "function"}, {t, callback})
		return Spindle.table.select(t, callback, 1)
	end,
	map = function(t, callback)
		Spindle.assert({"table", "function"}, {t, callback})
		local result = {}
		for i, e in pairs(t) do
			t[i] = callback(e, i)
		end
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper")
	end,
}