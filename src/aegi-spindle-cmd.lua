--[[
name:CMD
fullname:Spindle.CMD
description:Spindle command line integration
fulldescription:This module provides various functions to integrate command line interactions between LUA scripts and the whole system
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/cmd.md
docInternal:
	Spindle.cmd.getArgumentsTable(...) Map given arguments to a table with named keys
	Spindle.cmd.execute(string command) Executes given string command on command line and returns stdout
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

Spindle.cmd = {
	getArgumentsTable = function(...)
		local arguments, result = {...}, {}
		for i, e in ipairs(arguments) do
			result[e] = arg[i]
		end
		return result
	end,
	execute = function(command)
		local handle = io.popen(command)
		local result = handle:read("*a")
		handle:close()
		return result
	end,
}