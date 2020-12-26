function onStepIn(creature, item, position, fromPosition)
	if Game.isItemThere({x = 5990, y = 6130, z = 11}, 1949) then
		doRelocate(item:getPosition(),{x = 6016, y = 6117, z = 10})
	end
end

function onAddItem(item, tileitem, position)
	if Game.isItemThere({x = 5990, y = 6130, z = 11}, 1949) then
		doRelocate(item:getPosition(),{x = 6016, y = 6117, z = 10})
	end
end