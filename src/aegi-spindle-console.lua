--[[
name:Console
fullname:Spindle.Console
description:Console Main Module (Entry Script)
fulldescription:This script is used for usage as console script.
extends:
depends:Loader
author:Kagu-chan
version:1.0
type:entry
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/core/console.md
docInternal:
	
]]

require("aegi-spindle-modules")

Spindle.modules.trace = false
Spindle.modules.load("loader")

Spindle.initialize(false)