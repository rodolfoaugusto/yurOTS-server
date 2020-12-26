local ropeSpots = {
	386, 421
}

local holeSpots = {
	293, 294, 369, 370, 385, 394, 411, 412,
	421, 432, 433, 435, 482, 5081, 483, 594,
	595, 607, 609, 610, 615, 1066, 1067, 1080
}

function onUse(player, item, fromPosition, target, toPosition)
	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end
	
	-- scythe
	if target:getId() == 3652 then 
		player:sendCancelMessage(target:getType():getDescription() .. ".")
		return true
	elseif target:getId() == 3653 then
		target:transform(3651, 1)
		target:decay()
		Game.createItem(3605, 1, target:getPosition()) 
		return true
	end
	
	-- machete
	if target:getId() == 3696 then 
		target:transform(3695, 1)
		target:decay()
		return true
	elseif target:getId() == 3702 then
		target:transform(3701, 1)
		target:decay()
		return true
	elseif target:getId() == 2130 then 
		target:remove()
		return true
	end

	if ground:getId() == 372 then
		ground:transform(394, 1)
		ground:decay()
		return true
	elseif target:getId() == 1772 and toPosition.x == 32648 and toPosition.y == 32134 and toPosition.z == 10 and math.random(1, 100) <= 40 then 
		Game.sendMagicEffect({x = 32648, y = 32134, z = 10}, 3)
		Game.removeItemOnMap({x = 32648, y = 32134, z = 10}, 1772)
		return true
	elseif target:getId() == 1772 and toPosition.x == 32648 and toPosition.y == 32134 and toPosition.z == 10 then 
		Game.sendMagicEffect({x = 32648, y = 32134, z = 10}, 3)
		doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -40, -40)
		return true
	elseif target:getId() == 1791 and toPosition.x == 32356 and toPosition.y == 32074 and toPosition.z == 10 and math.random(1, 100) <= 40 then 
		Game.sendMagicEffect({x = 32356, y = 32074, z = 10}, 3)
		Game.removeItemOnMap({x = 32356, y = 32074, z = 10}, 1791)
		return true
	elseif target:getId() == 1791 and toPosition.x == 32356 and toPosition.y == 32074 and toPosition.z == 10 then
		Game.sendMagicEffect({x = 32356, y = 32074, z = 10}, 3)
		doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -50, -50)
		return true
	end

	if table.contains(ropeSpots, tile:getGround():getId()) then
		player:teleportTo(target:getPosition():moveRel(0, 1, -1))
		return true
	elseif table.contains(holeSpots, tile:getGround():getId()) or target:getId() == 435 then
		local tile = Tile(target:getPosition():moveRel(0, 0, 1))
		if not tile then
			return false
		end
		
		local thing = tile:getTopCreature()
		if not thing then
			thing = tile:getTopVisibleThing()
		end
		
		if thing:isCreature() then
			thing:teleportTo(target:getPosition():moveRel(0, 1, 0), false)
			return true
		end
		if thing:isItem() and thing:getType():isMovable() then
			thing:moveTo(target:getPosition():moveRel(0, 1, 0))
			return true
		end
		return true
	end

	local toTarget = target;
	
	local itemType = ItemType(target:getId())
	if itemType:isSplash() then
		toTarget = ground
	end
	
	if toTarget:getId() == 231 then 
		toTarget:getPosition():sendMagicEffect(3)
		return true
	elseif toTarget:getId() == 593 then 
		toTarget:transform(594, 1)
		toTarget:decay()
		doRelocate(toTarget:getPosition(), toTarget:getPosition():moveRel(0,0,1))
		return true
	elseif toTarget:getId() == 606 then 
		toTarget:transform(607, 1)
		toTarget:decay()
		doRelocate(toTarget:getPosition(), toTarget:getPosition():moveRel(0,0,1))
		return true
	elseif toTarget:getId() == 608 then 
		toTarget:transform(609, 1)
		toTarget:decay()
		doRelocate(toTarget:getPosition(), toTarget:getPosition():moveRel(0,0,1))
	elseif toTarget:getId() == 614 and math.random(1, 100) <= 50 then
		toTarget:transform(615, 1)
		toTarget:decay()
		toTarget:getPosition():sendMagicEffect(3)
		doRelocate(toTarget:getPosition(), toTarget:getPosition():moveRel(0,0,1))
	elseif toTarget:getId() == 614 then
		toTarget:getPosition():sendMagicEffect(3)
	elseif toTarget:getId() == 616 and math.random(1, 100) <= 95 then
		toTarget:transform(617, 1)
		toTarget:decay()
		toTarget:getPosition():sendMagicEffect(3)
		Game.createMonster("scarab", toTarget:getPosition())
	elseif toTarget:getId() == 616 then
		toTarget:getPosition():sendMagicEffect(3)
		Game.createItem(3042, 1, toTarget:getPosition())
		toTarget:transform(617, 1)
		toTarget:decay()
	elseif toTarget:getId() == 617 then
		toTarget:getPosition():sendMagicEffect(3)
	end

	return false
end