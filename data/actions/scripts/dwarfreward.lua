function onUse(player, item, fromPosition, target, toPosition)
	if player:getStorageValue(12323) == 2 then
		player:addItem(3370,1)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have found knight armor.")
		player:setStorageValue(12323,3)
		return true
	end
	return false
end
