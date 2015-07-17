--[[
name:Modules
fullname:Spindle.Modules
description:Module support module.
fulldescription:This Core Module will load the core application and load or merge all other modules.
extends:
depends:
author:Kagu-chan
version:1.0
type:loader
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/core/modules.md
docInternal:
	Spindle.modules.autoLoadRequires Indicates is this module autoload required modules or raise an exception is not loaded
	Spindle.modules.trace Indicates the trace level. TRUE will print all module actions, FALSE only critical messages
	Spindle.modules.modules Table with loaded module names
	Spindle.modules.modules.add(string name) Mark a module as loaded
	Spindle.modules.loaded(string name) Returns if a module is loaded or not
	Spindle.modules.load(string name) Load a module
	Spindle.modules.require(string name) Check is the given module is loaded or not. If Spindle.modules.autoLoadRequires is true, it will load in case the module is not loaded. Otherwise it will reaise an exception.
	Spindle.modules.requireAegisub() Check is aegisub environment is given. If not, then it will raise an exception.
	Spindle.modules.import(table | string target, table | string source) Imports source module into target module. buildWrapper functions of booth modules will be merged
	Spindle.modules.printLoadedModules() prints a list of loaded modules
]]

require("aegi-spindle-main")

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local pcall, require, select, unpack, debug, error, type, table, pairs = _G.pcall, _G.require, _G.select, _G.unpack, _G.debug, _G.error, _G.type, _G.table, _G.pairs

Spindle.modules = {
	autoLoadRequires = false,
	trace = true,
	modules = {
		n=0,
		add = function(name)
			Spindle.assert({"string"}, {name})
			Spindle.modules.modules.n = Spindle.modules.modules.n + 1
			Spindle.modules.modules[name] = true
		end,
	},
	loaded = function(name)
		Spindle.assert({"string"}, {name})
		return Spindle.modules.modules[name]
	end,
	load = function(name)
		Spindle.assert({"string"}, {name})
		if name == "add" or name == "n" or name == "main" then
			Spindle.debug(string.format("Warning: [%q] is a reserved module name and can't be loaded!", name))
			return false
		end
		if not Spindle.modules.loaded(name) then
			local fName = ("aegi-spindle-%s"):format(name)
			local result = {pcall(function() return require(fName) end)}
			if not result[1] then
				Spindle.debug(("Failed load module [%q]\nFailure Message is\n\t%q"):format(
					name, 
					result[2]:gsub("^.*:.*:%s", "")
				))
				return false
			else
				Spindle.modules.modules.add(name)
				if Spindle.modules.trace then
					Spindle.debug(("Loaded module [%q] - %d modules loaded"):format(
						name,
						Spindle.modules.modules.n
					))
				end
				return select(2, unpack(result))
			end
		else
			Spindle.debug(("Warning: [%q] can't loaded since it's alredy loaded!"):format(name))
		end
	end,
	require = function(name)
		Spindle.assert({"string"}, {name})
		if Spindle.modules.autoLoadRequires and not Spindle.modules.loaded(name) then
			Spindle.modules.load(name)
		end
		if not Spindle.modules.loaded(name) then
			local info = debug.getinfo(2)
			message = ("\n\nError: Module [%q] required! See [%s:line(%d):func(%s)]\n"):format(
				name,
				info.source,
				info.linedefined,
				info.name
			)
			error(message, 3)
		end
	end,
	requireAegisub = function()
		if not aegisub or aegisub and not aegisub.gettext then
			error("\n\nError: Aegisub is required for some functions!\n")
		end
	end,
	import = function(target, source)
		Spindle.assert({{"table", "string"}, {"table", "string"}}, {target, source})
		target = type(target) == "string" and Spindle[target] or target
		source = type(source) == "string" and Spindle[source] or source
		local targetWrapper = type(target.buildWrapper) == "function" and target.buildWrapper or nil
		local sourceWrapper = type(source.buildWrapper) == "function" and source.buildWrapper or nil
		source.buildWrapper = nil
		for _n, _e in pairs(source) do
			target[_n] = _e
		end
		if targetWrapper or sourceWrapper then
			target.buildWrapper = function()
				if targetWrapper then targetWrapper() end
				if sourceWrapper then sourceWrapper() end
			end
		end
	end,
	printLoadedModules = function()
		local c, modules = 1, Spindle.modules.modules
		local t = {("Loaded Modules (%s):"):format(modules.n)}
		
		for key, val in pairs(modules) do
			if not (key == "add" or key == "n") then
				c = c + 1
				t[c] = "\t" .. key
			end
		end
		Spindle.debug(table.concat(t, "\n"))
	end,
}