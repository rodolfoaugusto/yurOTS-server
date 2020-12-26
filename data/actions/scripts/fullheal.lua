function onUse(player, item, fromPosition, target, toPosition)

	player:addMana(player:getMaxMana())
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
	player:addHealth(player:getMaxHealth())
	item:remove(1)
	return true
end
