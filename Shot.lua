local config = require("config")
local Shot = {}

function Shot:new(position)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.body = love.physics.newBody(World, position.x, position.y, "dynamic")
    instance.shape = love.physics.newCircleShape(4)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setCategory(config.shot_mask)
    instance.fixture:setMask(config.player_mask)
    instance.fixture:setMask(config.shot_mask)
    instance.fixture:setMask(config.wall_mask)
    return instance
end

function Shot:launch(direction, speed)
    self.body:applyLinearImpulse(direction.x*speed, direction.y*speed)
end

function Shot:draw()
    local x, y = self.body:getPosition()
    love.graphics.circle("fill", x, y, 4)
end

return Shot
