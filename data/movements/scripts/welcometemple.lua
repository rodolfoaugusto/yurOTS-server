function onStepIn(creature, item, position, fromPosition)
	if creature:isPlayer() then
		if creature:getStorageValue(13240) <= 0 then
			creature:sendTextMessage(MESSAGE_INFO_DESCR, 'From here you will live a new experience in RPG, have fun!')
			creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
			creature:setStorageValue(13240,1)
		end
	end
end