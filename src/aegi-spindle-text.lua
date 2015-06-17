Spindle.text = {
	trim = function(s)
		Spindle.assert({"string"}, {s})
		return (s:gsub("^%s*(.-)%s*$", "%1"))
	end,
	headtails = function(s)
		Spindle.assert({"string"}, {s})
		local pos_space, pos_word = s:find("(%w)%s(.-)")
		return s:sub(0, pos_space), pos_word and s:sub(pos_word+1) or nil
	end,
	words = function(s)
		Spindle.assert({"string"}, {s})
		local current, rest, i = "", s, 0
		return function()
			if rest then
				current, rest = Spindle.text.headtails(rest)
				i = i + 1
				return i, current
			end
		end
	end,
	wordtable = function(s)
		Spindle.assert({"string"}, {s})
		local t = { n = 0 }
		for _wi, _w in Spindle.text.words(s) do
			t.n = t.n + 1
			t[t.n] = _w
		end
		return t
	end,
	len = function(s)
		Spindle.assert({"string"}, {s})
		return Spindle.text.wordtable(s).n
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper")
	end,
}