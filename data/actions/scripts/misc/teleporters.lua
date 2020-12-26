local downstairs = {
	435
}

local upstairs = {
	1948, 1968
}

function posPzPk(locked,pos)
	local tile = Tile(pos)
	if tile:hasFlag(TILESTATE_PROTECTIONZONE) and locked then
		return false
	else
		return true
	end
end
function onUse(player, item, fromPosition, target, toPosition)
	local skull = player:getSkull()

	if table.contains(downstairs, item:getId()) then
		local newPos = item:getPosition():moveRel(0, 0, 1)
		if posPzPk(player:isPzLocked(),newPos) then
			player:teleportTo(newPos)
		else
	        player:sendCancelMessage("You can not enter a protection zone after attacking another player.")
		end
	elseif table.contains(upstairs, item:getId()) then
		local newPos = item:getPosition():moveRel(0, 1, -1)
		if posPzPk(player:isPzLocked(),newPos) then
			player:teleportTo(newPos)
		else
	        player:sendCancelMessage("You can not enter a protection zone after attacking another player.")
		end
	end
	return true
end
