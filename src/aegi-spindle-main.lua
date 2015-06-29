_G.Spindle = {
	debug = function(...)
		print(...)
	end,
	sayHello = function()
		Spindle.debug(string.format("Aegi Spindle V %s [LuaJIT (%s)]", Spindle.library.version, _VERSION))
	end,
	library = {
		version = "0.1",
		devTracebackDefault = 3,
		devPrintTodo = true,
		devPrintFixme = true,
		devPrintDeprecated = true,
	},
	initialize = function(printTodo, printFixme, printDeprecated)
		printTodo = (printTodo or printTodo == nil) and true or false
		printFixme = (printFixme or printFixme == nil) and true or false
		printDeprecated = (printDeprecated or printDeprecated == nil) and true or false
		Spindle.assert({"boolean", "boolean", "boolean"}, {printTodo, printFixme, printDeprecated})
		Spindle.dev.setDebug("todo", printTodo)
		Spindle.dev.setDebug("fixme", printFixme)
		Spindle.dev.setDebug("deprecated", printDeprecated)
		Spindle.generateWrapper()
		
	end,
	generateWrapper = function()
		for _moduleName, _module in pairs(Spindle) do
			if type(_module) == "table" and _module.buildWrapper and type(_module.buildWrapper) == "function" then 
				_module.buildWrapper()
			end
		end
	end,
	initializeAegisub = function()
		Spindle.modules.require("auto4-base")
		for _moduleName, _module in pairs(Spindle) do
			if type(_module) == "table" and _module.initAegisub and type(_module.initAegisub) == "function" then 
				_module.initAegisub()
			end
		end
	end,
	--[[ Checks function parameters
		types and values must be in format:
			types: table with expected type(s) {"type", "type", true, {"string", "number"}}
				true means no type, but not optional
				table means "one of them"
			values: table with the given parameters
		silent: if silent is set true [optional], then no exception will be raised
	]]
	assert = function(types, values, silent_or_nil)
		local success, _error, message = true, false, ""
		silent_or_nil = silent_or_nil and silent_or_nil or false
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
					_t = string.format("one of ['%s']", table.concat(_t, "', '"))
				elseif is(_t, "boolean") and _t then
					_t = "any type"
				end
				cache[#cache + 1] = string.format("\t%s", _t)
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