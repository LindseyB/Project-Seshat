require "animated_sprite"

Robot = {}
Robot.__index = Robot

function Robot:create()
	local object = {}

	setmetatable(object, Robot)

	object.x = 200
	object.y = love.graphics.getHeight() - 96 - 25
	object.speed = 120
	object.animation = AnimatedSprite:create("sprites/spin_drive_sprite_96x96.png", 96, 96, 8, 3)
	object.width = object.animation.width
	object.height = object.animation.height

	object.Directions = {
		["Down"] = 1,
		["Left"] = 3,
		["Right"] = 2,
		["Up"] = 1
	}

	object.animation:set_animation(false)

	return object
end

function Robot:load()
	self.animation:load()
end

function Robot:move(direction, dt)
	self.animation:set_animation_direction(self.animation.Directions.Left)
end

function Robot:draw()
	self.animation:draw(self.x, self.y)
end

function Robot:update(dt)
	self.animation:update(dt)
end