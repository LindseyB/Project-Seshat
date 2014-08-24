require "puzzle"
require "lucy"
require "robot"
require "collision"

function love.load()
	puzzle_mode = false
	lucy = Lucy.create()
	lucy:load()
	robot = Robot.create()
	robot:load()
end

function love.update(dt)
	if not puzzle_mode then
		lucy:update(dt)
		robot:update(dt)
	elseif puzzle:win() then
		puzzle_mode = false
		puzzle = nil
		robot:revive()
		-- TODO: revive the "fixed" robot and have it follow the main character
	end

	if (love.keyboard.isDown("left") or love.keyboard.isDown("a")) and not puzzle_mode then
		lucy:move(lucy.Directions.Left, dt, robot)
	elseif (love.keyboard.isDown("right") or love.keyboard.isDown("d")) and not puzzle_mode then
		lucy:move(lucy.Directions.Right, dt, robot)
	elseif love.keyboard.isDown("f") and not puzzle_mode and near(lucy, robot) then
		puzzle_mode = true
		puzzle = Puzzle.create()
		puzzle:load()
	elseif love.keyboard.isDown("q") or love.keyboard.isDown("escape") then
		love.event.push('quit')
	elseif love.keyboard.isDown("return") and game_over then
		--resetGame()
	else
		lucy:stop()
	end

end

function love.draw()
	if puzzle_mode then
		puzzle:draw()
	else
		lucy:draw()
		robot:draw()
	end
end

function love.mousepressed(x, y, button)
	if puzzle_mode then
		puzzle:mousepressed(x, y, button)
	end
end

