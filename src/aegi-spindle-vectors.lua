Spindle.vectors = {}
Spindle.modules.require("oop")

Spindle.oop.generateClass("Vector2D", {}, {}, {x = "number", y = "number"}, "x", "y")
Spindle.oop.generateClass("Vector3D", {}, {}, {x = "number", y = "number", z = "number"}, "x", "y", "z")

function Vector2D:distance()
	return math.sqrt(self:x() * self:x() + self:y() * self:y())
end
function Vector2D:to3d()
	return Vector3D.new(self:x(), self:y(), 0)
end

function Vector3D:distance()
	return math.sqrt(self:x() * self:x() + self:y() * self:y() + self:z() * self:z())
end
function Vector3D:to2d()
	return Vector2D.new(self:x(), self:y())
end

if Spindle.modules.loaded("type") then
	Spindle.type.isvector2d = function(object) return type(object) == "vector2d" end
	Spindle.type.isvector3d = function(object) return type(object) == "vector3d" end
end