function onUse(player, item, fromPosition, target, toPosition)

	local roomCenter = Position(6014, 6142, 10)
	local spectators = Game.getSpectators(roomCenter, false, false, 10, 10, 10, 10)
	local needPlayers = 5

	
	for ci=1,#spectators do
		local creature = spectators[ci]
		if creature:isPlayer() then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "Have another team inside mimic room.")
			return true
		end
	end

	for ci=1,#spectators do
		local creature = spectators[ci]
		if creature:isMonster() then
			creature:remove()
		end
	end

	Game.createMonster('Mimic',Position(6011,6140,10))

	local levelneeded = false
	local playersInside = {}
	for pi=1,needPlayers do
		local playerPos = Position(fromPosition.x-pi,fromPosition.y,fromPosition.z)
		local PlayerTile = Tile(playerPos)
		local player = PlayerTile:getTopCreature()
		if player then
			if player:isPlayer() and player:getLevel() >= 100 then
				local playerSpot = {pid=player,pos=playerPos}
				table.insert(playersInside,playerSpot)
			else
				levelneeded = true
			end
		end
	end

	if levelneeded then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "All players need to be level 100 or higher.")
		return true
	end

	if #playersInside == needPlayers then
		for pgo=1,needPlayers do
			local player = playersInside[pgo].pid
			local playerPos = playersInside[pgo].pos
			playerPos:sendMagicEffect(CONST_ME_POFF)
			local newPos = Position(roomCenter.x-pgo,roomCenter.y,roomCenter.z)
			player:teleportTo(newPos)
			newPos:sendMagicEffect(CONST_ME_TELEPORT)
			player:setDirection(NORTH)
		end
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You need ".. needPlayers .." players to start.")
		return true
	end

	if item:getId() == 2773 then
		item:transform(2772)
	else
		item:transform(2773)
	end
	return true
end
