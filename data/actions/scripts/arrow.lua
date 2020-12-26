function onUse(player, item, fromPosition, target, toPosition)
	local god = Creature('GOD')
	if god then
		local godPos = god:getPosition()
		item:getPosition():sendDistanceEffect(godPos, CONST_ANI_ARROW)
		local godHP = god:getMaxHealth() - 1
		god:addHealth(-30)

		addEvent(function(godPos,cid)
			local god = Creature('GOD')
			if god then
				local player = Player(cid)
				if player then
					godPos:sendMagicEffect(CONST_ME_POFF)
					god:say('HA HA HA HA HA! GOD is a woman!', TALKTYPE_MONSTER_SAY)
					god:remove()
					Game.createMonster('Gaia',godPos)
				end
			end
		end, 1500, godPos,player:getId())
	end
	return true
end
