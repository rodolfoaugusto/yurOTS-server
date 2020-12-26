function onUse(player, item, fromPosition, target, toPosition)

	local mirrorItems = {
							[1] = 5228,
							[2] = 5228,
							[3] = 5103,
							[4] = 5202,
						}
	if target:isCreature() and target:getPlayer() ~= nil then
		local pvoc = target:getVocation():getId()
		if pvoc == 5 then
			pvoc = 1
		elseif pvoc == 6 then
			pvoc = 2
		elseif pvoc == 7 then
			pvoc = 3
		elseif pvoc == 8 then
			pvoc = 4
		end
		target:addItem(mirrorItems[pvoc], 1)
		target:say('Well.. well... not bad!', TALKTYPE_MONSTER_SAY)
		local itemInfo = ItemType(mirrorItems[pvoc])
		target:sendTextMessage(MESSAGE_INFO_DESCR, "You received "..itemInfo:getName())
		item:remove(1)
	end
	return true
end
