Background = {}
Background.__index = Background

function Background:create()
	local object = {}
	setmetatable(object, Background)

	object.x = 0
	object.image = love.graphics.newImage("sprites/background.png")
	object.width = object.image:getWidth()

	object.Directions = {
		["Left"] = 1,
		["Right"] = 2,
	}

	return object
end

function Background:move(direction)
	if direction == self.Directions.Left then
		self.x = self.x + 1
		if self.x >= self.width then self.x = 0 end
	else
		self.x = self.x - 1
		if self.x <= (-1 * self.width) then self.x = 0 end
	end
end

function Background:draw()
	love.graphics.draw(self.image, self.x - self.width, 0)
	love.graphics.draw(self.image, self.x, 0)
	love.graphics.draw(self.image, self.x + self.width, 0)
end