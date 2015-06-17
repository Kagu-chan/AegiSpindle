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
		--print("TODO")
	end,
}