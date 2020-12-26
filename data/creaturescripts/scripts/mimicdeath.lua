function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    if creature:isPlayer() or creature:getMaster() then
        return true
    end

	local monsterName = creature:getName():lower()
	if monsterName == 'mimic' then
		local spectators = Game.getSpectators(creature:getPosition(), false, true, 11, 11, 11, 11)
		local newPos = Position(6008,6144,9)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if spectator:getStorageValue(12323) ~= 5 then

			    local mirror = spectator:addItem(3463,1)
			    mirror:setActionId(1666)
			    spectator:setStorageValue(12323,5)
				spectator:sendTextMessage(MESSAGE_INFO_DESCR, "You received a mirror.")
			end
			spectator:teleportTo(newPos)
			newPos:sendMagicEffect(CONST_ME_MAGIC_RED)
		end
	end
	corpse:remove()
	return true
end