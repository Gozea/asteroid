local cpml = require("cpml")
local Shot = require("Shot")

local Player = {}
WIDTH, HEIGHT = love.graphics.getDimensions()

function Player:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.direction = cpml.vec2(0, -1)
    instance.size = 20
    instance.speed = 30
    instance.rotateSpeed = 0.1
    instance.maxSpeed = 150
    instance.width, instance.height = 5, 5
    instance.body = love.physics.newBody(World, WIDTH / 2, HEIGHT / 2, "dynamic")
    instance.shape = love.physics.newRectangleShape(20, 20)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    return instance
end

function Player:draw()
    local x, y = self.body:getPosition()
    love.graphics.polygon("line", x + self.size * self.direction.x, y + self.size * self.direction.y,
        x + (self.size / 2) * cpml.vec2.rotate(self.direction, 2.1).x,
        y + (self.size / 2) * cpml.vec2.rotate(self.direction, 2.1).y,
        x + (self.size / 2) * cpml.vec2.rotate(self.direction, 4.2).x,
        y + (self.size / 2) * cpml.vec2.rotate(self.direction, 4.2).y)
end

function Player:move()
    local moves = {
        ["right"] = function() self.direction = cpml.vec2.rotate(self.direction, self.rotateSpeed) end,
        ["left"] = function() self.direction = cpml.vec2.rotate(self.direction, -self.rotateSpeed) end,
        --["down"] = function() self.acceleration.y = self.speed end,
        ["up"] = function() self.body:applyForce(self.direction.x * self.speed, self.direction.y * self.speed) end,
        ["space"] = function() self:shoot() end,
    }

    for move, action in pairs(moves) do
        if love.keyboard.isDown(move) then
            action()
        end
    end
end

function Player:shoot()
    if love.keyboard.isDown("space") then
        local x, y = self.body:getPosition()
        local shotPosition = cpml.vec2(x + self.direction.x * 20, y + self.direction.y * 20)
        local shot = Shot:new(shotPosition)
        table.insert(shots, shot)
        shot:launch(self.direction, 80)
    end
end

return Player
