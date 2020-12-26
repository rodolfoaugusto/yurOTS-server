function onUse(player, item, fromPosition, target, toPosition)
	if math.random(1, 100) <= 90 then
		item:getPosition():sendMagicEffect(3)
		return true
	end
	return true
end
