function onUse(player, item, fromPosition, target, toPosition)

	local teleporters = {
							[2968] = Position(6201,6318,12),
						}

	local itemId = item:getId()
	local currentPos = item:getPosition()

	local spectators = Game.getSpectators(currentPos, false, true, 4, 4, 4, 4)

	for i,v in ipairs(spectators) do
		v:teleportTo(teleporters[itemId])
		v:getPosition():sendMagicEffect(29)
		v:sendTextMessage(MESSAGE_INFO_DESCR, "Something unusual happened..")
	end
			
	return true
end
