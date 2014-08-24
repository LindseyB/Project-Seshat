Puzzle = {}
Puzzle.__index = Puzzle

function Puzzle:create(width, height, titles)
	math.randomseed(os.time())
	math.random(); math.random(); math.random()

	local object = {}
	setmetatable(object, Puzzle)

	object.width = width or 5
	object.height = height or 5
	object.tiles = tiles or 3

	object.board = {}
	object.solved = {}
	object.picked = {}
	object.switch = {}

	for row = 1, object.width do
		object.board[row] = {}
		object.solved[row] = {}
		for col = 1, object.height do
			object.solved[row][col] = false
			object.board[row][col] = math.random(0,object.tiles)
		end
	end

	return object
end

function Puzzle:load()
	self:clear_matches(false)
end

function Puzzle:draw()
	for row = 1, self.width do
		for col = 1, self.width do
			if self.solved[row][col] then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("fill", 32*(row-1), 32*(col-1), 32, 32)
				love.graphics.setColor(255,255,255,255)
			end

			if self.picked[1] == row and self.picked[2] == col then
				love.graphics.setColor(0,255,0,255)
				love.graphics.rectangle("fill", 32*(row-1), 32*(col-1), 32, 32)
				love.graphics.setColor(255,255,255,255)
			end

			love.graphics.rectangle("line", 32*(row-1), 32*(col-1), 32, 32)
			love.graphics.print(self.board[row][col], 32*(row-1), 32*(col-1))
		end
	end

	if self:win() then
		love.graphics.print("You Win", 100, 100)
	end
end

function Puzzle:mousepressed(x, y, button)
	if button == "l" then
		for row = 1, self.width do
			for col = 1, self.height do
				if (x > 32*(row-1) and x < 32*row) and (y > 32*(col-1) and y < 32*col) then
					if #self.picked == 0 then
						-- select a new node to swap
						self.picked = {row, col}
					else
						-- check if valid
						if  (row == self.picked[1]-1 and col == self.picked[2]) or
							(row == self.picked[1]+1 and col == self.picked[2]) or
							(row == self.picked[1] and col == self.picked[2]-1) or
							(row == self.picked[1] and col == self.picked[2]+1) then
								self.switch = {row, col}
						else
							-- it's actually a new pick
							self.picked = {row, col}
						end
					end
				end
			end
		end
	end

	if #self.switch ~= 0 then
		-- try to do the switch
		self.board[self.picked[1]][self.picked[2]], self.board[self.switch[1]][self.switch[2]] = self.board[self.switch[1]][self.switch[2]], self.board[self.picked[1]][self.picked[2]]
		-- verify if switch creates a match otherwise reverse
		if not self:match(self.switch[1],self.switch[2],true) then
			self.board[self.picked[1]][self.picked[2]], self.board[self.switch[1]][self.switch[2]] = self.board[self.switch[1]][self.switch[2]], self.board[self.picked[1]][self.picked[2]]
		else
			self:clear_matches(true)
		end
		-- set the picked and switch back to nothing
		self.picked = {}
		self.switch = {}
	end
end

function Puzzle:match(x, y, clear)
	local match_list = {}
	local match_count = 1
	local matched = false
	-- check for row matches

	-- check left
	for row = x-1, 1, -1 do
		if self.board[x][y] == self.board[row][y] then
			match_count = match_count + 1
			table.insert(match_list, {row, y})
		else
			break
		end
	end

	-- check right
	for row = x+1, self.width do
		if self.board[x][y] == self.board[row][y] then
			match_count = match_count + 1
			table.insert(match_list, {row, y})
		else
			break
		end
	end

	if match_count >= 3 then
		matched = true
		-- delete matched the blocks
		if clear then
			for row = 1, self.width do
				self.solved[row][y] = true
			end
		end
		for i,v in ipairs(match_list) do
			self.board[v[1]][v[2]] = math.random(0,self.tiles)
		end
	end

	-- check for col matches
	match_count = 1
	match_list = {}

	-- check up
	for col = y-1, 1, -1 do
		if self.board[x][y] == self.board[x][col] then
			match_count = match_count + 1
			table.insert(match_list, {x, col})
		else
			break
		end
	end

	-- check down
	for col = y+1, self.height do
		if self.board[x][y] == self.board[x][col] then
			match_count = match_count + 1
			table.insert(match_list, {x, col})
		else
			break
		end
	end

	if match_count >= 3 then
		matched = true
		-- delete matched the blocks
		if clear then
			for col = 1, self.height do
				self.solved[x][col] = true
			end
		end
		for i,v in ipairs(match_list) do
			self.board[v[1]][v[2]] = math.random(0,self.tiles)
		end
	end

	return matched
end

function Puzzle:clear_matches(clear)
	-- clear out all the matches
	repeat
		for row = 1, self.width do
			for col = 1, self.height do
				if row == 1 and col == 1 then
					matched = self:match(row,col,clear)
				else
					matched = (matched or self:match(row,col,clear))
				end
			end
		end
	until not matched
end

function Puzzle:win()
	for row = 1, self.width do
		for col = 1, self.height do
			if not self.solved[row][col] then
				return false
			end
		end
	end

	return true
end