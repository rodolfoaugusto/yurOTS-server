function onUse(player, item, fromPosition, target, toPosition)
	local playerPos = player:getPosition()
	local playerStorage = player:getStorageValue(12323)
	--if playerStorage >= 2 and playerStorage <= 3 then
		local newPos = Position(6008,6135,9)
		playerPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:teleportTo(newPos)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		player:setDirection(SOUTH)
	--else
		playerPos:sendMagicEffect(3)
	--end
	return true
end
