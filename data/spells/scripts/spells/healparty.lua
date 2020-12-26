function onCastSpell(creature, var)

    local baseMana = 300
    local additionalTargetMana = 25
    local healerPos = creature:getPosition()
    local healerId = creature:getId()
    local party = creature:getParty()
    local membersList = {}

    -- Check if caster is in a party
    if party then
        -- Insert Members
        membersList = party:getMembers()
        -- Insert Leader
        table.insert(membersList, party:getLeader())
        if membersList == nil then
            creature:sendTextMessage(MESSAGE_STATUS_SMALL, "There are no party members in range with missing health.")
            healerPos:sendMagicEffect(CONST_ME_POFF)
            return false
        end
    else
        creature:sendTextMessage(MESSAGE_STATUS_SMALL, "You are not in a party.")
        return false
    end

    -- Check collate all members and add to valid target list if in range
    local affectedList = {}
    for _, partyMember in ipairs(membersList) do
        local partyMemberId = partyMember:getId()
        if partyMemberId ~= creature:getId() then
            local partyMemberPos = partyMember:getPosition()
            local distanceX = math.abs(partyMemberPos.x - healerPos.x)
            local distanceY = math.abs(partyMemberPos.y - healerPos.y)
            if distanceX <= 7 and distanceY <= 5 and partyMemberPos.z == healerPos.z and partyMemberPos:isSightClear(healerPos, true) and partyMember:getHealth() < partyMember:getMaxHealth() then
                table.insert(affectedList, partyMember)
            end
        end
    end

    -- Get check if valid Party Members in range
    local tmp = 0
    if affectedList ~= nil then
        tmp = #affectedList
    end
    if tmp < 1 then
        creature:sendTextMessage(MESSAGE_STATUS_SMALL, "There are no party members in range with missing health.")
        healerPos:sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- Calculate mana costs
    local mana = baseMana + (additionalTargetMana * (tmp - 1))
    if(creature:getMana() < mana) then
        creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
        healerPos:sendMagicEffect(CONST_ME_POFF)
        return false
    end
 
    -- Don't reduce mana if GM or GOD because it sends CONST_ME_POFF animation
    --if not creature:getGroup():getAccess() then
        creature:addMana(-(mana - baseMana), FALSE)
        creature:addManaSpent((mana - baseMana))
    --end
 
    local level = creature:getLevel()
    local magiclevel = creature:getMagicLevel()
    local min = (level / 5) + (magiclevel * 6.3) + 45
    local max = (level / 5) + (magiclevel * 14.4) + 90
 
    -- Healer Animation
    healerPos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
 
    -- Apply Heal/Animation to Party Member
    for _, partyMember in ipairs(affectedList) do
        local healAmount = math.random(min,max)
        partyMember:addHealth(healAmount)
        partyMember:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end

    return true
end