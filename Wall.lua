require("math")
local cpml = require("cpml")
local Wall = require("Bounceable")

function Wall:new(v1, v2)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.a, instance.b = v1, v2
    instance.vector = instance.b - instance.a
    instance.normal = cpml.vec2.normalize(cpml.vec2(-instance.vector.y, instance.vector.x))
    instance.thickness = 50
    return instance
end

-- true if player is between the wall pixels and its thickness
function Wall:checkCollision(e)
    t = cpml.vec2.dot(self.vector, e.position-self.a)/cpml.vec2.len2(self.vector) -- t parameter, formula uses null dot product of normal vectors
    closestPoint = self.a + self.vector*t
    return cpml.vec2.dist(closestPoint,e.position) <= self.thickness
end

function Wall:bounce(e)
    e.velocity = e.velocity - self.normal*(2*cpml.vec2.dot(e.velocity, self.normal))
end

return Wall
