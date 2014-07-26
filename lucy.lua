require "animated_sprite"
require "background"
require "collision"


Lucy = {}
Lucy.__index = Lucy

function Lucy:create()
	local object = {}

	setmetatable(object, Lucy)

	object.x = 100
	-- window height - sprite height - some padding
	object.y = love.graphics.getHeight() - 96 - 25
 	object.absolutex = 0
	object.speed = 120
	object.animation = AnimatedSprite:create("sprites/protag_walking_sprite_96x96.png", 96, 96, 8, 2)
	object.width = object.animation.width
	object.height = object.animation.height
	object.windowPadding = 100					-- distance away from edge of window
	object.background = Background:create()

	object.Directions = {
		["Down"] = 1,
		["Left"] = 2,
		["Right"] = 1,
		["Up"] = 1
	}

	return object
end

function Lucy:load()
	self.animation:load()
end

function Lucy:reset()
	self.x = 300
	self.y = love.graphics.getHeight()-96
	self.absolutex = 0
end

function Lucy:move(direction, dt, objects)
	original_x = self.x
	collide = false

	if direction == self.Directions.Left then
		self.x = self.x - self.speed * dt
		self.absolutex = self.absolutex - self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Left)
		self.background:move(self.background.Directions.Left)

		collide = colliding(self, objects)

		if not collide then
			if self.x < self.windowPadding then
				self.background:move(self.background.Directions.Left, 2)
			else
				self.background:move(self.background.Directions.Left)
			end
		end
	end

	if direction == self.Directions.Right then
		self.x = self.x + self.speed * dt
		self.absolutex = self.absolutex + self.speed * dt
		self.animation:set_animation_direction(self.animation.Directions.Right)

		collide = colliding(self, objects)

		if not colliding then
			if self.x > love.graphics.getWidth() - self.width - self.windowPadding then
				self.background:move(self.background.Directions.Right, 2)
			else
				self.background:move(self.background.Directions.Right)
			end
		end
	end

	-- keep the self on the screen
	if self.x > love.graphics.getWidth() - self.width - self.windowPadding then self.x = love.graphics.getWidth() - self.width - self.windowPadding end
	if self.x < self.windowPadding then self.x = self.windowPadding end

	if self.y > love.graphics.getHeight() - self.height then self.y = love.graphics.getHeight() - self.height end
	if self.y < 0 then self.y = 0 end

	-- handle collisions
	if collide then
		self.x = original_x
	end
end

function Lucy:stop()
	self.animation:set_animation(false)
end

function Lucy:draw()
	self.background:draw()
	self.animation:draw(self.x, self.y)
end

function Lucy:update(dt)
	self.animation:update(dt)
end