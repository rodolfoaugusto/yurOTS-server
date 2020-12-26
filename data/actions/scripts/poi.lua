function onUse(player, item, fromPosition, target, toPosition)

	if player:getStorageValue(9966) <= 0 then
		local mirrorItems = {
								[1] = 5163,
								[2] = 5163,
								[3] = 5156,
								[4] = 5151,
							}
		local pvoc = player:getVocation():getId()
		if pvoc == 5 then
			pvoc = 1
		elseif pvoc == 6 then
			pvoc = 2
		elseif pvoc == 7 then
			pvoc = 3
		elseif pvoc == 8 then
			pvoc = 4
		end
		player:addItem(mirrorItems[pvoc], 1)
		player:say('Yes! Finally.. a powerful weapon.', TALKTYPE_MONSTER_SAY)
		local itemInfo = ItemType(mirrorItems[pvoc])
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You received "..itemInfo:getArticle().." "..itemInfo:getName())
		player:setStorageValue(9966,1)
	end
	return true
end
