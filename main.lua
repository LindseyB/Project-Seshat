require "puzzle"

function love.load()
	puzzle = Puzzle.create()
	puzzle:load()
end

function love.draw()
	puzzle:draw()
end

function love.mousepressed(x, y, button)
	puzzle:mousepressed(x, y, button)
end

