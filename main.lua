require "puzzle"
require "lucy"

function love.load()
	--puzzle = Puzzle.create()
	--puzzle:load()
	lucy = Lucy.create()
	lucy:load()

	background_Image = love.graphics.newImage("sprites/background.png")
	imageWidth = background_Image:getWidth()
	posX = 0
end

function love.update(dt)
	lucy:update(dt)

	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		lucy:move(lucy.Directions.Left, dt)
		-- TODO: move
		posX = posX + 1
		if posX >= imageWidth then posX = 0 end
	elseif love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		lucy:move(lucy.Directions.Right, dt)
		-- TODO: move
		posX = posX - 1
		if posX <= (-1 * imageWidth) then posX = 0 end
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
	-- TODO: move me into my own deal
	love.graphics.draw(background_Image, posX - imageWidth, 0) -- this is the copy that we draw to the
	love.graphics.draw(background_Image, posX, 0) -- this is the original image
	love.graphics.draw(background_Image, posX + imageWidth, 0) -- this is the copy that we draw to the

	lucy:draw()
end

function love.mousepressed(x, y, button)
	--puzzle:mousepressed(x, y, button)
end

