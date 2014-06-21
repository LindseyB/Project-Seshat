require "puzzle"
require "lucy"

function love.load()
	--puzzle = Puzzle.create()
	--puzzle:load()
	lucy = Lucy.create()
	lucy:load()
end

function love.update(dt)
	lucy:update(dt)

	if love.keyboard.isDown("left") then
		lucy:move(lucy.Directions.Left, dt)
	elseif love.keyboard.isDown("right") then
		lucy:move(lucy.Directions.Right, dt)
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
end

function love.mousepressed(x, y, button)
	--puzzle:mousepressed(x, y, button)
end

