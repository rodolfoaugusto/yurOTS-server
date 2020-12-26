function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, player:getStorageValue(param))
	return false
end
