function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	creature:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
	local newPos = Position(6132,6261,7)
	creature:teleportTo(newPos)
	newPos:sendMagicEffect(CONST_ME_GROUNDSHAKER)
	creature:setDirection(SOUTH)
end