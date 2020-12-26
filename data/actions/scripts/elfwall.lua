function onUse(player, item, fromPosition, target, toPosition)
	
	local playerPos = player:getPosition()
	local targetPos = toPosition

	if playerPos.y > targetPos.y then
		player:teleportTo(Position(targetPos.x,targetPos.y-2,targetPos.z))
	else 
		player:teleportTo(Position(targetPos.x,targetPos.y+2,targetPos.z))
	end
	toPosition:sendMagicEffect(15)
	return true
end
