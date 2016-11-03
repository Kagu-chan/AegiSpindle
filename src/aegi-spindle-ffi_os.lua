local Spindle = _G.Spindle or {}

Spindle.modules.require("ffi")

Spindle.oop.generateClass("CurrentOS", {}, {}, {
    windows = true,
    linux = true,
    osx = true
}, "windows", "linux", "osx")

Spindle.ffi_os = {
    raw_os = function()
        return Spindle.ffi.ffi().os
    end,
    os = function()
        local currentOS = Spindle.ffi_os.raw_os()
        return CurrentOS.new(
            currentOS == "Windows",
            currentOS == "Linux",
            currentOS == "OSX"
        )
    end
}

Spindle.modules.import(Spindle.ffi, Spindle.ffi_os)


Spindle.ffi.new(
	"fileutilsx",
	[[
typedef unsigned long DWORD;
typedef wchar_t WCHAR;
typedef void* HANDLE;
typedef const wchar_t* LPCWSTR;
typedef int BOOL;

static const int MAX_PATH = 260;
enum{FILE_ATTRIBUTE_DIRECTORY = 0x10};

typedef struct{
	DWORD dwLowDateTime;
	DWORD dwHighDateTime;
}FILETIME;
typedef struct{
	DWORD dwFileAttributes;
	FILETIME ftCreationTime;
	FILETIME ftLastAccessTime;
	FILETIME ftLastWriteTime;
	DWORD nFileSizeHight;
	DWORD nFileSizeLow;
	DWORD dwReserved0;
	DWORD dwReserved1;
	WCHAR cFileName[MAX_PATH];
	WCHAR cAlternateFilename[14];
}WIN32_FIND_DATAW, *LPWIN32_FIND_DATAW;

HANDLE FindFirstFileW(LPCWSTR, LPWIN32_FIND_DATAW);
BOOL FindNextFileW(HANDLE, LPWIN32_FIND_DATAW);
BOOL FindClose(HANDLE);
	]],
	function() end,
	{
		readdir = function(dir_name)
			local find_data = Spindle.ffi.ffi().new("WIN32_FIND_DATAW[1]")
			local dir_handle = Spindle.ffi.ffi().gc(
				Spindle.ffi.ffi().C.FindFirstFileW(
					Spindle.utf8.utf8_to_utf16(dir_name.."\\*"),
					find_data
				), 
				Spindle.ffi.ffi().C.FindClose
			)
			if not dir_handle then
				error("Couldn't find directory!", 2)
			end
			local files = {n = 0}
			repeat
				files.n = files.n + 1
				files[files.n] = {
					name = Spindle.utf8.utf16_to_utf8(find_data[0].cFileName),
					type = find_data[0].dwFileAttributes == Spindle.ffi.ffi().C.FILE_ATTRIBUTE_DIRECTORY and "directory" or "file"
				}
			until Spindle.ffi.ffi().C.FindNextFileW(dir_handle, find_data) == 0
			return files
		end,
	}
)

Spindle.fileutilsx = {
	readdir = function(dir_name)
		return Spindle.ffi.send("fileutilsx", "readdir", dir_name)
	end
}