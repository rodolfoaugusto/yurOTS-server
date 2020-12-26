function onSay(player, words, param)
	local position = player:getPosition()
	position:getNextPosition(player:getDirection())

	local tile = Tile(position)
	local house = tile and tile:getHouse()
	if house == nil then
		player:sendCancelMessage("You have to be looking at the door of the house you would like to buy.")
		return false
	end

	if player:getLevel() < 80 then
		player:sendCancelMessage("You need to be level 80 or higher to buy a house.")
		return false
	end

	if house:getOwnerGuid() > 0 then
		player:sendCancelMessage("This house already has an owner.")
		return false
	end

	if player:getHouse() then
		player:sendCancelMessage("You are already the owner of a house.")
		return false
	end

	local price = house:getRent() * 5
	if not player:removeMoney(price) then
		player:sendCancelMessage("You do not have enough money.")
		return false
	end

	house:setOwnerGuid(player:getGuid())
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have successfully bought this house, be sure to have the money for the rent in the depot locker.")
	return false
end
