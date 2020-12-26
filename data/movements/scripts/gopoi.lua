function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end

	local seals = {
					[1] = {pos=Position(6108,6198,9),dir=NORTH},
					[2] = {pos=Position(6124,6239,9),dir=NORTH},
					[3] = {pos=Position(6174,6241,9),dir=SOUTH},
					[4] = {pos=Position(6190,6219,9),dir=SOUTH},
					[5] = {pos=Position(6174,6274,9),dir=NORTH},
					[6] = {pos=Position(6127,6267,11),dir=SOUTH},
					[7] = {pos=Position(6189,6317,9),dir=EAST},
				}
	local sealNum = item:getActionId()
	if sealNum >= 0 then
		if seals[sealNum] then
			creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			creature:teleportTo(seals[sealNum].pos)
			seals[sealNum].pos:sendMagicEffect(CONST_ME_MAGIC_RED)
			creature:setDirection(seals[sealNum].dir)
		end
	end
end