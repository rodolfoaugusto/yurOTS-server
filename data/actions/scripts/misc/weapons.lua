function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	local actionId = target:getActionId()
	local chestQuestNumber = target:getAttribute(ITEM_ATTRIBUTE_CHESTQUESTNUMBER)

	if chestQuestNumber > 0 or actionId > 0 then
		return false
	end
	return doDestroyItem(target,player)
end
