--[[
name:UTF8-FFI
description:UTFS8 ffi extension module
extends:UTF8
depends:UTF8,FFI
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/utf8-ffi.md
docInternal:
	Spindle.utf8.utf8_to_utf16(string s) Returns utf16 representation of utf8 string
	Spindle.utf8.utf16_to_utf8(string s) Returns utf8 representation of utf16 string
	Spindle.utf8.buildWrapper() Wrapper function for core application
]]

Spindle.modules.require("utf8")
Spindle.modules.require("ffi")

Spindle.utf8_ffi = {
	utf8_to_utf16 = function(s)
		local wlen = Spindle.ffi.ffi().C.MultiByteToWideChar(Spindle.ffi.ffi().C.CP_UTF8, 0x0, s, -1, nil, 0)
		local ws = Spindle.ffi.ffi().new("wchar_t[?]", wlen)
		Spindle.ffi.ffi().C.MultiByteToWideChar(Spindle.ffi.ffi().C.CP_UTF8, 0x0, s, -1, ws, wlen)
		return ws
	end,
	utf16_to_utf8 = function(s)
		local slen = Spindle.ffi.ffi().C.WideCharToMultiByte(Spindle.ffi.ffi().C.CP_UTF8, 0x0, ws, -1, nil, 0, nil, nil)
		local s = Spindle.ffi.ffi().new("char[?]", slen)
		Spindle.ffi.ffi().C.WideCharToMultiByte(ffi.C.CP_UTF8, 0x0, ws, -1, s, slen, nil, nil)
		return Spindle.ffi.ffi().string(s)
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write Wrapper")
	end
}

Spindle.modules.import(Spindle.utf8, Spindle.utf8_ffi)