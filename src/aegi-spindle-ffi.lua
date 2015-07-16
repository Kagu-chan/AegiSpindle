--[[
name:FFI
fullname:Spindle.FFI
description:FFI module for C-Library-Calls
fulldescription:This Module provides the FFI library and some short cuts. Also it provides the Advapi32.dll and libpng.dll
extends:
depends:Config,Cache
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/ffi.md
docInternal:
	Spindle.ffi.user_init Optional Callback for initialization extension
	Spindle.ffi.no_windows_callback Optional Callback for non windows initialization
	Spindle.ffi.initialize() FFI initialization function
	Spindle.ffi.load(...) Wrapper for Spindle.ffi.ffi().load(...)
	Spindle.ffi.cdef(...) Wrapper for Spindle.ffi.ffi().cdef(...)
	Spindle.ffi.ffi() Wrapper for Spindle.cache.get("ffi")
	Spindle.ffi.advapi() Wrapper for Spindle.cache.get("advapi")
	Spindle.ffi.libpng() Wrapper for Spindle.cache.get("libpng")
	Spindle.ffi.defines Table with CDEF definitions
]]

Spindle.modules.require("config")
Spindle.modules.require("cache")

Spindle.ffi = {
	-- Overwrite this with a function to do additional stuff after initialization
	user_init = false,
	-- Overwrite this with a function to do additional stuff for non windows systems
	no_windows_callback = false,
	initialize = function()
		if not Spindle.cache.get("ffi_init") then
			Spindle.cache.set("advapi", false)
			Spindle.cache.set("libpng", false)
			Spindle.cache.set("ffi", require("ffi"))
			
			if Spindle.ffi.ffi().os == "Windows" then
				Spindle.cache.set("advapi", Spindle.ffi.ffi().load("Advapi32"))
				Spindle.ffi.cdef(Spindle.ffi.defines.windows.advapi)
			else
				if type(Spindle.ffi.no_windows_callback) == "function" then
					Spindle.ffi.no_windows_callback()
				else
					Spindle.debug("Non-Windows-Systems not supported yet!")
				end
			end
			
			pcall(function()
				Spindle.cache.set("libpng", Spindle.ffi.load(Spindle.config.getOrDefault("LibPNGPath", "libpng")))
				Spindle.ffi.cdef(Spindle.ffi.defines.misc.libpng)
			end)
			
			if type(Spindle.ffi.user_init) == "function" then Spindle.ffi.user_init() end
			Spindle.cache.set("ffi_init", true)
		end
	end,
	load = function(...)
		return Spindle.ffi.ffi().load(...)
	end,
	cdef = function(...)
		return Spindle.ffi.ffi().cdef(...)
	end,
	ffi = function()
		return Spindle.cache.get("ffi")
	end,
	advapi = function() return Spindle.cache.get("advapi") end,
	libpng = function() return Spindle.cache.get("libpng") end,
	defines = {
		misc = {
			libpng = [[
static const int PNG_SIGNATURE_SIZE = 8;
typedef unsigned char png_byte;
typedef png_byte* png_bytep;
typedef const png_bytep png_const_bytep;
typedef unsigned int png_size_t;
typedef char png_char;
typedef png_char* png_charp;
typedef const png_charp png_const_charp;
typedef void png_void;
typedef png_void* png_voidp;
typedef struct png_struct* png_structp;
typedef const png_structp png_const_structp;
typedef struct png_info* png_infop;
typedef const png_infop png_const_infop;
typedef unsigned int png_uint_32;
typedef void (__cdecl *png_error_ptr)(png_structp, png_const_charp);
typedef void (__cdecl *png_rw_ptr)(png_structp, png_bytep, png_size_t);
enum{
	PNG_TRANSFORM_STRIP_16 = 0x1,
	PNG_TRANSFORM_PACKING = 0x4,
	PNG_TRANSFORM_EXPAND = 0x10,
	PNG_TRANSFORM_BGR = 0x80
};
enum{
	PNG_COLOR_MASK_COLOR = 2,
	PNG_COLOR_MASK_ALPHA = 4
};
enum{
	PNG_COLOR_TYPE_RGB = PNG_COLOR_MASK_COLOR,
	PNG_COLOR_TYPE_RGBA = PNG_COLOR_MASK_COLOR | PNG_COLOR_MASK_ALPHA
};

void* memcpy(void*, const void*, size_t);
int png_sig_cmp(png_const_bytep, png_size_t, png_size_t);
png_structp png_create_read_struct(png_const_charp, png_voidp, png_error_ptr, png_error_ptr);
void png_destroy_read_struct(png_structp*, png_infop*, png_infop*);
png_infop png_create_info_struct(png_structp);
void png_set_read_fn(png_structp, png_voidp, png_rw_ptr);
void png_read_png(png_structp, png_infop, int, png_voidp);
int png_set_interlace_handling(png_structp);
void png_read_update_info(png_structp, png_infop);
png_uint_32 png_get_image_width(png_const_structp, png_const_infop);
png_uint_32 png_get_image_height(png_const_structp, png_const_infop);
png_byte png_get_color_type(png_const_structp, png_const_infop);
png_size_t png_get_rowbytes(png_const_structp, png_const_infop);
png_bytep* png_get_rows(png_const_structp, png_const_infop);
			]],
		},
		windows = {
			advapi = [[
enum{CP_UTF8 = 65001};
enum{MM_TEXT = 1};
enum{TRANSPARENT = 1};
enum{
	FW_NORMAL = 400,
	FW_BOLD = 700
};
enum{DEFAULT_CHARSET = 1};
enum{OUT_TT_PRECIS = 4};
enum{CLIP_DEFAULT_PRECIS = 0};
enum{ANTIALIASED_QUALITY = 4};
enum{DEFAULT_PITCH = 0x0};
enum{FF_DONTCARE = 0x0};
enum{
	PT_MOVETO = 0x6,
	PT_LINETO = 0x2,
	PT_BEZIERTO = 0x4,
	PT_CLOSEFIGURE = 0x1
};
typedef unsigned int UINT;
typedef unsigned long DWORD;
typedef DWORD* LPDWORD;
typedef const char* LPCSTR;
typedef const wchar_t* LPCWSTR;
typedef wchar_t* LPWSTR;
typedef char* LPSTR;
typedef void* HANDLE;
typedef HANDLE HDC;
typedef int BOOL;
typedef BOOL* LPBOOL;
typedef unsigned int size_t;
typedef HANDLE HFONT;
typedef HANDLE HGDIOBJ;
typedef long LONG;
typedef wchar_t WCHAR;
typedef unsigned char BYTE;
typedef BYTE* LPBYTE;
typedef int INT;
typedef long LPARAM;
static const int LF_FACESIZE = 32;
static const int LF_FULLFACESIZE = 64;
typedef struct{
	LONG tmHeight;
	LONG tmAscent;
	LONG tmDescent;
	LONG tmInternalLeading;
	LONG tmExternalLeading;
	LONG tmAveCharWidth;
	LONG tmMaxCharWidth;
	LONG tmWeight;
	LONG tmOverhang;
	LONG tmDigitizedAspectX;
	LONG tmDigitizedAspectY;
	WCHAR tmFirstChar;
	WCHAR tmLastChar;
	WCHAR tmDefaultChar;
	WCHAR tmBreakChar;
	BYTE tmItalic;
	BYTE tmUnderlined;
	BYTE tmStruckOut;
	BYTE tmPitchAndFamily;
	BYTE tmCharSet;
}TEXTMETRICW, *LPTEXTMETRICW;
typedef struct{
	LONG cx;
	LONG cy;
}SIZE, *LPSIZE;
typedef struct{
	LONG left;
	LONG top;
	LONG right;
	LONG bottom;
}RECT;
typedef const RECT* LPCRECT;
typedef struct{
	LONG x;
	LONG y;
}POINT, *LPPOINT;
typedef struct{
  LONG  lfHeight;
  LONG  lfWidth;
  LONG  lfEscapement;
  LONG  lfOrientation;
  LONG  lfWeight;
  BYTE  lfItalic;
  BYTE  lfUnderline;
  BYTE  lfStrikeOut;
  BYTE  lfCharSet;
  BYTE  lfOutPrecision;
  BYTE  lfClipPrecision;
  BYTE  lfQuality;
  BYTE  lfPitchAndFamily;
  WCHAR lfFaceName[LF_FACESIZE];
}LOGFONTW, *LPLOGFONTW;
typedef struct{
  LOGFONTW elfLogFont;
  WCHAR   elfFullName[LF_FULLFACESIZE];
  WCHAR   elfStyle[LF_FACESIZE];
  WCHAR   elfScript[LF_FACESIZE];
}ENUMLOGFONTEXW, *LPENUMLOGFONTEXW;
enum{
	FONTTYPE_RASTER = 1,
	FONTTYPE_DEVICE = 2,
	FONTTYPE_TRUETYPE = 4
};
typedef int (__stdcall *FONTENUMPROC)(const ENUMLOGFONTEXW*, const void*, DWORD, LPARAM);
enum{ERROR_SUCCESS = 0};
typedef HANDLE HKEY;
typedef HKEY* PHKEY;
enum{HKEY_LOCAL_MACHINE = 0x80000002};
typedef enum{KEY_READ = 0x20019}REGSAM;

int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);
int WideCharToMultiByte(UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL);
HDC CreateCompatibleDC(HDC);
BOOL DeleteDC(HDC);
int SetMapMode(HDC, int);
int SetBkMode(HDC, int);
size_t wcslen(const wchar_t*);
HFONT CreateFontW(int, int, int, int, int, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, DWORD, LPCWSTR);
HGDIOBJ SelectObject(HDC, HGDIOBJ);
BOOL DeleteObject(HGDIOBJ);
BOOL GetTextMetricsW(HDC, LPTEXTMETRICW);
BOOL GetTextExtentPoint32W(HDC, LPCWSTR, int, LPSIZE);
BOOL BeginPath(HDC);
BOOL ExtTextOutW(HDC, int, int, UINT, LPCRECT, LPCWSTR, UINT, const INT*);
BOOL EndPath(HDC);
int GetPath(HDC, LPPOINT, LPBYTE, int);
BOOL AbortPath(HDC);
int EnumFontFamiliesExW(HDC, LPLOGFONTW, FONTENUMPROC, LPARAM, DWORD);
LONG RegOpenKeyExA(HKEY, LPCSTR, DWORD, REGSAM, PHKEY);
LONG RegCloseKey(HKEY);
LONG RegEnumValueW(HKEY, DWORD, LPWSTR, LPDWORD, LPDWORD, LPDWORD, LPBYTE, LPDWORD);
			]],
		},
	},
}
