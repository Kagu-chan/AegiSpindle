--[[
name:Type
fullname:Spindle.Type
description:Type utilities
fulldescription:This module provides many type check functions and some additional functionality.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/beta/doc/modules/type.md
docInternal:
	Spindle.type.isnil(mixed x) Returns is x is a nil type
	Spindle.type.isbool(mixed x) Returns is x is a boolean type
	Spindle.type.isboolean(mixed x) Returns is x is a boolean type
	Spindle.type.isnum(mixed x) Returns is x is a number type
	Spindle.type.isnumber(mixed x) Returns is x is a number type
	Spindle.type.isint(mixed x) Returns is x is a integer type
	Spindle.type.isinteger(mixed x) Returns is x is a integer type
	Spindle.type.isstring(mixed x) Returns is x is a string type
	Spindle.type.istext(mixed x) Returns is x is a string type
	Spindle.type.istable(mixed x) Returns is x is a table type
	Spindle.type.isfunc(mixed x) Returns is x is a function type
	Spindle.type.isfunction(mixed x) Returns is x is a function type
	Spindle.type.ispure(mixed x) Returns is x is a pure function type
	Spindle.type.isthread(mixed x) Returns is x is a thread type
	Spindle.type.isudata(mixed x) Returns is x is a user data type
	Spindle.type.isuserdata(mixed x) Returns is x is a user data type
	Spindle.type.iscdata(mixed x) Returns is x is a cdata type
	Spindle.type.issame(mixed x, mixed y) Returns is x is same as y
	Spindle.type.default(mixed x, mixed default) Returns default is x is a nil type
	Spindle.type.isarray(mixed x) Returns is x is a array type with only integer keys greater then zero
	Spindle.type.buildWrapper() Wrapper function for core application
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local type, pairs, math = _G.type, _G.pairs, _G.math

Spindle.type = {
	isnil = function(x) return x == nil end,
	isbool = function(x) return type(x) == "boolean" end,
	isboolean = function(x) return type(x) == "boolean" end,
	isnum = function(x) return type(x) == "number" end,
	isnumber = function(x) return type(x) == "number" end,
	isint = function(x) return Spindle.type.isnumber(x) and math.floor(x) == x end,
	isinteger = function(x) return Spindle.type.isnumber(x) and math.floor(x) == x end,
	isstring = function(x) return type(x) == "string" end,
	istext = function(x) return Spindle.type.isstring(x) and Spindle.type.isnil(x:find("[%z\1-\6\14-\31]")) end,
	istable = function(x) return type(x) == "table" end,
	isfunc = function(x) return type(x) == "function" end,
	isfunction = function(x) return type(x) == "function" end,
	ispure = function(x) return Spindle.type.isfunction(x) and Spindle.type.isnil(debug.getupvalue(x, 1)) end,
	isthread = function(x) return type(x) == "thread" end,
	isudata = function(x) return type(x) == "userdata" end,
	isuserdata = function(x) return type(x) == "userdata" end,
	iscdata = function(x) return type(x) == "cdata" end,
	issame = function(x, y) return type(a) == type(b) end,
	default = function(x, default) return Spindle.type.isnil(x) and default or x end,
	isarray = function(x)
		if not Spindle.type.istable(x) then return false end
		for key in pairs(x) do
			if not Spindle.type.isint(key) or key < 1 then return false end
		end
		return true
	end,
	buildWrapper = function()
		local _t = Spindle.type
		for _n, _v in pairs(_t) do
			if _n:find("is") == 1 or _n == "default" then
				_G[_n] = _v
			end
		end
	end,
}