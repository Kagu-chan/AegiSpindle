Spindle.math = {
	randomsteps = function(min, max, step)
		Spindle.assert({"number", "number", "number"}, {min, max, step})
		return math.min(min + math.random(0, math.ceil((max - min) / step)) * step, max)
	end,
	trim = function(x, min, max)
		Spindle.assert({"number", "number", "number"}, {x, min, max})
		return x < min and min or x > max and max or x
	end,
	round = function(x, dec)
		Spindle.assertOverrides({"number"}, {"number", "number"}, {x, dec})
		if dec and dec >= 1 then
			dec = 10^math.floor(dec)
			return math.floor(x * dec + 0.5) / dec
		else
			return math.floor(x + 0.5)
		end
	end,
	buildWrapper = function()
		math.randomsteps = Spindle.math.randomsteps
		math.trim = Spindle.math.trim
		math.round = Spindle.math.round
	end,
}