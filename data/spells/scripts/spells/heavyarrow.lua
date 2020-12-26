function onCastSpell(creature, var)

    local baseMana = 350
    local creaturePos = creature:getPosition()
    if creature:getStorageValue(7300) ~= 2 then
        creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You need to prove your worth in the arena.")
        creaturePos:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if(creature:getMana() < baseMana) then
        creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
        creaturePos:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    creature:addMana(-baseMana, FALSE)

    creaturePos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
    creature:addItem(5104,5)

    return true
end