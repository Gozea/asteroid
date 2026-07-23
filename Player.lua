local cpml = require("cpml")

local config = require("config")
local Shot = require("Shot")


local reload_shader = love.graphics.newShader("assets/shaders/player_reload.glsl")

local Player = {}
WIDTH, HEIGHT = love.graphics.getDimensions()

function Player:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.direction = cpml.vec2(0, -1)
    instance.speed = config.player_speed
    instance.rotateSpeed = config.player_rotate_speed
    instance.cooldown = config.player_cooldown
    instance.canShoot = true
    instance.body = love.physics.newBody(World, WIDTH / 2, HEIGHT / 2, "dynamic")
    instance.shape = love.physics.newRectangleShape(config.player_shape_size, config.player_shape_size)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setCategory(config.player_mask)
    return instance
end

function Player:draw()
    local x, y = self.body:getPosition()
    if not self.canShoot then
        love.graphics.setShader(reload_shader)
        reload_shader:send("time", love.timer.getTime())
    end
    love.graphics.polygon(
        "line",
        x + config.player_shape_size * self.direction.x, y + config.player_shape_size * self.direction.y,
        x + (config.player_shape_size / 2) * cpml.vec2.rotate(self.direction, 2.1).x, y + (config.player_shape_size / 2) * cpml.vec2.rotate(self.direction, 2.1).y,
        x + (config.player_shape_size / 2) * cpml.vec2.rotate(self.direction, 4.2).x, y + (config.player_shape_size / 2) * cpml.vec2.rotate(self.direction, 4.2).y
    )
    love.graphics.setShader()
end

function Player:move(dt)
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

    -- reload shot
    if self.canShoot == false then
        self.cooldown = self.cooldown - dt
    end

    if self.cooldown <= 0 then
        self.cooldown = config.player_cooldown
        self.canShoot = true
    end
end

function Player:shoot()
    if love.keyboard.isDown("space") and self.canShoot then
        local x, y = self.body:getPosition()
        local shotPosition = cpml.vec2(x + self.direction.x * 20, y + self.direction.y * 20)
        local shot = Shot:new(shotPosition)
        table.insert(shots, shot)
        shot:launch(self.direction, config.shot_impulse)
        self.canShoot = false
    end
end

return Player
