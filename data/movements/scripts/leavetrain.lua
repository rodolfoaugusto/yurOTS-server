function onStepIn(player, item, position, fromPosition)
	local playerPos = player:getPosition()
	playerPos:sendMagicEffect(CONST_ME_POFF)
	local newPos = Position(5996,6044,7)
	player:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_TELEPORT)
	player:setDirection(SOUTH)
end