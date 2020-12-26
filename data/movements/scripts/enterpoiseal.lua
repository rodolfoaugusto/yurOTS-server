function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end

	local storageId = creature:getStorageValue((8850+item:getActionId()))
	if storageId <= 0 then
		creature:teleportTo(Position(6077,6202,9))
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	end
end