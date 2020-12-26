function onUse(player, item, fromPosition, target, toPosition)
	
	local playerPos = player:getPosition()
	local actionId = item:getActionId()
	if actionId == 2001 then
		player:teleportTo(Position(33085,32667,8))
	elseif actionId == 2002 then
		player:teleportTo(Position(33078,32670,8))
	end
	player:getPosition():sendMagicEffect(14)
	return true
end
