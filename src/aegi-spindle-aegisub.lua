dofile("aegi-spindle-modules")

Spindle.modules.trace = false
Spindle.modules.requireAegisub()

Spindle.modules.load("config")
Spindle.modules.load("cache")
Spindle.modules.load("table")
Spindle.modules.load("text")
Spindle.modules.load("utf8")

Spindle.initializeAegisub()

local tr = aegisub.gettext
script_name = tr"Aegi Spindle"
script_description = tr"Aegi-Spindle Subtitles Library Collection"
script_author = "Kagu-chan"
script_version = "1"