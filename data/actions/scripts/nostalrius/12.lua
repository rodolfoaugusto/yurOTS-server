function onUse(player, item, fromPosition, target, toPosition)
	player:teleportTo(Position(32671,32070,8))
	Game.sendMagicEffect({x = 32671, y = 32070, z = 08}, 11)
	return true
end