function onKill(player, target)
    if target:isPlayer() or target:getMaster() then
        return true
    end
	local monsterName = target:getName():lower()

	local playersInList = {}
    for cid, damage in pairs(target:getDamageMap()) do
    	if isInArray(playersInList,cid) == false then
	    	table.insert(playersInList,cid)
	    end
    end
	for i=1,#playersInList do
		local cid = playersInList[i]
    	local attacker = Player(cid)
    	if attacker then
	    	local status = attacker:getStorageValue(18000)
			if status > 0 then
        		if isInArray(tasks[status].monsters,monsterName) then
        			local amount = attacker:getStorageValue(18200)
        			local amountNow = (amount+1)
        			local amountLimit = tasks[status].amount
        			if amount >= amountLimit then
        				amountNow = amountLimit
	    				attacker:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Report that task in a temple NPC.")
        			else
	    				attacker:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "Your ".. tasks[status].name .." task status is now ".. amountNow .." of ".. amountLimit ..".")
	        			attacker:setStorageValue(18200,amountNow)
        			end
    				if attacker:getStorageValue(18300) <= 0 then
						attacker:setStorageValue(18300,amountLimit)

	    				if attacker:getStorageValue(18400) <= 0 then -- money
							if tasks[status].money then
								attacker:setStorageValue(18400,tasks[status].money)
							else
								attacker:setStorageValue(18400,0)
							end
						end

	    				if attacker:getStorageValue(18500) <= 0 then -- experience
							if tasks[status].experience then
								attacker:setStorageValue(18500,tasks[status].experience)
							else
								attacker:setStorageValue(18500,0)
							end
						end

	    				if attacker:getStorageValue(18600) <= 0 then -- item
							if tasks[status].points then
								attacker:setStorageValue(18600,tasks[status].points)
							else
								attacker:setStorageValue(18600,0)
							end
						end
    				end
        		end
        	end
        end
    end
	return true
end