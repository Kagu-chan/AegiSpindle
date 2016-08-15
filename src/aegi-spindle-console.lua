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
docExternal:https://github.com/Kagurame/AegiSpindle/tree/beta/doc/core/console.md
docInternal:
	
]]

package.path = ("%s%s?.lua;"):format(package.path, debug.getinfo(1, "S").source:sub(2):match("(.*\\)"))

require("aegi-spindle-modules")

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}

Spindle.modules.trace = false
Spindle.modules.load("loader")

Spindle.initialize(false)