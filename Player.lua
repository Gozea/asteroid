local cpml = require("cpml")

local Player = {}
WIDTH, HEIGHT = love.graphics.getDimensions()

function Player:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.position = cpml.vec2(WIDTH/2, HEIGHT/2)
    instance.velocity = cpml.vec2(0, 0)
    instance.acceleration = cpml.vec2(0, 0)
    instance.direction = cpml.vec2(0, -1)
    instance.size = 20
    instance.speed = 30
    instance.rotateSpeed = 0.1
    instance.maxSpeed = 150
    instance.width, instance.height = 5, 5
    return instance
end

function Player:draw()
    --love.graphics.rectangle("line", self.position.x, self.position.y, self.width, self.height)
    love.graphics.polygon("line", self.position.x + self.size*self.direction.x, self.position.y + self.size*self.direction.y, self.position.x + (self.size/2)*cpml.vec2.rotate(self.direction, 2.1).x, self.position.y + (self.size/2)*cpml.vec2.rotate(self.direction, 2.1).y, self.position.x + (self.size/2)*cpml.vec2.rotate(self.direction, 4.2).x, self.position.y + (self.size/2)*cpml.vec2.rotate(self.direction, 4.2).y)
end

function Player:move()
    local moves = {
        ["right"] = function() self.direction = cpml.vec2.rotate(self.direction, self.rotateSpeed) end,
        ["left"] = function() self.direction = cpml.vec2.rotate(self.direction, -self.rotateSpeed) end,
        --["down"] = function() self.acceleration.y = self.speed end,
        ["up"] = function() self.acceleration = self.direction*self.speed end,
    }

    self.acceleration = cpml.vec2(0, 0)

    for move, action in pairs(moves) do
        if love.keyboard.isDown(move) then
            action()
        end
    end
end

function Player:update(dt)
    self.velocity.x, self.velocity.y = self.velocity.x + self.acceleration.x * dt, self.velocity.y + self.acceleration.y * dt
    if self.velocity.x > self.maxSpeed then self.velocity.x = self.maxSpeed end
    if self.velocity.y > self.maxSpeed then self.velocity.y = self.maxSpeed end
    self.position.x, self.position.y = self.position.x + self.velocity.x * dt, self.position.y + self.velocity.y * dt
end

return Player
