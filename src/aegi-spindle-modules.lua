require("aegi-spindle-main")

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
			local fName = string.format("aegi-spindle-%s", name)
			local result = {pcall(function() return require(fName) end)}
			if not result[1] then
				Spindle.debug(string.format("Failed load module [%q]\nFailure Message is\n\t%q",
					name, result[2]:gsub("^.*:.*:%s", "")
				))
				return false
			else
				Spindle.modules.modules.add(name)
				if Spindle.modules.trace then
					Spindle.debug(string.format("Loaded module [%q] - %d modules loaded",
						name,
						Spindle.modules.modules.n
					))
				end
				return select(2, unpack(result))
			end
		else
			Spindle.debug(string.format("Warning: [%q] can't loaded since it's alredy loaded!", name))
		end
	end,
	require = function(name)
		Spindle.assert({"string"}, {name})
		if Spindle.modules.autoLoadRequires and not Spindle.modules.loaded(name) then
			Spindle.modules.load(name)
		end
		if not Spindle.modules.loaded(name) then
			local info = debug.getinfo(2)
			message = string.format("\n\nError: Module [%q] required! See [%s:line(%d):func(%s)]\n",
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
		local targetWrapper = target.buildWrapper and type(target.buildWrapper) == "function" and target.buildWrapper or nil
		local sourceWrapper = source.buildWrapper and type(source.buildWrapper) == "function" and source.buildWrapper or nil
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
		local t = {string.format("Loaded Modules (%s):", modules.n)}
		
		for key, val in pairs(modules) do
			if not (key == "add" or key == "n") then
				c = c + 1
				t[c] = "\t" .. key
			end
		end
		Spindle.debug(table.concat(t, "\n"))
	end,
}