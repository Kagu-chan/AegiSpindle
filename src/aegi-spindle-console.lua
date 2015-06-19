require("aegi-spindle-modules")

Spindle.modules.trace = false

Spindle.modules.load("type")
Spindle.modules.load("config")
Spindle.modules.load("cache")
Spindle.modules.load("table")
Spindle.modules.load("text")
Spindle.modules.load("utf8")
Spindle.modules.load("math")
Spindle.modules.load("oop")
Spindle.modules.load("vectors")
Spindle.modules.load("math_vectors")
Spindle.modules.load("ffi")

Spindle.generateWrapper()