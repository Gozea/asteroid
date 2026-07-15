local cpml = require("cpml")

local Asteroid = {}

function Asteroid:new(x, y, vx, vy, r)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    self.x, self.y = x, y
    self.vx, self.vy = vx, vy
    self.r = r
end

function Asteroid:draw()
    love.graphics.circle("line", self.x, self.y, self.r)
end
