function onSay(player, words, param)
	local words = {'The training will makes me stronger!','Training time!','I will punch that monk!'}
	local choosed = math.random(1,#words)
	
	local playerPos = player:getPosition()
	if playerPos:isInRange({x=5990, y=6034, z=7}, {x=6008, y=6047, z=7}) then
		player:say(words[choosed], TALKTYPE_SAY)
		playerPos:sendMagicEffect(CONST_ME_POFF)
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Welcome to training zone!")
		local newPos = Position(6078,6006,6)
		player:teleportTo(newPos)
		newPos:sendMagicEffect(CONST_ME_TELEPORT)
	else
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You're not in temple to use that command.")
	end
	return false
end