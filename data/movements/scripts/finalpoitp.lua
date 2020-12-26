function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	local newPos = Position(6273,6274,9)
	creature:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_MAGIC_RED)
	creature:setDirection(NORTH)
end