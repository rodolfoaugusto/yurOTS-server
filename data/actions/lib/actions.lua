function doDestroyItem(target,player)
	if not target:isItem() then
		return false
	end

	local itemType = ItemType(target:getId())
	if not itemType:isDestroyable() then
		return false
	end
	
	if math.random(1,10) <= 3 then
		if target:getActionId() == 2323 and player:getStorageValue(12323) <= 0 then
			local npc = Npc("Dwarf (Hostage)")
			if npc then
			    npc:remove()
			    local tpos = target:getPosition()
		        local dpos = Position(tpos.x,tpos.y+1,tpos.z)
	    		dpos:sendMagicEffect(CONST_ME_BLOCKHIT)
                player:say('Thank you!', TALKTYPE_MONSTER_SAY, false, player, dpos)
		        player:setStorageValue(12323,1)
			end
			addEvent(function(pos,pid)
				local npl = Player(pid)
		        local dpos = Position(pos.x,pos.y+1,pos.z)
		        Game.createNpc('dwarf', dpos)
			end, 120000, target:getPosition(),player:getId())
		elseif player:getStorageValue(12323) > 0 then
			return true
		end
		target:transform(itemType:getDestroyTarget())
		target:decay()
		target:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		target:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return true
end