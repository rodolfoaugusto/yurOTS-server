
local tileInfo = {
					[3030] = {y=-1,itemOrigin=2107,itemFinal=2104},
					[3031] = {y=1,itemOrigin=2107,itemFinal=2106},
				}

function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	local actionId = item:getActionId()


	local nextPosition = Position(position.x,(position.y+tileInfo[actionId].y),position.z)
	local nextTile = Tile(nextPosition)

	local getStatue = nextTile:getItemById(tileInfo[actionId].itemOrigin, -1)

	if getStatue ~= nil then
		getStatue:transform(tileInfo[actionId].itemFinal)
	end

	creature:animatedAddHealth(300)
	nextPosition:sendDistanceEffect(creature:getPosition(), CONST_ANI_ARROW)
	creature:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
	creature:sendTextMessage(MESSAGE_INFO_DESCR, 'Who enter, never return..')

	return true
end

function onStepOut(creature, item, position, fromPosition)
	local actionId = item:getActionId()

	local nextPosition = Position(position.x,(position.y+tileInfo[actionId].y),position.z)
	local nextTile = Tile(nextPosition)

	local getStatue = nextTile:getItemById(tileInfo[actionId].itemFinal, -1)

	if getStatue ~= nil then
		getStatue:transform(tileInfo[actionId].itemOrigin)
	end
	return true
end