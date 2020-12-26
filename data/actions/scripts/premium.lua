function onUse(player, item, fromPosition, target, toPosition)
	local premiumDays = 15
	player:sendTextMessage(MESSAGE_INFO_DESCR, 'You received '.. premiumDays .. ' days of premium account.')
	player:addPremiumDays(premiumDays)
	item:getPosition():sendMagicEffect(3)
	item:remove()
	return true
end
