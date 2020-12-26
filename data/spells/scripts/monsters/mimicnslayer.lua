local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local function findDamage(target,creaturePos,targetPos,voc)
	local slots = {CONST_SLOT_AMMO,CONST_SLOT_RIGHT,CONST_SLOT_LEFT}
	for slotId=1,#slots do
		local itemAmmo = target:getSlotItem(slots[slotId])
		local itemInAmmo = false
		if itemAmmo ~= nil then
			if itemAmmo:getId() > 0 then
				local itemAmmoType = ItemType(itemAmmo:getId())
				local itemAttack = itemAmmoType:getAttack()
				local missile = itemAmmoType:getMissileType()
				if missile > 0 then
					if itemAttack > 0 and voc == 3 or itemAttack > 0 and voc == 7 then
						local skillPower = target:getSkillLevel(SKILL_DISTANCE)
						creaturePos:sendDistanceEffect(targetPos, missile, target)
						itemInAmmo = true
						return itemAttack + (skillPower*2)
					end
				else
					if itemAttack > 0 and voc == 4 or itemAttack > 0 and voc == 8 then
						local skills = {SKILL_CLUB,SKILL_SWORD,SKILL_AXE}
						local skillsValue = {}

						for si=1,#skills do
							table.insert(skillsValue,target:getSkillLevel(skills[si]))
						end

						local skillPower = math.max(skillsValue)
						return itemAttack + (skillPower*2)
					end
				end	
			end
		end
	end
	return math.random(100,190)
end

function onCastSpell(creature, variant)
	local target = creature:getTarget()
	if target ~= nil then
		if target:isPlayer() then
			local creaturePos = creature:getPosition()
			local targetPos = target:getPosition()
			local targetVoc = target:getVocation():getId()

			local vocPower = math.random(100,190)
			if targetVoc == 1 or targetVoc == 5 or targetVoc == 2 or targetVoc == 6 then
				vocPower = target:getMagicLevel() * 3
				targetPos:sendMagicEffect(CONST_ME_MORTAREA)
			else
				vocPower = findDamage(target,creaturePos,targetPos,targetVoc)
			end

			local dmg = vocPower * -1

			target:addHealth(dmg)
			target:addMana(dmg,true)

			creature:say('HEHEHEHE! Multiplying my power by yours!', TALKTYPE_MONSTER_SAY, false, target, creaturePos)
			creaturePos:sendMagicEffect(CONST_ME_GREEN_RINGS)

			return combat:execute(creature, variant)
		
		else
			return false
		end
	end
	return false
end