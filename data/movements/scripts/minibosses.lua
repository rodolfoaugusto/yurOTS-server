function onRemoveItem(item, tile, position)
	local teleporters = {
							[2968] = Position(6132,6268,8)
						}

	local itemId = item:getId()
	local currentPos = item:getPosition()
	local fromPos = position

	local spectators = Game.getSpectators(currentPos, false, true, 4, 4, 4, 4)

	for i,v in ipairs(spectators) do
		--v:teleportTo(teleporters[itemId])
		v:getPosition():sendMagicEffect(29)
	end


	local newItem = Game.createItem(itemId,1,fromPos)
	newItem:setMovementId(23)
	newItem:setActionId(999)
	newItem:setAttribute(ITEM_ATTRIBUTE_KEYNUMBER,666)
	
	if item ~= nil then
		item:remove()
		local getItemOnTile = Tile(currentPos)
		if getItemOnTile ~= nil then
			local itemTile = getItemOnTile:getItemById(itemId,-1)
			if itemTile ~= nil then
				itemTile:remove()
			end
		end
	end

	return true
end

