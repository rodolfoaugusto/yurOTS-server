function onUse(player, item, fromPosition, target, toPosition)
	
	local playerPos = player:getPosition()

	local chanceBreak = math.random(10,30)
	local breakstatus = false
	if chanceBreak >= 26 then 
		breakstatus = true
	end
	
	if breakstatus == true then

		addEvent(function(hydraEggsPos,hydraEggItem)
			local hydraEgg = Game.createItem(hydraEggItem,1,toPosition)
			hydraEgg:setActionId(2020)
		end, 120000, toPosition,item:getId())

		item:remove()
		if chanceBreak >= 28 then
			Game.createMonster('Hydra', toPosition)
			toPosition:sendMagicEffect(15)
		else
			toPosition:sendMagicEffect(3)
		end
	else
		toPosition:sendMagicEffect(3)
	end
	return true
end
