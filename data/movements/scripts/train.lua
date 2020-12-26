function startTraining(pid,originalPos)
	local player = Player(pid)
	local trainTime = {}
	if player then
		local posNow = player:getPosition()
		if posNow.x ~= originalPos.x or posNow.y ~= originalPos.y then
			if trainTime[pid] then
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'Training is over.')
				stopEvent(trainTime[pid])
			end
			return true
		end

		local remaningHealth = player:getMaxHealth() - player:getHealth()
		if remaningHealth > 0 then
			player:addHealth(remaningHealth)
			posNow:sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end

		trainTime[pid] = addEvent(startTraining, 3000, pid,originalPos)
	else
		if trainTime[pid] then
			stopEvent(trainTime[pid])
		end
		return true
	end

end
-- 		startTraining(creature:getId(),creature:getPosition())
function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, 'Training is started')
	end
end