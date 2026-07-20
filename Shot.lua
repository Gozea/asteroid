local Shot = {}

function Shot:new(position)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.body = love.physics.newBody(World, position.x, position.y, "dynamic")
    instance.shape = love.physics.newCircleShape(4)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
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
