Spindle.type = {
	isnil = function(x) return x == nil end,
	isbool = function(x) return type(x) == "boolean" end,
	isboolean = function(x) return type(x) == "boolean" end,
	isnum = function(x) return type(x) == "number" end,
	isnumber = function(x) return type(x) == "number" end,
	isint = function(x) return Spindle.type.isnumber(x) and math.floor(x) == x end,
	isinteger = function(x) return Spindle.type.isnumber(x) and math.floor(x) == x end,
	isstring = function(x) return type(x) == "string" end,
	istext = function(x) return Spindle.type.isstring(x) and Spindle.type.isnil(x:find("[%z\1-\6\14-\31]")) end,
	istable = function(x) return type(x) == "table" end,
	isfunc = function(x) return type(x) == "function" end,
	isfunction = function(x) return type(x) == "function" end,
	ispure = function(x) return Spindle.type.isfunction(x) and Spindle.type.isnil(debug.getupvalue(x, 1)) end,
	isthread = function(x) return type(x) == "thread" end,
	isudata = function(x) return type(x) == "userdata" end,
	isuserdata = function(x) return type(x) == "userdata" end,
	iscdata = function(x) return type(x) == "cdata" end,
	issame = function(x, y) return type(a) == type(b) end,
	default = function(x, default) return Spindle.type.isnil(x) and default or x end,
	isarray = function(x)
		if not Spindle.type.istable(x) then return false end
		for key in pairs(x) do
			if not Spindle.type.isint(key) or key < 1 then return false end
		end
		return true
	end,
	buildWrapper = function()
		local _t = Spindle.type
		for _n, _v in pairs(_t) do
			if _n:find("is") == 1 or _n == "default" then
				_G[_n] = _v
			end
		end
	end,
	--buildWrapper = function()
	--	local _t = Spindle.type
	--	for _n, _v in ipairs(_t) do
	--		print(_n)
	--	end
	--end,
}