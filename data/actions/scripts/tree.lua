function onUse(player, item, fromPosition, target, toPosition)

	local newPos = Position(6163,6016,7)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:teleportTo(newPos)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:setDirection(SOUTH)

	return true
end
