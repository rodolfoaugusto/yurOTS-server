function onUse(player, item, fromPosition, target, toPosition)
	
	if item:getId() == 2772 and Game.isItemThere({x = 33089, y = 32681, z = 8},420) and Game.isItemThere({x = 33090, y = 32681, z = 8},3416) then
		doRelocate({x = 33089, y = 32681, z = 8},{x = 33071, y = 32696, z = 8})
		Game.removeItemOnMap({x = 33090, y = 32681, z = 8}, 3349)
		Game.sendMagicEffect({x = 33071, y = 32696, z = 8}, 11)
	elseif item:getId() == 2773 then
		item:transform(2772, 1)
		item:decay()
	end
	
	return true
end