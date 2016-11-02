--[[
name:GitDoc
fullname:Spindle.GitDoc
description:Git Documentation Module
fulldescription:This Script will create a github conform documentation of given src directory
extends:
depends:Cache,Config,OOP,Table,Text,Fileutils
author:Kagu-chan
version:1.0
type:module
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/modules/gitdoc.md
docInternal:
	DocFile DocFile Object
	DocFile.new(string raw) Creates a new Instance of DocFile
	DocFile.fromtable(table t) Creates a new Instance from given table
	DocFile.extendProperty(string name, mixed _type) Add new property and respective getter / setter to the object
	DocFile:raw([string raw]) Sets or gets raw value of instance
	DocFile:path([string path]) Sets or gets path value of instance
	DocFile:source([string source]) Sets or gets source value of instance
	DocFile:docFile([string docFile]) Sets or gets docFile value of instance
	DocFile:sourceLink([string sourceLink]) Sets or gets sourceLink value of instance
	DocFile:documentation([string documentation]) Sets or gets documentation value of instance
	DocFile:totable() Returns table representation of instance
	DocFile:filter(string key) Filter out a key value pair and returns the value
	DocFile:underline() Returns a '-'-string with the same length as fullname value
	DocFile:internal() Returns the internal documentation as table
	DocFile:filterReferences(string literal) Returns a link list of references
	DocFile:build() Generate the documentation-string
	ExampleFile ExampleFile Object
	ExampleFile.new(string raw) Creates a new Instance of ExampleFile
	ExampleFile.fromtable(table t) Creates a new Instance from given table
	ExampleFile.extendProperty(string name, mixed _type) Add new property and respective getter / setter to the object
	ExampleFile:raw([string raw]) Sets or gets raw value of instance
	ExampleFile:examples([table examples]) Sets or gets examples value of instance
	ExampleFile:parse() Parse the raw into a table of examples
	Spindle.GitDoc.init(string header, string file_path, string file_prefix, string base_url, string examples, string doc_path) Initialize the documentation procress
	Spindle.GitDoc.run() Run the documentation process
	Spindle.GitDoc.init_counters() Initialize the counter values with 0
	Spindle.GitDoc.increment_objects() Increment the objects counter by 1
	Spindle.GitDoc.increment_examples() Increment the examples counter by 1
	Spindle.GitDoc.cache_examples() Parse and cache the examples as ExampleFile
	Spindle.GitDoc.cache_files() Cache the sourcecode files
	Spindle.GitDoc.read_files() Parse and Cache the sourcecode files as DocFile instances
	Spindle.GitDoc.read_documentation_partial(string file) Filter out the documentation from sourcecode file
	Spindle.GitDoc.extract_doc_path(link) Extract the documentation path relative to the documentation directory from a link
	Spindle.GitDoc.prepare_docs() Build the cached DocFiles
	Spindle.GitDoc.write_documentation() Write the DocFiles parsed in a respective file
	Spindle.GitDoc.write_readme() Write the mainpage of documentation
	Spindle.GitDoc.write_readme_partial(file f, string title, table docs, string _type) Write a doc list in the mainpage of documentation
#only if module "type" is loaded:
	Spindle.type.isdocfile(mixed object) Returns is object is a docfile type
	Spindle.type.isexamplefile(mixed object) Returns is object is a examplefile type
]]

-- Set global functions and objects to local cache for performance
local Spindle, ipairs, io = _G.Spindle or {}, _G.ipairs, _G.io

Spindle.dev.todo("Assert types!")
Spindle.dev.todo("Write out more log information!")

Spindle.oop.generateClass("DocFile", {
	path = "",
	source = "",
	docFile = "",
	sourceLink = "",
	documentation = "",
}, {}, {raw = "string"}, "raw")

Spindle.oop.generateClass("ExampleFile", {
	examples = {},
}, {}, {raw = "string"}, "raw")

function DocFile:filter(key)
	local pos = self:raw():find(key .. ":", 1, true) or false
	if not pos then return "" end
	local line_start = self:raw():sub(pos)
	local end_pos = line_start:find("\n")
	return line_start:sub(key:len()+2, end_pos-1) or ""
end

function DocFile:underline()
	return ("-"):rep(self:filter("fullname"):len())
end

function DocFile:internal()
	local pos = self:raw():find("docInternal", 1, true)
	local doc = self:raw():sub(pos + 13):gsub("\t", "")
	local result = {}
	for p in doc:gmatch("(.-)\n") do
		result[#result+1] = p:gsub("\n", "")
	end
	return result
end

function DocFile:filterReferences(literal)
	if literal == "" then return false end
	local result = {}
	local partials, result = Spindle.text.split(literal:lower(), ","), {}
	for index, element in pairs(partials) do
		local docname = ("documentation.%s-%s.lua"):format(Spindle.config.get("documentation.file_prefix"), element)
		local object = Spindle.cache.get(docname)
		local path = object:docFile()
		result[index] = ("[%s](../%s)"):format(object:filter("fullname"), object:path())
	end
	return table.concat(result, ", ")
end

function DocFile:build()
	local function split_doc_line(line)
		local pos = line:find(") ", 1, true) or line:find(" ", 1, true) - 1
		local lead = line:sub(1, pos)
		local tail = line:sub(pos+2)
		return lead, tail
	end
	local extends = self:filterReferences(self:filter("extends"))
	local depends = self:filterReferences(self:filter("depends"))

	local text = ("%s\n%s\n%s\n\n* Shortname: %s\n* Version: %s\n* Author: %s\n%s%s* Source: %s\n\n> %s\n"):format(
		self:filter("fullname"), 
		self:underline(),
		self:filter("description"),
		self:filter("name"),
		self:filter("version"),
		self:filter("author"),
		extends and ("* Extends: %s\n"):format(extends) or "",
		depends and ("* Depends on: %s\n"):format(depends) or "",
		self:sourceLink(),
		self:filter("fulldescription")
	)

	local docInternal = self:internal()
	if #docInternal == 1 and docInternal[1] == "" then
		text = text .. "\n***No function or property documentation for this script!***\n"
	else
		for i=1, #docInternal do
			Spindle.GitDoc.increment_objects()
			local current_doc = docInternal[i]
			if current_doc:sub(1,1) == "#" then
				text = text .. "\n\n`" .. current_doc:sub(2) .. "`\n"
			else
				local doc_head, doc_tail = split_doc_line(current_doc)
				local example = Spindle.cache.get("documentation.examples"):examples()[doc_head]
				if example then
					text = text .. "\n" .. ("###%s\n%s\n```lua%s\n```"):format(doc_head, doc_tail, example) .. "\n"
					Spindle.GitDoc.increment_examples()
				else
					text = text .. "\n" .. ("###%s\n%s\n"):format(doc_head, doc_tail) .. "\n"
				end
			end
		end
	end

	self:documentation(text)
end

function ExampleFile:parse()
	local examples, current_title, current_content = {}, nil, ""
	for line in self:raw():gmatch("(.-)\n") do
		if line:find("^%[") and line:find("%]$") then
			if current_title == nil then --[[ -- NOP - First Example ]] else
				examples[current_title] = current_content
				current_content = ""
			end
			current_title = line:sub(2, -2)
		else current_content = current_content .. "\n" .. line end
	end
	-- Last Example
	examples[current_title] = current_content
	self:examples(examples)
end

if Spindle.modules.loaded("type") then
	Spindle.type.isdocfile = function(object) return type(object) == "docfile" end
	Spindle.type.isexamplefile = function(object) return type(object) == "examplefile" end
end

Spindle.GitDoc = {
	init = function(header, file_path, file_prefix, base_url, examples, doc_path)
		Spindle.config.set("documentation.header", header)
		Spindle.config.set("documentation.file_path", file_path)
		Spindle.config.set("documentation.file_prefix", file_prefix)
		Spindle.config.set("documentation.base_url", base_url)
		Spindle.config.set("documentation.examples", examples)
		Spindle.config.set("documentation.doc_path", doc_path)
	end,
	run = function()
		Spindle.GitDoc.init_counters()
		Spindle.GitDoc.cache_examples()
		Spindle.GitDoc.cache_files()

		Spindle.debug(("Create documentation for %d files (%d examples cached)..."):format(
			#Spindle.cache.get("documentation.files"),
			Spindle.table.count(Spindle.cache.get("documentation.examples"):examples())
		))
		Spindle.GitDoc.read_files()
		Spindle.GitDoc.prepare_docs()
		Spindle.GitDoc.write_documentation()
		Spindle.GitDoc.write_readme()
	end,
	init_counters = function()
		Spindle.cache.set("documentation.counters.objects", 0)
		Spindle.cache.set("documentation.counters.examples", 0)
	end,
	increment_objects = function()
		Spindle.cache.set("documentation.counters.objects", Spindle.cache.get("documentation.counters.objects") + 1)
	end,
	increment_examples = function()
		Spindle.cache.set("documentation.counters.examples", Spindle.cache.get("documentation.counters.examples") + 1)
	end,
	cache_examples = function()
		local example_file = io.open(Spindle.config.get("documentation.examples"), "r")
		local examples = ExampleFile.new(example_file:read("*a"))
		example_file:close()
		examples:parse()
		Spindle.cache.set("documentation.examples", examples)
	end,
	cache_files = function()
		local doc = {}
		local files = Spindle.fileutils.readdir(Spindle.config.get("documentation.file_path"))
		for i, file in ipairs(files) do
			if file.type ~= "directory" and file.name:find(Spindle.config.get("documentation.file_prefix"), 1, true) then 
				doc[#doc + 1] = file.name
			end
		end
		Spindle.cache.set("documentation.files", doc)
	end,
	read_files = function()
		local files = Spindle.cache.get("documentation.files")
		for fi, file in ipairs(files) do
			local docfile = DocFile.new(Spindle.GitDoc.read_documentation_partial(file))
			docfile:path(Spindle.GitDoc.extract_doc_path(docfile:filter("docExternal")))
			docfile:source(file)
			docfile:docFile(Spindle.GitDoc.extract_doc_path(docfile:source()))
			docfile:sourceLink(("[%s](%s%s)"):format(file, Spindle.config.get("documentation.base_url"), file))
			Spindle.cache.set("documentation." .. file, docfile)
		end
	end,
	read_documentation_partial = function(file)
		local path = Spindle.config.get("documentation.file_path")
		if path ~= "." or not path:match("%/$") then file = path .. file end
		
		local input = io.open(file, "r")
		local content = input:read("*a")
		input:close()
		
		return content:sub(5, content:find("]]", 1, true) - 1)
	end,
	extract_doc_path = function(link)
		return link:match("doc/(.*)")
	end,
	prepare_docs = function()
		local files = Spindle.cache.get("documentation.files")
		for fi, file in ipairs(files) do
			local docfile = Spindle.cache.get("documentation." .. file)
			docfile:build()
			Spindle.cache.set("documentation." .. file, docfile)
		end
	end,
	write_documentation = function()
		local path = Spindle.config.get("documentation.doc_path")
		local files = Spindle.cache.get("documentation.files")
		for fi, file in ipairs(files) do
			local docfile = Spindle.cache.get("documentation." .. file)
			local target = path .. docfile:path()
			local outstream = io.open(target, "w")
			outstream:seek("set")
			outstream:write(docfile:documentation())
			outstream:close()
		end
	end,
	write_readme = function()
		local docs = {}
		local files = Spindle.cache.get("documentation.files")
		for fi, file in ipairs(files) do
			docs[#docs+1] = Spindle.cache.get("documentation." .. file)
		end

		local target = Spindle.config.get("documentation.doc_path") .. "README.md"
		local header = Spindle.config.get("documentation.header")
		local underline = ("="):rep(header:len())

		local f = io.open(target, "w")
		f:seek("set")
		
		f:write(header, "\n", underline, "\n")

		Spindle.GitDoc.write_readme_partial(f, "CORE", docs, "core")
		Spindle.GitDoc.write_readme_partial(f, "ENTRY-SCRIPTS", docs, "entry")
		Spindle.GitDoc.write_readme_partial(f, "MODULES", docs, "module")
		
		f:close()
	end,
	write_readme_partial = function(f, title, docs, _type)
		f:write(("\n###%s\n"):format(title))
		local cur = Spindle.table.select(docs, function(e) return e:filter("type") == _type end)
		for ci, e in pairs(cur) do
			f:write(("* [%s](%s) - %s"):format(e:filter("name"), e:path(), e:filter("description")), "\n")
		end
	end,
}