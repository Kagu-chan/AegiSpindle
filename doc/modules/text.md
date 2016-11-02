Spindle.Text
------------
Text- and String-Functions

* Shortname: Text
* Version: 1.0
* Author: Kagu-chan
* Source: [aegi-spindle-text.lua](https://github.com/Kagurame/AegiSpindle/tree/dev/src/aegi-spindle-text.lua)

> This module provides some functions for working with texts.

###Spindle.text.trim(string s)
Remove leading and following white spaces from s
```lua
local s = "     Hello   "
local ns = Spindle.text.trim(s) -- Will return "Hello"
```

###Spindle.text.headtails(string s)
Returns first word and following text seperately from text
```lua
local t = "Example I am an example"
local head, tail = Spindle.text.headtails(t) -- head is "Example", tail is "I am an example"
```

###Spindle.text.words(string s)
Iterator function for texts words
```lua
for w in Spindle.text.words("Hello World, how are you?") do
	Spindle.debug(w)
end
```

###Spindle.text.wordtable(string s)
Returns texts words as table
```lua
local words_table = Spindle.text.wordtable("Hello World, how are you?")
```

###Spindle.text.split(string s[, string seperator])
Split string by seperator into a table. If no seperator is given, seperator is `:'
```lua
local strings = {"Hello,world,how,are,you", "1:34:test:a_string"}
local t1 = Spindle.text.split(t[1], ",") -- {"Hello", "world", "how", "are", "you"}
local t2 = Spindle.text.split(t[2]) -- {"1", "34", "test", "a_string"}
```

###Spindle.text.len(string s)
Returns strings length
```lua
local len = Spindle.text.len("Hello World, how are you?")
```

###Spindle.text.buildWrapper()
Wrapper function for core application

