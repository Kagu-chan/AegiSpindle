AegiSpindle
===========

## Table of contents
1. [What is AegiSpindle]
   1. [Overview and versioning]
   2. [Intendation]
   3. [Environment and general principles]
   4. [AegiSpindle and CLI]
   5. [AegiSpindle and Aegisub]
2. [How to use AegiSpindle]
   1. [Documentation]
   2. [Compatibility]
   2. [Examples]
   3. [Changelog]
3. [Contributing]
   1. [Projects based on AegiSpindle]
   2. [Become a contributor]
   3. [Something went wrong? Any ideas?]
4. [Reference]
5. [License]

## What is AegiSpindle
### Overview and versioning
AegiSpindle is a lua written library mainly for text manipulation.
It comes with an integrated ASS-Parser [1] as also an integrated
vectoring engine.

What makes AegiSpindle more special may be the fact that it supports
the usage as CLI script and as plugin for Aegisub [2].  

| Release   | Current   |
| ----------|-----------|
| **STABLE**| *not yet* |
| **DEV**   | `0.0.0`   |

Please [REQUIREMENTS](deps)

### Intendation
Searching for subtitle libraries supporting ASS is not that hard.
Also we'll find tons of plugins for Aegisub itself.

The problem is, that not one of them can be used on command line
and Aegisub itself. So we have no tool to just interprete an ASS
script and do more special stuff with it. Other tools such as NyuFX [3]
are hard to extend or - in case of Yutils [4] (and NyuFX as well) - not
longer supported.

### Environment and general principles
AegiSpindle is in general just a set of modules. They may depend one on
one or more other modules.

We differ between three types of modules:
* Core
* Entry script
* General module

A module is named by a vendor name (`Spindle` in case of the main
development stream) and an unique module name (e.g. `Table` or `Text`)

AegiSpindle is based on LuaJIT [5], but without the specific FFI [6]
modules the library can be used as common lua library. 

### AegiSpindle and CLI
AegiSpindle comes with a cli command line loader script. With this
AegiSpindle can be used in a pure cli environment.

### AegiSpindle and Aegisub
AegiSpindlealso has an own Aegisub loader script, which controls some
switches under the hood and ensure the Aegisub environment itself. With
this it can be used as base for Aegisub plugins.

## How to use AegiSpindle
### Documentation
The library is completely documented [here](doc/README.md).
Most of documentation is additionally available in the header of each
script.

The header and [the exmaples file](doc/examples) is used by the
[Spindle.GitDoc module](doc/modules/gitdoc.md) to generate the whole
documentation.

### Compatibility
##### OS-Compatibility

| Module   | Windows   | Linux   | OSX   |
| ---------|-----------|---------|-------|
| Spindle.Cache | Yes | Yes | Yes |
| Spindle.CMD | Yes | *Not tested* | Yes |
| Spindle.Config | Yes | Yes | Yes |
| Spindle.FFI | Yes | *Not tested* | Yes |
| Spindle.Fileutils | Yes | **No** | **No** |
| Spindle.GitDoc | Yes | **No** | **No** |
| Spindle.Loader | Yes | Yes | Yes |
| Spindle.Math | Yes | Yes | Yes |
| Spindle.Math-Vectors | Yes | Yes | Yes |
| Spindle.Matrix | Yes | Yes | Yes |
| Spindle.OOP | Yes | Yes | Yes |
| Spindle.Shape | Yes | Yes | Yes |
| Spindle.Table | Yes | Yes | Yes |
| Spindle.Text | Yes | Yes | Yes |
| Spindle.Type | Yes | Yes | Yes |
| Spindle.UTF8 | Yes | Yes | Yes |
| Spindle.UTF8-FFI | Yes | **No** | **No** |
| Spindle.Vectors | Yes | Yes | Yes |

##### Environment-Compatibility

| Module   | CLI   | Aegisub   |
| ---------|-------|-----------|
| Spindle.Cache | Yes | *Not tested* | 
| Spindle.CMD | Yes | *Not tested* | 
| Spindle.Config | Yes | *Not tested* | 
| Spindle.FFI | Yes | *Not tested* | 
| Spindle.Fileutils | Yes | *Not tested* | 
| Spindle.GitDoc | Yes | *Not tested* | 
| Spindle.Loader | Yes | *Not tested* | 
| Spindle.Math | Yes | *Not tested* | 
| Spindle.Math-Vectors | Yes | *Not tested* | 
| Spindle.Matrix | Yes | *Not tested* | 
| Spindle.OOP | Yes | *Not tested* | 
| Spindle.Shape | Yes | *Not tested* | 
| Spindle.Table | Yes | *Not tested* | 
| Spindle.Text | Yes | *Not tested* | 
| Spindle.Type | Yes | *Not tested* | 
| Spindle.UTF8 | Yes | *Not tested* | 
| Spindle.UTF8-FFI | Yes | *Not tested* | 
| Spindle.Vectors | Yes | *Not tested* | 

##### Lua-Compatibility

| Module   | LuaJIT   | Lua   |
| ---------|----------|-------|
| Spindle.Cache | Yes | *Not tested* | 
| Spindle.CMD | Yes | *Not tested* | 
| Spindle.Config | Yes | *Not tested* | 
| Spindle.FFI | Yes | **No** | 
| Spindle.Fileutils | Yes | **No** | 
| Spindle.GitDoc | Yes | **No** | 
| Spindle.Loader | Yes | *Not tested* | 
| Spindle.Math | Yes | *Not tested* | 
| Spindle.Math-Vectors | Yes | *Not tested* | 
| Spindle.Matrix | Yes | *Not tested* | 
| Spindle.OOP | Yes | *Not tested* | 
| Spindle.Shape | Yes | *Not tested* | 
| Spindle.Table | Yes | *Not tested* | 
| Spindle.Text | Yes | *Not tested* | 
| Spindle.Type | Yes | *Not tested* | 
| Spindle.UTF8 | Yes | *Not tested* | 
| Spindle.UTF8-FFI | Yes | **No** | 
| Spindle.Vectors | Yes | *Not tested* | 

### Examples
Examples for specific functions and modules can be found in the regarding
[documentation](doc/README.md)

*-- TODO: Add a directory with more specific examples*

### Changelog
*-- TODO: We need a changelog...*

## Contributing
### Projects based on AegiSpindle
Currently there no projects based on AegiSpindle :(

### Become a contributor
AegiSpindle allow direct support for projects using this library. This means advertising of this projects and code support if required.

#### How does it works?

It is the main goal to make creating karaoke effects and typesets easier and consistent. This means code, library usage and results. Not everyone have to code the same functions and not everyone does have time or ability to understand how lua works exactly.

If you want to use this library, this would make me happy, and so I decided to support it additionally here with some help. To get your project supported, just follow the rules:

* Your project must be written in LUA and compatible to luajit
* Your project must be hosted and up to date on github
* Your project must extend AegiSpindle
* Your project must keep dependencies as less as possible
* Your project must not change any main functionality of AegiSpindle
* You have to write clean code
* If your project not ready to use and is in development, this is not a problem.

If this applies, I will provide my help:

* Listing (and advertising) your project
* Keep the main functionality updated
* If I change something of the API, I'll try to inform you to change your code OR change your code by myself and send a pull request
* Try to help finding bugs or weird code and help to fix them

If you want this help, 

* Host your project
* Create an issue ticket and provide following information:
  * Description
  * One lined description for list page
  * Github-Link

### Something went wrong? Any ideas?
If you find an issue in my code or want to share some useful additions for the library, please feel free to fork this project, commit your changes and send a pull request. Otherwise you count submit a new [issue](issues)

If it is doable and if it fits the library and coding style maybe it will get included.

Please post your issue if you need some help or post your idea if I should add something useful.

## Reference
* [Lua: http://www.lua.org](http://www.lua.org)
* [NyuFX: https://github.com/Youka/NyuFX](https://github.com/Youka/NyuFX)
* [Yutils: https://github.com/Youka/Yutils](https://github.com/Youka/Yutils)
* [AviSynth: http://avisynth.nl](http://avisynth.nl)
* [FXSpindle: https://github.com/Kagurame/FXSpindle](https://github.com/Kagurame/FXSpindle)
* [KaraokeFX on Dropbox: http://goo.gl/DXe7Sd](http://goo.gl/DXe7Sd)

[1]: https://en.wikipedia.org/wiki/SubStation_Alpha#Advanced_SubStation_Alpha
[2]: http://www.Aegisub.org
[3]: https://github.com/Youka/NyuFX
[4]: https://github.com/Youka/Yutils/
[5]: http://luajit.org
[6]: http://luajit.org/ext_ffi.html

[What is AegiSpindle]: #what-is-aegispindle
[Overview and versioning]: #overview-and-versioning
[Intendation]: #intendation
[Environment and general principles]: #environment-and-general-principles
[AegiSpindle and CLI]: #aegispindle-and-cli
[AegiSpindle and Aegisub]: #aegispindle-and-Aegisub
[How to use AegiSpindle]: #how-to-use-aegispindle
[Documentation]: #documentation
[Compatibility]: #compatibility
[Examples]: #examples
[Changelog]: #changelog
[Contributing]: #contributing
[Projects based on AegiSpindle]: #projects-bases-on-aegispindle
[Become a contributor]: #become-a-contributor
[Something went wrong? Any ideas?]: #something-went-wrong-any-ideas
[Reference]: #reference
[LICENSE]: LICENSE