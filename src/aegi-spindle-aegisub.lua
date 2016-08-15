--[[
name:Aegisub
fullname:Spindle.Aegisub
description:Aegisub Main Module (Entry Script)
fulldescription:This script is used for Aegisub as entry script.
extends:
depends:Loader
author:Kagu-chan
version:1.0
type:entry
docExternal:https://github.com/Kagurame/AegiSpindle/tree/master/doc/core/aegisub.md
docInternal:
	
]]

require("aegi-spindle-modules")

-- Set global functions and objects to local cache for performance
local Spindle = _G.Spindle or {}
local aegisub = _G.aegisub or {}

Spindle.modules.trace = false
Spindle.modules.requireAegisub()
Spindle.modules.load("loader")

Spindle.initialize()
Spindle.initializeAegisub()

local tr = aegisub.gettext
script_name = tr"Aegi Spindle"
script_description = tr"Aegi-Spindle Subtitles Library Collection"
script_author = "Kagu-chan"
script_version = "1"