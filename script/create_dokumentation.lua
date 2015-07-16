-- This script creates the whole documentation for the Github Repository

local ffi = require("ffi")

ffi.cdef([[
static const int MAX_PATH = 260;
enum{FILE_ATTRIBUTE_DIRECTORY = 0x10};

typedef unsigned int UINT;
typedef int BOOL;
typedef int* LPBOOL;
typedef wchar_t WCHAR;
typedef unsigned long DWORD;
typedef char* LPSTR;
typedef const char* LPCSTR;
typedef wchar_t* LPWSTR;
typedef const wchar_t* LPCWSTR;
typedef void* HANDLE;

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

int MultiByteToWideChar(UINT, DWORD, LPCSTR, int, LPWSTR, int);
int WideCharToMultiByte(UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL);
HANDLE FindFirstFileW(LPCWSTR, LPWIN32_FIND_DATAW);
BOOL FindNextFileW(HANDLE, LPWIN32_FIND_DATAW);
BOOL FindClose(HANDLE);
]])

local CP_UTF8 = 65001
local function utf8_to_utf16(s)
	local wlen = ffi.C.MultiByteToWideChar(CP_UTF8, 0x0, s, -1, nil, 0)
	local ws = ffi.new("wchar_t[?]", wlen)
	ffi.C.MultiByteToWideChar(CP_UTF8, 0x0, s, -1, ws, wlen)
	return ws
end
local function utf16_to_utf8(ws)
	local slen = ffi.C.WideCharToMultiByte(CP_UTF8, 0x0, ws, -1, nil, 0, nil, nil)
	local s = ffi.new("char[?]", slen)
	ffi.C.WideCharToMultiByte(CP_UTF8, 0x0, ws, -1, s, slen, nil, nil)
	return ffi.string(s)
end
local function read_dir(dir_name)
	local find_data = ffi.new("WIN32_FIND_DATAW[1]")
	local dir_handle = ffi.gc(ffi.C.FindFirstFileW(utf8_to_utf16(dir_name.."\\*"), find_data), ffi.C.FindClose)
	if not dir_handle then
		error("Couldn't find directory!", 2)
	end
	local files = {n = 0}
	repeat
		files.n = files.n + 1
		files[files.n] = {
			name = utf16_to_utf8(find_data[0].cFileName),
			type = find_data[0].dwFileAttributes == ffi.C.FILE_ATTRIBUTE_DIRECTORY and "directory" or "file"
		}
	until ffi.C.FindNextFileW(dir_handle, find_data) == 0
	return files
end

table.tostring = function(t)
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
end

local function create_docs(base_path, file_pattern)
	local function get_files(path)
		local files, doc_files = read_dir(path), {}
		for i=1, files.n do
			local file = files[i]
			if file.type == "file" and file.name:find("%.lua$") then
				local f = ("%s/%s"):format(path, file.name)
				doc_files[#doc_files+1] = f
			end
		end
		return doc_files
	end
	local function get_important_content_from_file(file)
		local input = io.open(file, "r")
		local content = input:read("*a")
		input:close()
		
		return content:sub(5, content:find("]]", 1, true) - 1)
	end
	local function get_docs_table(content)
		local function filter(key)
			local pos = content:find(key, 1, true) or false
			if not pos then return "" end
			local line_start = content:sub(pos)
			local end_pos = line_start:find("\n")
			return line_start:sub(key:len()+2, end_pos-1) or ""
		end
		local function getInternal()
			local pos = content:find("docInternal", 1, true)
			local doc = content:sub(pos + 13):gsub("\t", "")
			local result = {}
			for p in doc:gmatch("(.-)\n") do
				result[#result+1] = p:gsub("\n", "")
			end
			return result
		end
		return {
			name = filter("name"),
			fullname = filter("fullname"),
			description = filter("description"),
			extends = filter("extends"),
			depends = filter("depends"),
			author = filter("author"),
			version = filter("version"),
			type = filter("type"),
			docExternal = filter("docExternal"),
			docInternal = getInternal()
		}
	end
	local function extract_dokumentation_path(link)
		return link:match("doc/(.*)")
	end
	local function get_doc_path_from_file(name)
		local path = ("%s/src/%s%s.lua"):format(base_path, file_pattern, name:lower())
		local content = get_important_content_from_file(path)
		local docs_table = get_docs_table(content)
		local doc_path = extract_dokumentation_path(docs_table.docExternal)
		return ("[%s](../%s)"):format(name, doc_path)
	end
	local function write_readme(docs)
		local function select(t, c)
			local result = {}
			for i=1, #t do
				local e = t[i]
				if c(e) then result[#result+1] = e end
			end
			return result
		end
		
		local out_name = base_path .. "/doc/README.md"
		local f = io.open(out_name, "w")
		f:seek("set")
		
		f:write("AegiSpindle Documentation\n=========================\n\n###CORE\n")
		local core = select(docs, function(e) return e.type == "core" end)
		for i=1, #core do
			local c = core[i]
			f:write(("* [%s](%s) - %s"):format(c.name, c.docs_path, c.description), "\n")
		end
		
		f:write("\n###ENTRY-SCRIPTS\n")
		local ent = select(docs, function(e) return e.type == "entry" end)
		for i=1, #ent do
			local e = ent[i]
			f:write(("* [%s](%s) - %s"):format(e.name, e.docs_path, e.description), "\n")
		end
		
		f:write("\n###MODULES\n")
		local mods = select(docs, function(e) return e.type == "module" end)
		for i=1, #mods do
			local m = mods[i]
			f:write(("* [%s](%s) - %s"):format(m.name, m.docs_path, m.description), "\n")
		end
		
		f:close()
	end
	local function write_doc(doc)
		local function get_underline(text)
			return ("-"):rep(text:len())
		end
		local function split_doc_line(line)
			local pos = line:find(") ", 1, true) or line:find(" ", 1, true) - 1
			local lead = line:sub(1, pos)
			local tail = line:sub(pos+2)
			return lead, tail
		end
		local function get_references(literal)
			local function split(s, delimiter)
				result = {};
				for match in (s..delimiter):gmatch("(.-)"..delimiter) do
					table.insert(result, match);
				end
				return result;
			end
			if literal == "" then return false end
			local result = false
			if literal:find(",") then
				local t, r = split(literal, ","), {}
				for i=1, #t do r[#r+1] = get_doc_path_from_file(t[i]) end
				result = table.concat(r, ", ")
			else
				result = get_doc_path_from_file(literal)
			end
			return result
		end
		local out_name = base_path .. "/doc/" .. doc.docs_path
		local f = io.open(out_name, "w")
		f:seek("set")
		
		local extends = get_references(doc.extends)
		local depends = get_references(doc.depends)
		
		f:write(("%s\n%s\n%s\n\n* Shortname: %s\n* Version: %s\n* Author: %s\n%s%s"):format(
			doc.fullname, 
			get_underline(doc.fullname), 
			doc.description,
			doc.name,
			doc.version,
			doc.author,
			extends and ("* Extends: %s\n"):format(extends) or "",
			depends and ("* Depends on: %s\n"):format(depends) or ""
		))
		if #doc.docInternal == 1 and doc.docInternal[1] == "" then
			f:write("\n***No function or property documentation for this script!***\n")
		else
			for i=1, #doc.docInternal do
				local current_doc = doc.docInternal[i]
				f:write("\n", ("###%s\n%s"):format(split_doc_line(current_doc)), "\n")
			end
		end
		
		f:close()
	end
	
	local src_path = base_path .. "/src"
	local files, docs = get_files(src_path), {}
	print(("Create documentation for %d files..."):format(#files))
	for i=1, #files do
		local file = files[i]
		local content = get_important_content_from_file(file)
		local docs_table = get_docs_table(content)
		docs_table["docs_path"] = extract_dokumentation_path(docs_table.docExternal)
		docs[#docs+1] = docs_table
		
		write_doc(docs_table)
	end
	write_readme(docs)
end

create_docs("..", "aegi-spindle-")
--[[
def create_hash(comment)
	internal = false
	hash = {}
	comment.each_line { |line|
		line.sub!("\n", "")
		if line.include?(":") && !internal
			key, value = *line.split(":", 2)
			internal = key == "docInternal" ? [] : false
			unless internal
				hash[key.to_sym] = value
			end
		elsif internal
			internal << line.sub("\t", "")
		end
	}
	
	hash[:internal] = internal
	
	return hash
end

def get_doku_path(path)
	return path.scan(/doc\/(.*)/)[0][0]
end

def create_readme(doku)
	path = "../doc/README.md"
	file = File.open(path, "wb")
	file.puts "AegiSpindle Documentation"
	file.puts "========================="
	file.puts "\n###CORE"
	
	doku.select do |e| e[:type] == "core" end.each { |f|
		path = get_doku_path(f[:docExternal])
		file.puts "* [#{f[:name]}](#{path}) - #{f[:description]}"
	}
	
	file.puts "\n###ENTRY-SCRIPTS"
	
	doku.select do |e| e[:type] == "entry" end.each { |f|
		path = get_doku_path(f[:docExternal])
		file.puts "* [#{f[:name]}](#{path}) - #{f[:description]}"
	}
	
	file.puts "\n###MODULES"
	
	doku.select do |e| e[:type] == "module" end.each { |f|
		path = get_doku_path(f[:docExternal])
		file.puts "* [#{f[:name]}](#{path}) - #{f[:description]}"
	}
	
	file.close()
end

files, doku = Dir["*.lua"], []

files.each { |lua_file|
	content = File.read(lua_file)
	comment = content[5, content.index("]") - 5]
	
	doku << create_hash(comment)
}
create_readme(doku)
]]