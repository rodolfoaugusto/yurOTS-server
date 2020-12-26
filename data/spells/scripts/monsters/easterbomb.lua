    
local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_CIRCLE5X5))

function onTargetCreature(creature, target)

local drunk = Condition(CONDITION_DRUNK)
drunk:setParameter(CONDITION_PARAM_TICKS, 60000)
target:addCondition(drunk)

local condition2 = Condition(CONDITION_OUTFIT)
condition2:setTicks(10 * 1000)
local randoutf = math.random(50,70)
condition2:setOutfit({lookType = randoutf})
target:addCondition(condition2)

end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end