--[[
name:UTF8-FFI
fullname:Spindle.UTF8.FFI
description:UTFS8 ffi extension module
fulldescription:This module extends the Spindle.UTF8 module by C-Functions.
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

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

Spindle.modules.require("utf8")
Spindle.modules.require("ffi")

Spindle.ffi.new(
	"utf8_ffi",
	[[
typedef unsigned int UINT;
typedef int* LPBOOL;
typedef unsigned long DWORD;
typedef char* LPSTR;
typedef const char* LPCSTR;
typedef wchar_t* LPWSTR;
typedef const wchar_t* LPCWSTR;

enum{CP_UTF8 = 65001};

int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);
int WideCharToMultiByte(UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL);
	]],
	function() end,
	{
		utf8_to_utf16 = function(s)
			local wlen = Spindle.ffi.ffi().C.MultiByteToWideChar(Spindle.ffi.ffi().C.CP_UTF8, 0x0, s, -1, nil, 0)
			local ws = Spindle.ffi.ffi().new("wchar_t[?]", wlen)
			Spindle.ffi.ffi().C.MultiByteToWideChar(Spindle.ffi.ffi().C.CP_UTF8, 0x0, s, -1, ws, wlen)
			return ws
		end,
		utf16_to_utf8 = function(ws)
			local slen = Spindle.ffi.ffi().C.WideCharToMultiByte(Spindle.ffi.ffi().C.CP_UTF8, 0x0, ws, -1, nil, 0, nil, nil)
			local s = Spindle.ffi.ffi().new("char[?]", slen)
			Spindle.ffi.ffi().C.WideCharToMultiByte(Spindle.ffi.ffi().C.CP_UTF8, 0x0, ws, -1, s, slen, nil, nil)
			return Spindle.ffi.ffi().string(s)
		end,
	}
)

Spindle.utf8_ffi = {
	utf8_to_utf16 = function(s)
		return Spindle.ffi.send("utf8_ffi", "utf8_to_utf16", s)
	end,
	utf16_to_utf8 = function(ws)
		return Spindle.ffi.send("utf8_ffi", "utf16_to_utf8", ws)
	end,
	buildWrapper = function()
		Spindle.dev.todo("Write Wrapper")
	end
}

Spindle.modules.import(Spindle.utf8, Spindle.utf8_ffi)