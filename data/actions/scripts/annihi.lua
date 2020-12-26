function onUse(player, item, fromPosition, target, toPosition)

	local annihiCenter = Position(6041, 6112, 11)
	local spectators = Game.getSpectators(annihiCenter, false, false, 10, 10, 10, 10)
	local needPlayers = 4

	local demonSpots = {
				Position(6037,6110,11),
				Position(6039,6110,11),
				Position(6038,6114,11),
				Position(6040,6114,11),
				Position(6041,6112,11),
				Position(6042,6112,11),
			}

	for ci=1,#spectators do
		local creature = spectators[ci]
		if creature:isPlayer() then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Have another team inside the annihilator.")
			return true
		end
	end

	for ci=1,#spectators do
		local creature = spectators[ci]
		if creature:isMonster() then
			creature:remove()
		end
	end

	for dsp=1,#demonSpots do
		local dPos = demonSpots[dsp]
		Game.createMonster('Demon',dPos)
	end

	local playersInside = {}
	for pi=1,needPlayers do
		local playerPos = Position(fromPosition.x-pi,fromPosition.y,fromPosition.z)
		local PlayerTile = Tile(playerPos)
		local player = PlayerTile:getTopCreature()
		if player then
			if player:isPlayer() then
				local playerSpot = {pid=player,pos=playerPos}
				table.insert(playersInside,playerSpot)
			end
		end
	end

	if #playersInside == needPlayers then
		for pgo=1,needPlayers do
			local player = playersInside[pgo].pid
			local playerPos = playersInside[pgo].pos
			playerPos:sendMagicEffect(CONST_ME_POFF)
			local newPos = Position(annihiCenter.x-pgo,annihiCenter.y,annihiCenter.z)
			player:teleportTo(newPos)
			newPos:sendMagicEffect(CONST_ME_TELEPORT)
		end
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You need ".. needPlayers .." players to start annihilator.")
		return true
	end

	if item:getId() == 2773 then
		item:transform(2772)
	else
		item:transform(2773)
	end
	return true
end
