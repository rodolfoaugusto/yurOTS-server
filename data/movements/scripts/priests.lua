function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	local centerArea = Position(6011,6146,9)
	local teleportToPlace = Position(0,0,0)
	if centerArea.y > creature:getPosition().y then
		teleportToPlace = Position(6023,6157,9)
	else
		teleportToPlace = Position(6054,6112,9)
	end
	creature:teleportTo(teleportToPlace)
	teleportToPlace:sendMagicEffect(CONST_ME_MAGIC_RED)
end