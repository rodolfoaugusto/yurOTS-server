function onUse(player, item, fromPosition, target, toPosition)

	if target:isCreature() then
		if target:isPlayer() then
			if target:getId() == player:getId() then 
				local targetPos = target:getPosition()
				if targetPos then
					if item:getId() == 5225 then
						local changeValue = math.random(50, 125)
						if changeValue > 0 then
							target:addMana(changeValue)
							targetPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
						end
					elseif item:getId() == 5224 then
						local changeValue = math.random(45, 75)
						if changeValue > 0 then
							target:addHealth(changeValue)
							targetPos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
						end
					end
					target:say('Aaaah...', TALKTYPE_MONSTER_SAY)
					item:remove(1)
				end
			end
		end
	end

	return true
end
