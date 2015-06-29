Spindle.utf8 = {
	--[[ UTF32 -> UTF8
U-00000000 - U-0000007F:		0xxxxxxx
U-00000080 - U-000007FF:		110xxxxx 10xxxxxx
U-00000800 - U-0000FFFF:		1110xxxx 10xxxxxx 10xxxxxx
U-00010000 - U-001FFFFF:		11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
U-00200000 - U-03FFFFFF:		111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
U-04000000 - U-7FFFFFFF:		1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
	]]
	charrange = function(s, i)
		Spindle.assert({"string", "number"}, {s, i})
		local byte = s:byte(i)
		return not byte and 0 or
				byte < 192 and 1 or
				byte < 224 and 2 or
				byte < 240 and 3 or
				byte < 248 and 4 or
				byte < 252 and 5 or
				6
	end,
	chars = function(s)
		Spindle.assert({"string"}, {s})
		local char_i, s_pos, s_len = 0, 1, #s
		return function()
			if s_pos <= s_len then
				local cur_pos = s_pos
				s_pos = s_pos + Spindle.utf8.charrange(s, s_pos)
				if s_pos-1 <= s_len then
					char_i = char_i + 1
					return char_i, s:sub(cur_pos, s_pos-1)
				end
			end
		end
	end,
	chartable = function(s)
		Spindle.assert({"string"}, {s})
		local r = { n = 0 }
		for ci, c in Spindle.utf8.chars(s) do
			r.n = r.n + 1
			r[r.n] = c
		end
		return r
	end,
	len = function(s)
		Spindle.assert({"string"}, {s})
		return Spindle.utf8.chartable(s).n
	end,
	bton = function(s)
		local bytes, n = {s:byte(1,-1)}, 0
		for i = 0, #s - 1 do
			n = n + bytes[1 + i] * 256 ^ i
		end
		return n
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper")
	end,
}