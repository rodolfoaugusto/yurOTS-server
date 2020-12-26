function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end
	
	local creature = Creature(param)
	creature:remove()
	return false
end
