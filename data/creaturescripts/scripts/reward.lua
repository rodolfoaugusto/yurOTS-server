function onAdvance(player, skill, oldLevel, newLevel)
	if newLevel > oldLevel then
		player:save()
	end

	if skill == SKILL_LEVEL then
		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
		player:getPosition():sendMagicEffect(CONST_ME_SOUND_BLUE)
		if Game.getExperienceStage(newLevel) ~= Game.getExperienceStage(oldLevel) then
			player:sendTextMessage(MESSAGE_INFO_DESCR,'Your experience stage now is '..(decimalPlace(Game.getExperienceStage(newLevel)))..'x')
		end
	end
	return true
end