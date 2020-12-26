local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

function onCastSpell(creature, variant)
    if creature:getMaster() then
        return true
    end
	
	local target = creature:getTarget()
	if target ~= nil then
		
		local creaturePos = creature:getPosition()
		local spectators = Game.getSpectators(creaturePos, false, false, 11, 11, 11, 11)
		local someoneInRoom = spectators[math.random(1,#spectators)]

		while someoneInRoom == target do
			someoneInRoom = spectators[math.random(1,#spectators)]
		end

		someoneInRoomPos = someoneInRoom:getPosition()

		someoneInRoomPos:sendMagicEffect(CONST_ME_POFF)
		creaturePos:sendMagicEffect(CONST_ME_POFF)

		creature:teleportTo(Position(someoneInRoomPos.x,someoneInRoomPos.y,someoneInRoomPos.z))
		someoneInRoom:teleportTo(creaturePos)

		return combat:execute(creature, variant)
	end
	return false
end