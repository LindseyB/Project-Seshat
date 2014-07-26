require "puzzle"
require "lucy"
require "robot"

function love.load()
	--puzzle = Puzzle.create()
	--puzzle:load()
	lucy = Lucy.create()
	lucy:load()
	robot = Robot.create()
	robot:load()
end

function love.update(dt)
	lucy:update(dt)
	robot:update(dt)

	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		lucy:move(lucy.Directions.Left, dt, robot)
	elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		lucy:move(lucy.Directions.Right, dt, robot)
	elseif love.keyboard.isDown("q") then
		love.event.push('quit')
	elseif love.keyboard.isDown("return") and game_over then
		--resetGame()
	else
		lucy:stop()
	end

end

function love.draw()
	--puzzle:draw()

	lucy:draw()
	robot:draw()
end

function love.mousepressed(x, y, button)
	--puzzle:mousepressed(x, y, button)
end

