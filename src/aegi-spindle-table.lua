Spindle.table = {
	tostring = function(t)
		Spindle.assert({"table"}, {t})
		local result, result_n = {}, 0
		local function convert_recursive(t, space)
			for key, value in pairs(t) do
				if type(key) == "string" then key = string.format("%q", key) end
				if type(value) == "string" then value = string.format("%q", value) end
				result_n = result_n + 1
				result[result_n] = string.format("%s[%s] = %s", space, key, tostring(value))
				if type(value) == "table" then
					convert_recursive(value, space .. "\t")
				end
			end
		end
		convert_recursive(t, "")
		return table.concat(result, "\n")
	end,
	removekey = function(table, key)
		Spindle.assert({"table", true}, {table, key})
		if type(table) ~= "table" then return nil end
		if table[key] == nil then return nil end
		local e = table[key]
		table[key] = nil
		return e
	end,
	copy = function(t, depth)
		Spindle.assertOverrides({"table"}, {"table", "number"}, {t, depth})
		depth = depth >= 1 and depth or nil
		local function copy_recursive(old_t)
			local new_t = {}
			for key, value in pairs(old_t) do
				new_t[key] = type(value) == "table" and copy_recursive(value) or value
			end
			return new_t
		end
		local function copy_recursive_n(old_t, depth)
			local new_t = {}
			for key, value in pairs(old_t) do
				new_t[key] = type(value) ~= "table" and value or depth >= 2 and copy_recursive_n(value, depth-1) or nil
			end
			return new_t
		end
		return depth and copy_recursive_n(t, depth) or copy_recursive(t)
	end,
}