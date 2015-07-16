--[[
name:Text
fullname:Spindle.Text
description:Text- and String-Functions
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
	Spindle.text.len(string s) Returns strings length
	Spindle.text.buildWrapper() Wrapper function for core application
]]

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