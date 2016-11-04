--[[
name:Text
fullname:Spindle.Text
description:Text- and String-Functions
fulldescription:This module provides some functions for working with texts.
extends:
depends:
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/text.md
docInternal:
	Spindle.text.trim(string s) Remove leading and following white spaces from s
	Spindle.text.headtails(string s) Returns first word and following text seperately from text
	Spindle.text.words(string s) Iterator function for texts words
	Spindle.text.wordtable(string s) Returns texts words as table
	Spindle.text.split(string s[, string seperator][, number count]) Split string by seperator into a table. If no seperator is given, seperator is `:'. If count is given, the table contains at maximum count items
	Spindle.text.len(string s) Returns strings length
	Spindle.text.buildWrapper() Wrapper function for core application
]]

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

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
	split = function(s, sep_or_count, count)
		Spindle.assertOverrides({"string"}, {"string", "string"}, {"string", "number"}, {"string", "string", "number"}, {s, sep_or_count, count})
		local sep, count, fields, result = 
			sep_or_count and (type(sep_or_count) == "string" and sep_or_count or ":") or ":", 
			count or (sep_or_count and type(sep_or_count) == "number" and sep_or_count or 0), 
			{}, {}
		
		local pattern = ("([^%s]+)"):format(sep)
		s:gsub(pattern, function(c)
			if count == 0 or #fields < count then 
				fields[#fields + 1] = c
			else
				local cur = fields[#fields]
				cur = cur .. sep .. c or c
				fields[#fields] = cur
			end
		end)
		return fields
	end,
	len = function(s)
		Spindle.assert({"string"}, {s})
		return Spindle.text.wordtable(s).n
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write wrapper")
	end,
}