function onUse(player, item, fromPosition, target, toPosition)
	if not target:isItem() then
		return false
	end
	
	if target:getActionId() == 5528 then 
		
		local targetPos = target:getPosition()

		addEvent(function(nitemPos, nitemId)
        	local newItem = Game.createItem(nitemId, 1, nitemPos)
        	newItem:setActionId(5528)
        end, 60000, targetPos, target:getId())

		target:remove()
		Game.createMonster("winter soul", targetPos, false, true)
        targetPos:sendMagicEffect(CONST_ME_POFF)
        
		return true
	end
	return false
end
