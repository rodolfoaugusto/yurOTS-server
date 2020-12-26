function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    if creature:isPlayer() or creature:getMaster() then
        return true
    end
    local playersInList = {}
    for cid, damage in pairs(creature:getDamageMap()) do
    	if isInArray(playersInList,cid) == false then
	    	table.insert(playersInList,cid)
	    end
    end
	for i=1,#playersInList do
		local cid = playersInList[i]
		local attacker = Player(cid)
		if attacker then
			attacker:sendTextMessage(MESSAGE_INFO_DESCR, "You received a easter gift. That powerful egg will recover all your health and mana points when used.")
			attacker:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			attacker:addItem(3606,3)
		end
	end
	corpse:remove()
	return true
end