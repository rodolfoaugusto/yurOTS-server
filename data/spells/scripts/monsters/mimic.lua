local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if target ~= nil then
		local targetSpeed = target:getSpeed()
		local outfit = target:getOutfit()
		creature:setOutfit({lookType = outfit.lookType, lookHead = outfit.lookHead, lookBody = outfit.lookBody, lookLegs = outfit.lookLegs, lookFeet = outfit.lookFeet})

		if target:isPlayer() then
			creature:say('Look at me '.. target:getName() ..'. I\'m like yours now', TALKTYPE_MONSTER_SAY, false, target, creature:getPosition())
		end
		--creature:changeSpeed(targetSpeed)
		--creature:setMaxHealth(targetHP)
		--creature:addHealth(targetHP)

		creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		return combat:execute(creature, variant)
	end
	return false
end