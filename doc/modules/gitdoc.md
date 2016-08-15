Spindle.GitDoc
--------------
Git Documentation Module

* Shortname: GitDoc
* Version: 1.0
* Author: Kagu-chan
* Depends on: [Spindle.Cache](../modules/cache.md), [Spindle.Config](../modules/config.md), [Spindle.OOP](../modules/oop.md), [Spindle.Table](../modules/table.md), [Spindle.Text](../modules/text.md), [Spindle.Fileutils](../modules/fileutils.md)
* Source: [aegi-spindle-git_doc.lua](https://github.com/Kagurame/AegiSpindle/tree/beta/src/aegi-spindle-git_doc.lua)

> This Script will create a github conform documentation of given src directory

###DocFile
DocFile Object


###DocFile.new(string raw)
Creates a new Instance of DocFile
```lua
local docfile = DocFile.new("...")
```

###DocFile.fromtable(table t)
Creates a new Instance from given table
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
```

###DocFile:raw([string raw])
Sets or gets raw value of instance
```lua
local docfile = DocFile.new("...")
docfile:raw("xxx")
docfile:raw() -- "xxx"
```

###DocFile:path([string path])
Sets or gets path value of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:path("xxx")
docfile:path() -- "xxx"
```

###DocFile:source([string source])
Sets or gets source value of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:source("xxx")
docfile:source() -- "xxx"
```

###DocFile:docFile([string docFile])
Sets or gets docFile value of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:docFile("xxx")
docfile:docFile() -- "xxx"
```

###DocFile:sourceLink([string sourceLink])
Sets or gets sourceLink value of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:sourceLink("xxx")
docfile:sourceLink() -- "xxx"
```

###DocFile:documentation([string documentation])
Sets or gets documentation value of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:documentation("xxx")
docfile:documentation() -- "xxx"
```

###DocFile:totable()
Returns table representation of instance
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:totable() -- {raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", }
```

###DocFile:filter(string key)
Filter out a key value pair and returns the value
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:filter("name") -- The name from documentation header
```

###DocFile:underline()
Returns a '-'-string with the same length as fullname value
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:underline() -- if the name is "hello", the result is "-----"
```

###DocFile:internal()
Returns the internal documentation as table
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:internal() -- The docInternal parsed as table
```

###DocFile:filterReferences(string literal)
Returns a link list of references
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:filterReferences() -- "Cache,Config" will return "[Spindle.Cache](../modules/cache.md), [Spindle.Config](../modules/config.md)"
```

###DocFile:build()
Generate the documentation-string
```lua
local docfile = DocFile.fromtable({raw="...", path="...", source="...", docFile="...", sourceLink="...", documentation="...", })
docfile:build() -- Generates the whole documentation file for the current instance
```

###ExampleFile
ExampleFile Object


###ExampleFile.new(string raw)
Creates a new Instance of ExampleFile
```lua
local examplefile = ExampleFile.new("...")
```

###ExampleFile.fromtable(table t)
Creates a new Instance from given table
```lua
local examplefile = ExampleFile.fromtable({raw="..."})
```

###ExampleFile:raw([string raw])
Sets or gets raw value of instance
```lua
local examplefile = ExampleFile.new("...")
examplefile:raw("xxx")
examplefile:raw() -- "xxx"
```

###ExampleFile:examples([table examples])
Sets or gets examples value of instance
```lua
local examplefile = ExampleFile.new("...")
examplefile:examples({"[ExampleFile.new(string raw)]"="local examplefile = ExampleFile.new(\"...\")"})
```

###ExampleFile:parse()
Parse the raw into a table of examples
```lua
local examplefile = ExampleFile.new("...")
examplefile:parse() -- {"[ExampleFile.new(string raw)]"="local examplefile = ExampleFile.new(\"...\")"}
```

###Spindle.GitDoc.init(string header, string file_path, string file_prefix, string base_url, string examples, string doc_path)
Initialize the documentation procress
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
```

###Spindle.GitDoc.run()
Run the documentation process
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.run() -- parse the whole documentation
```

###Spindle.GitDoc.init_counters()
Initialize the counter values with 0
```lua
Spindle.GitDoc.init_counters()
Spindle.cache.get("documentation.counters.objects") -- 0
Spindle.cache.get("documentation.counters.examples") -- 0
```

###Spindle.GitDoc.increment_objects()
Increment the objects counter by 1
```lua
Spindle.GitDoc.init_counters()
Spindle.GitDoc.increment_objects()
Spindle.cache.get("documentation.counters.objects") -- 1
```

###Spindle.GitDoc.increment_examples()
Increment the examples counter by 1
```lua
Spindle.GitDoc.init_counters()
Spindle.GitDoc.increment_examples()
Spindle.cache.get("documentation.counters.examples") -- 1
```

###Spindle.GitDoc.cache_examples()
Parse and cache the examples as ExampleFile
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.cache_examples()
```

###Spindle.GitDoc.cache_files()
Cache the sourcecode files
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.cache_files()
```

###Spindle.GitDoc.read_files()
Parse and Cache the sourcecode files as DocFile instances
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.read_files()
```

###Spindle.GitDoc.read_documentation_partial(string file)
Filter out the documentation from sourcecode file
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.init_counters()
Spindle.GitDoc.cache_examples()
Spindle.GitDoc.cache_files()
Spindle.GitDoc.read_documentation_partial("aegi-spindle-git_doc")
```

###Spindle.GitDoc.extract_doc_path(link)
Extract the documentation path relative to the documentation directory from a link
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.extract_doc_path("doc/modules/gitdoc.md") -- modules/gitdoc.md
```

###Spindle.GitDoc.prepare_docs()
Build the cached DocFiles
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.init_counters()
Spindle.GitDoc.cache_examples()
Spindle.GitDoc.cache_files()
Spindle.GitDoc.read_files()
Spindle.GitDoc.prepare_docs()
```

###Spindle.GitDoc.write_documentation()
Write the DocFiles parsed in a respective file
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.init_counters()
Spindle.GitDoc.cache_examples()
Spindle.GitDoc.cache_files()
Spindle.GitDoc.read_files()
Spindle.GitDoc.prepare_docs()
Spindle.GitDoc.write_documentation()
```

###Spindle.GitDoc.write_readme()
Write the mainpage of documentation
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.cache_files()
Spindle.GitDoc.write_readme()
```

###Spindle.GitDoc.write_readme_partial(file f, string title, table docs, string _type)
Write a doc list in the mainpage of documentation
```lua
Spindle.GitDoc.init(
	"AegiSpindle Documentation", 
	"../src/",
	"aegi-spindle", 
	"https://github.com/Kagurame/AegiSpindle/tree/dev/src/",
	"../doc/examples",
	"../doc/"
)
Spindle.GitDoc.write_readme_partial(io.open("test", "w+", "Documentation", {}, "core")
```


`only if module "type" is loaded:`

###Spindle.type.isdocfile(mixed object)
Returns is object is a docfile type
```lua
if Spindle.type.isdocfile(object) then ... end
```

###Spindle.type.isexamplefile(mixed object)
Returns is object is a examplefile type
```lua
if Spindle.type.isexamplefile(object) then ... end
```
