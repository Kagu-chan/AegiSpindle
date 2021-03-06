--[[
name:Main
fullname:Spindle.Main
description:AegiSpindle Core
fulldescription:Core Module of AegiSpindle. In this Module all sub modules will be stored except pseudo classes.
extends:
depends:
author:Kagu-chan
version:1.0
type:core
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/core/main.md
docInternal:
	Spindle.debug(...) Debug function (Wrapper for print(...))
	Spindle.sayHello() Welcome Message, print out core version and used lua environment version
	Spindle.library Internal Core Cache Table
	Spindle.library.version Core Version
	Spindle.library.devTracebackDefault Default TraceBack steps
	Spindle.library.devPrintTodo Indicates if AegiSpindle print out TODO-Messages or not
	Spindle.library.devPrintFixme Indicates if AegiSpindle print out FIXME-Messages or not
	Spindle.library.devPrintDeprecated Indicates if AegiSpindle print out DEPRECATED-Messages or not
	Spindle.initialize(bool printTodo, bool printFixme, bool printDeprecated) Initialize Core with given debug flags and generate Wrapper functions
	Spindle.generateWrapper() Iterates all registered modules and call buildWrapper if exists in module
	Spindle.initializeAegisub() Iterates all registered modules and call initAegisub if exists in module
	Spindle.assert(table types, table values[, bool silent_or_nil]) Check function parameters.
	Spindle.assertOverrides(...) Check function parameters, but with multiple method signatures.
	Spindle.dev Development Sub Module
	Spindle.dev.deeperTrace(int i) Overwrite Spindle.library.devTracebackDefault for next dev call
	Spindle.dev.setDebug(string key, bool state) Set print flag for given key to given state
	Spindle.dev.disable(...) Disable print for given keys
	Spindle.dev.enable(...) Enable print for given keys
	Spindle.dev.from() Catch traceback function at Spindle.library.devTracebackDefault position for dev message
	Spindle.dev.todo(string message) Print out a TODO-Message is print enabled
	Spindle.dev.fixme(string message) Print out a FIXME-Message is print enabled
	Spindle.dev.deprecated(string message) Print out a DEPRECATED-Message is print enabled
]]

-- Set global functions and objects to local cache for performance
local Spindle
local print, _VERSION, pairs, ipairs, table, error, string, debug = _G.print, _G._VERSION, _G.pairs, _G.ipairs, _G.table, _G.error, _G.string, _G.debug

Spindle = {
	debug = function(...)
		print(...)
	end,
	sayHello = function()
		Spindle.debug(("Aegi Spindle V %s [LuaJIT (%s)]"):format(Spindle.library.version, _VERSION))
	end,
	library = {
		version = "1.0",
		devTracebackDefault = 3,
		devPrintTodo = true,
		devPrintFixme = true,
		devPrintDeprecated = true,
	},
	initialize = function(printTodo, printFixme, printDeprecated)
		printTodo = (printTodo or printTodo == nil)
		printFixme = (printFixme or printFixme == nil)
		printDeprecated = (printDeprecated or printDeprecated == nil)
		Spindle.assert({"boolean", "boolean", "boolean"}, {printTodo, printFixme, printDeprecated})
		Spindle.dev.setDebug("todo", printTodo)
		Spindle.dev.setDebug("fixme", printFixme)
		Spindle.dev.setDebug("deprecated", printDeprecated)
		Spindle.generateWrapper()
	end,
	generateWrapper = function()
		for _moduleName, _module in pairs(Spindle) do
			if type(_module) == "table" and type(_module.buildWrapper) == "function" then 
				_module.buildWrapper()
			end
		end
	end,
	initializeAegisub = function()
		Spindle.modules.require("auto4-base")
		for _moduleName, _module in pairs(Spindle) do
			if type(_module) == "table" and type(_module.initAegisub) == "function" then 
				_module.initAegisub()
			end
		end
	end,
	assert = function(types, values, silent_or_nil)
		local success, _error, message = true, false, ""
		silent_or_nil = silent_or_nil or false
		local function continue()
			return success and not _error
		end
		local function is(value, _type)
			return type(value) == _type
		end
		local function buildAssertFail()
			local cache = {"Invalid parameter types - expected are:"}
			
			for _i, _t in ipairs(types) do
				if is(_t, "table") then
					_t = ("one of ['%s']"):format(table.concat(_t, "', '"))
				elseif is(_t, "boolean") and _t then
					_t = "any type"
				end
				cache[#cache + 1] = ("\t%s"):format(_t)
			end
			
			success = false
			message = table.concat(cache, "\n")
		end
		if not (is(types, "table") and is(values, "table")) then
			_error = true
			message = "Invalid assertion call! Parameters excepted are table, table, optional boolean!"
		end
		if continue() then
			for i = 1, #types do
				local current_types, current_value = types[i], values[i]
				
				-- Check for missing parameter
				if is(current_value, "nil") then buildAssertFail() end
				-- Check if any type is allowed, if yes, then stop here for this parameter
				if continue() and is(current_types, "boolean") and current_types then goto continue end
				-- Check if multiple Parameter type
				if continue() and is(current_types, "table") then
					for _, t in ipairs(current_types) do
						if is(current_value, t) then goto continue end
					end
					buildAssertFail()
				end
				-- Check last type left
				if continue() and not is(current_value, current_types) then buildAssertFail() end
				::continue::
			end
		end
		if _error or (not success and not silent_or_nil) then
			error(message, 2)
		else
			return {success, message}
		end
	end,
	assertOverrides = function(...)
		local parameters = {...}
		local function getLast(_type)
			local last = parameters[#parameters]
			if type(last) == _type then
				parameters[#parameters] = nil
				return last
			end
			return false
		end
		local function getMatchingArgumentQueries(parameters, args)
			local result, argC = {}, #args
			for _i, _collection in ipairs(parameters) do
				if #_collection == argC then
					result[#result+1] = _collection
				end
			end
			return result
		end
		local silent, args, success, messages, result = getLast("boolean"), getLast("table"), false, {" \n\nMethodcall with optional parameter types:"}, nil
		local matchings = getMatchingArgumentQueries(parameters, args)
		for _i, _match in ipairs(matchings) do
			result = Spindle.assert(_match, args, true)
			if result[2] ~= "" then
				messages[#messages+1] = result[2]
			end
			success = success or result[1]
		end
		if silent or success then
			return true
		else
			error(table.concat(messages, "\n") .. "\n", 3)
		end
	end,
	-- Development Sub Module
	dev = {
		deeperTrace = function(i)
			Spindle.assert({"number"}, {i})
			Spindle.library.devTracebackOverwrite = i
		end,
		setDebug = function(name, state)
			local key = "devPrint" .. name:lower():gsub("^%l", string.upper)
			Spindle.library[key] = state
		end,
		disable = function(...)
			local arguments = {...}
			for i, arg in ipairs(arguments) do
				Spindle.dev.setDebug(arg, false)
			end
		end,
		enable = function(...)
			local arguments = {...}
			for i, arg in ipairs(arguments) do
				Spindle.dev.setDebug(arg, true)
			end
		end,
		from = function()
			local info = debug.getinfo(
				Spindle.library.devTracebackOverwrite and Spindle.library.devTracebackOverwrite or Spindle.library.devTracebackDefault
			)
			Spindle.library.devTracebackOverwrite = nil
			return ("[%s:line(%d):func(%s)]"):format(info.source, info.linedefined, info.name)
		end,
		todo = function(message)
			if not Spindle.library.devPrintTodo then return end
			Spindle.assert({"string"}, {message})
			Spindle.debug(("TODO: %q %s"):format(message, Spindle.dev.from()))
		end,
		fixme = function(message)
			if not Spindle.library.devPrintFixme then return end
			message = message or ""
			Spindle.assert({"string"}, {message})
			Spindle.debug(("FIXME: %s MESSAGE: %q"):format(Spindle.dev.from(), message))
		end,
		deprecated = function(instead)
			if not Spindle.library.devPrintDeprecated then return end
			Spindle.assert({"string"}, {instead})
			Spindle.debug(("DEPRECATED: %s is deprecated!\n\tUse %s instead."):format(Spindle.dev.from(), instead))
		end
	},
}

Spindle.sayHello()

_G.Spindle = Spindle