function love.load()
	math.randomseed(os.time())
	math.random(); math.random(); math.random()
	
	width = 5
	height = 5

	board = {}
	solved_row = {}
	solved_col = {}
	picked = {}
	switch = {}

	for row = 1, width do
		board[row] = {}
		solved_row[row] = false
		solved_col[row] = false
		for col = 1, height do
			board[row][col] = math.random(0,7)
		end
	end

	clear_matches()
end

function love.draw()
	for row = 1, width do
		for col = 1, width do
			if picked[1] == row and picked[2] == col then
				love.graphics.setColor(0,255,0,255)
				love.graphics.rectangle("fill", 32*(row-1), 32*(col-1), 32, 32)
				love.graphics.setColor(255,255,255,255)
			end

			if solved_row[col] then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("fill", 32*(row-1), 32*(col-1), 32, 32)
				love.graphics.setColor(255,255,255,255)
			end

			if solved_col[row] then
				love.graphics.setColor(0,0,255,255)
				love.graphics.rectangle("fill", 32*(row-1), 32*(col-1), 32, 32)
				love.graphics.setColor(255,255,255,255)
			end

			love.graphics.rectangle("line", 32*(row-1), 32*(col-1), 32, 32)
			love.graphics.print(board[row][col], 32*(row-1), 32*(col-1)) 
		end
	end
end

function love.mousepressed(x, y, button)
	if button == "l" then
		for row = 1, width do
			for col = 1, height do
				if (x > 32*(row-1) and x < 32*row) and (y > 32*(col-1) and y < 32*col) then					
					if #picked == 0 then
						-- select a new node to swap
						picked = {row, col}
					else
						-- check if valid
						if  (row == picked[1]-1 and col == picked[2]) or
							(row == picked[1]+1 and col == picked[2]) or
							(row == picked[1] and col == picked[2]-1) or
							(row == picked[1] and col == picked[2]+1) then
								switch = {row, col}
						else
							-- it's actually a new pick
							picked = {row, col}
						end
					end
				end
			end
		end
	end

	if #switch ~= 0 then
		-- try to do the switch
		board[picked[1]][picked[2]], board[switch[1]][switch[2]] = board[switch[1]][switch[2]], board[picked[1]][picked[2]]
		-- verify if switch creates a match otherwise reverse
		if not match(switch[1],switch[2],true) then
			board[picked[1]][picked[2]], board[switch[1]][switch[2]] = board[switch[1]][switch[2]], board[picked[1]][picked[2]]
		else
			clear_matches()
		end
		-- set the picked and switch back to nothing
		picked = {}
		switch = {}
	end
end

function match(x, y, clear)
	local match_list = {}
	local match_count = 1
	local matched = false
	-- check for row matches

	-- check left
	for row = x-1, 1, -1 do
		if board[x][y] == board[row][y] then
			match_count = match_count + 1
			table.insert(match_list, {row, y})
		else
			break
		end
	end

	-- check right
	for row = x+1, width do
		if board[x][y] == board[row][y] then
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
			solved_row[y] = true
		end
		for i,v in ipairs(match_list) do
			board[v[1]][v[2]] = math.random(0,7)
		end
	end

	-- check for col matches
	match_count = 1
	match_list = {}

	-- check up
	for col = y-1, 1, -1 do
		if board[x][y] == board[x][col] then
			match_count = match_count + 1
			table.insert(match_list, {x, col})
		else
			break
		end
	end

	-- check down
	for col = y+1, height do
		if board[x][y] == board[x][col] then
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
			solved_col[x] = true
		end
		for i,v in ipairs(match_list) do
			board[v[1]][v[2]] = math.random(0,7)
		end
	end

	return matched		
end

function clear_matches()
	-- clear out all the matches
	repeat
		for row = 1, width do
			for col = 1, height do
				if row == 1 and col == 1 then
					matched = match(row,col,false)
				else
					matched = (matched or match(row,col,false))
				end
			end
		end
	until not matched
end