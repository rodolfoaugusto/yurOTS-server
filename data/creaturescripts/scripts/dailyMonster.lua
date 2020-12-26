function onKill(creature, target)
	local monsterName = target:getName():lower()
	if monsterName == DailyMonster then
		local monster = MonsterType(monsterName)
		local monsterExp = monster:getExperience()
		monsterExp = (monsterExp * DailyBonus) / 100
		creature:addExperience(monsterExp,true)
	end
	return true
end
