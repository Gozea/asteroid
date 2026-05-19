local cpml = require("cpml")

Player = {}
WIDTH, HEIGHT = love.graphics.getDimensions()

function Player:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.position = cpml.vec2(WIDTH/2, HEIGHT/2)
    instance.velocity = cpml.vec2(0, 0)
    instance.acceleration = cpml.vec2(0, 0)
    instance.speed = 30
    instance.maxSpeed = 150
    instance.width, instance.height = 5, 5
    return instance
end

function Player:draw()
    love.graphics.rectangle("line", self.position.x, self.position.y, self.width, self.height)
end

function Player:move()
    local moves = {
        ["right"] = function() self.acceleration.x = self.speed end,
        ["left"] = function() self.acceleration.x = -self.speed end,
        ["down"] = function() self.acceleration.y = self.speed end,
        ["up"] = function() self.acceleration.y = -self.speed end,
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
