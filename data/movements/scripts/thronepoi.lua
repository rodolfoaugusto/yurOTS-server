function onStepIn(creature, item, position, fromPosition)
	if creature:isMonster() then
		return true
	end
	if creature:getStorageValue((8850+item:getActionId())) <= 0 then
		creature:setStorageValue((8850+item:getActionId()),1)
		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		creature:sendTextMessage(MESSAGE_INFO_DESCR, 'You have absorbed the energy of this throne.')
		creature:say('I feel strong!',TALKTYPE_MONSTER_SAY)
	else
		creature:teleportTo(fromPosition)
	end
end