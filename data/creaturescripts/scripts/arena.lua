function onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    if creature:isPlayer() or creature:getMaster() then
        return true
    end

	local monsterName = creature:getName():lower()
	local creatures = {
						['medusa'] = {next='Kratos',nextPos=Position(6219,5930,7)},
						['kratos'] = {next='reaper',nextPos=Position(6238,5930,7)},
						['reaper'] = {next='Shadow',nextPos=Position(6257,5930,7)},
						['shadow'] = {next='GOD',nextPos=Position(6276,5930,7),message='There is only one way to kill GOD'},
						['gaia'] = {nextPos=Position(6156,5955,7),storage=7300},


						['papyrus'] = {next='Ancient',nextPos=Position(6219,5946,7)},
						['ancient'] = {next='Ramses',nextPos=Position(6238,5946,7)},
						['ramses'] = {next='Pharaoh',nextPos=Position(6257,5946,7)},
						['pharaoh'] = {next='Tentacles',nextPos=Position(6276,5946,7)},
						['tentacles'] = {nextPos=Position(6158,5954,7),storage=7200},

						['puncher'] = {next='Bigfoot',nextPos=Position(6219,5961,7)},
						['bigfoot'] = {next='Crack',nextPos=Position(6238,5961,7)},
						['crack'] = {next='Earthblock',nextPos=Position(6257,5961,7)},
						['earthblock'] = {next='Dominator',nextPos=Position(6276,5961,7)},
						['dominator'] = {nextPos=Position(6153,5954,7),storage=7100},
					}
	if creatures[monsterName] then
		local arenaPos = creatures[monsterName]
		if arenaPos.nextPos then
			killer:teleportTo(arenaPos.nextPos)
			arenaPos.nextPos:sendMagicEffect(CONST_ME_MAGIC_RED)
		end
		if arenaPos.storage then
			killer:setStorageValue(arenaPos.storage,2)
		end
		if arenaPos.next then
			Game.createMonster(arenaPos.next,Position(arenaPos.nextPos.x+8,arenaPos.nextPos.y,arenaPos.nextPos.z))
		end
		if arenaPos.message then
			killer:sendTextMessage(MESSAGE_EVENT_ADVANCE , arenaPos.message)
		end
	end
	return true
end