require("aegi-spindle-modules")

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