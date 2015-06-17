dofile("aegi-spindle-modules")

Spindle.modules.trace = false
Spindle.modules.requireAegisub()

Spindle.modules.load("config")
Spindle.modules.load("cache")
Spindle.modules.load("table")
Spindle.modules.load("text")
Spindle.modules.load("utf8")

Spindle.modules.require("auto4-base")
Spindle.auto4.registerScripts()

local tr = aegisub.gettext
script_name = tr"Aegi Spindle"
script_description = tr"Aegi-Spindle Subtitles Library Collection"
script_author = "Kagu-chan"
script_version = "1"







-- wenn auto4 modul geladen ist, per init oder so automatisch alle modules nach einer auto4_init() durchsuchen. 
-- diese registrieren dann die skripte für aegisub