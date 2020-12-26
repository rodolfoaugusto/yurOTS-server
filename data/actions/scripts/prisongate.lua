function onUse(player, item, fromPosition, target, toPosition)
	if player:getStorageValue(12323) < 2 then
		return true
	end
	--if player:getPosition().x > toPosition.x then
		local tile = Tile(Position(toPosition.x,toPosition.y+1,toPosition.z))
		local targetItem = tile:getTopTopItem()
		if targetItem then
			if targetItem:getId() == 1479 then
				local itemPos = targetItem:getPosition()
				
				item:transform(2942)
				targetItem:transform(1484)
				itemPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)

				addEvent(function(pos,torchpos)
					local tile = Tile(pos)
					local somethingInWall = tile:getTopCreature()
					if somethingInWall then
						somethingInWall:teleportTo(Position(pos.x+1,pos.y,pos.z))
					end
					
					Tile(torchpos):getItemById(2942):transform(2943)
					
					pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
					tile:getItemById(1484):transform(1479)
				end, 5000, itemPos,toPosition)
			end
		end
	--end
	return true
end
