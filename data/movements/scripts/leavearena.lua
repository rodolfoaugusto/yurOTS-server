function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	local newPos = Position(6136,6041,7)
	creature:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	creature:setDirection(SOUTH)
end