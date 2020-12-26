function onStepIn(creature, item, position, fromPosition)
	local centerArea = Position(5905,6024,7)
	local teleportToPlace = Position(0,0,0)
	if centerArea.x > creature:getPosition().x then
		teleportToPlace = Position(5915,6027,7)
	else
		teleportToPlace = Position(5896,6022,7)
	end
	creature:teleportTo(teleportToPlace)
	teleportToPlace:sendMagicEffect(CONST_ME_MAGIC_RED)
end