-- Only an implementation. The bounce check and the collision behaviour depends entirely on the geometry
Bounceable = {}

function Bounceable:new()
    local entity = {}
    setmetatable(entity, self)
    self.__index = self
    return entity
end

function Bounceable:checkCollision(e)
    error("Error : checkCollision not implemented for current instance")
end

function Bounceable:bounce(e)
    error("Error : bounce not implemented for current instance")
end

function Bounceable:collision(e)
    if self:checkCollision(e) then
        self:bounce(e)
    end
end

return Bounceable
