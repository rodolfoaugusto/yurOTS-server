function onUse(player, item, fromPosition, target, toPosition)

		local tile = Tile(fromPosition)

		local wallPos = Position(6055,6100,11)

		if item then
			if item:getId() == 2062 then
				
				local getWall = Tile(wallPos)
				local wall = getWall:getTopTopItem()

				item:transform(2063)
				wall:transform(1638)

				wallPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)

				addEvent(function(pos,torchpos)

					local tile = Tile(pos)
					local somethingInWall = tile:getTopCreature()
					if somethingInWall then
						somethingInWall:teleportTo(Position(pos.x+1,pos.y,pos.z))
					end
					
					Tile(torchpos):getItemById(2063):transform(2062)
					
					pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)

					local getWall = Tile(pos)
					local wall = getWall:getTopTopItem()
					wall:transform(1270)

					local itemsOn = getWall:getItems()
					for i,v in ipairs(itemsOn) do
						if v:getId() ~= 1270 and v:getId() ~= 1638 and v:getId() ~= 1639 then
							v:remove()
						end
					end
				end, 5000, wallPos,fromPosition)
			end
		end
	return true
end
