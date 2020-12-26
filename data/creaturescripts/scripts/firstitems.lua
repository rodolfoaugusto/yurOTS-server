function onLogin(player)
	if player:getLastLoginSaved() <= 0 then
		-- Items
		--if player:getPremiumDays() <= 0 then
		--	player:addPremiumDays(2)
		--end
		
		local container = Game.createItem(2854, 1)

		local vocId = player:getVocation():getId()
		if vocId == 1 then
			player:addItem(3074, 1, true, -1, CONST_SLOT_LEFT)
		elseif vocId == 2 then
			player:addItem(3066, 1, true, -1, CONST_SLOT_LEFT)
		elseif vocId == 3 then
			player:addItem(3350, 1, true, -1, CONST_SLOT_LEFT)
		elseif vocId == 4 then
			container:addItem(3329, 1)
			container:addItem(3330, 1)
			container:addItem(3310, 1)
		end

		player:addItem(3084, 1, true, -1, CONST_SLOT_NECKLACE)
		player:addItem(3355, 1, true, -1, CONST_SLOT_HELMET)
		player:addItem(3361, 1, true, -1, CONST_SLOT_ARMOR)
		player:addItem(3559, 1, true, -1, CONST_SLOT_LEGS)
		
		player:feed((22 * 3) * 12)
		
		if vocId ~= 3 then
			player:addItem(3430, 1, true, -1, CONST_SLOT_RIGHT)
		else
			container:addItem(3430, 1)
			container:addItem(3447, 50)
		end
		
		player:addItem(3552, 1, true, -1, CONST_SLOT_FEET)
		
		container:addItem(3457, 1)
		container:addItem(3003, 1)
		container:addItem(3725, 3)
		
		player:addItemEx(container, true, CONST_SLOT_BACKPACK)
	
		-- Default Outfit
		if player:getSex() == PLAYERSEX_FEMALE then
			player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
		else
			player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 95})
		end
		
		--local town = Town("Rookgaard")
		--player:teleportTo(town:getTemplePosition())
		--player:setTown(town)
		player:setDirection(DIRECTION_SOUTH)
	end
	return true
end
