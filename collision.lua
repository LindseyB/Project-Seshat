function colliding(character, objects)
	-- TODO: loop through a list of objects
	return colliding_check(character.x, character.y, character.width, character.height,
						   objects.x, objects.y, objects.width, objects.height)
end

function near(character, objects)
	-- TODO: loop through a list of objects and return the near one
	return colliding_check(character.x+1, character.y, character.width+1, character.height,
						   objects.x, objects.y, objects.width, objects.height)
end

function colliding_check(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end