function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	local actionId = item:getActionId()
	local storageId = creature:getStorageValue(actionId)

	if storageId <= 0 then
		creature:teleportTo(fromPosition)
	elseif storageId == 1 then
		local arenaPos = {
							[7300] = {pos=Position(6200,5930,7),centerPos = Position(6241,5930,7),monster='Medusa'},
							[7200] = {pos=Position(6200,5946,7),centerPos = Position(6241,5946,7),monster='Papyrus'},
							[7100] = {pos=Position(6200,5961,7),centerPos = Position(6241,5961,7),monster='Puncher'},
						}
		if arenaPos[actionId] then
			local arena = arenaPos[actionId]
			local spectators = Game.getSpectators(arena.centerPos, false, false, 50, 50, 5, 5)

			local playersList = {}
			local monsterList = {}

			for i=1,#spectators do
				local spec = spectators[i]
				if spec then
					if spec:isPlayer() then
						table.insert(playersList,spec)
					else
						table.insert(monsterList,spec)
					end
				end
			end

			if #playersList > 0 then
				creature:sendTextMessage(MESSAGE_INFO_DESCR, 'Player inside the arena.')
				creature:teleportTo(fromPosition)
				return true
			end

			if #monsterList > 0 then
				for i=1,#monsterList do
					monsterList[i]:remove()
				end
			end
			
			creature:teleportTo(arena.pos)
			Game.createMonster(arena.monster,Position(arena.pos.x+8,arena.pos.y,arena.pos.z))
		end
	elseif storageId == 2 then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, 'You finished that arena.')
		creature:teleportTo(fromPosition)
	end
	return true
end