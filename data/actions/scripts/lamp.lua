function onUse(player, item, fromPosition, target, toPosition)
	local newPos = Position(5970,6049,6)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:teleportTo(newPos)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:setDirection(DIRECTION_EAST)
	return true
end
