local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_RED)

function onCastSpell(creature, variant)
    if creature:getMaster() then
        return true
    end
	
	local target = creature:getTarget()
	if target ~= nil then
		local gethp = target:getHealth()
		local maxhp = target:getMaxHealth()
		if gethp >= (maxhp/2) then 
			local hpmax = - (maxhp/2)
			target:addHealth(hpmax)
		end

		return combat:execute(creature, variant)
	end
	return false
end