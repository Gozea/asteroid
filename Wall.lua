local cpml = require("cpml")
local Wall = require("Bounceable")

function Wall:new(v1, v2)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.a, instance.b = v1, v2
    instance.vector = instance.b - instance.a
    return instance
end
