local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)

-- Set area
local arr = {
    {0, 1, 1, 1, 0},
    {1, 1, 1, 1, 1},
    {1, 1, 2, 1, 1},
    {1, 1, 1, 1, 1},
    {0, 1, 1, 1, 0}
}

local animationarea = {
    {
        {0, 0, 0, 0, 0},
        {0, 0, 1, 0, 0},
        {0, 1, 2, 1, 0},
        {0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {0, 0, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {0, 0, 0, 0, 0}
    },
    {
        {0, 1, 1, 1, 0},
        {1, 0, 0, 0, 1},
        {1, 0, 0, 0, 1},
        {1, 0, 0, 0, 1},
        {0, 1, 1, 1, 0}
    }
}
 
local area = createCombatArea(arr)
combat:setArea(area)

local function animation(pos, playerpos)
    --if not Tile(Position(pos)):hasProperty(CONST_PROP_BLOCKPROJECTILE) then
        if Position(pos):isSightClear(playerpos) then
            Position(pos):sendMagicEffect(CONST_ME_GROUNDSHAKER)
        end
    --end
end

function onCastSpell(creature, var)

    local creaturepos = creature:getPosition()
    local playerpos = Position(creaturepos)
    local delay = 200
 
    local centre = {}
    local damagearea = {}
    for j = 1, #animationarea do
        for k,v in ipairs(animationarea[j]) do
            for i = 1, #v do
                --print(v[i])
                if v[i] == 3 or v[i] == 2 then
                    centre.Row = k
                    centre.Column = i
                    table.insert(damagearea, centre)
                elseif v[i] == 1 then
                    local darea = {}
                    darea.Row = k
                    darea.Column = i
                    darea.Delay = j * delay
                    table.insert(damagearea, darea)
                end
            end
        end
        --print(centre.Column .. "," .. centre.Row)
    end

    local target = creature:getTarget()

    for i = 1,#damagearea do
        local level = 200
        local maglevel = 90

        local min = (level / 5) + (maglevel * 1.4) + 8
        local max = (level / 5) + (maglevel * 2.2) + 14
        local damage = math.random(min, max)

        --print(damagearea[i].Column .. "," .. damagearea[i].Row)
        local modifierx = damagearea[i].Column - centre.Column
        local modifiery = damagearea[i].Row - centre.Row
        --print("x " .. modifierx .. " " .. "y " .. modifiery)
        local damagepos = Position(creaturepos)
        damagepos.x = damagepos.x + modifierx
        damagepos.y = damagepos.y + modifiery

        local tilePos = Tile(Position(damagepos.x,damagepos.y,damagepos.z))
        local tileCreature = tilePos:getTopCreature()
        if tileCreature ~= nil then
            if tileCreature ~= creature then
            	if tileCreature:getName() ~= creature:getName() then
	                tileCreature:animatedAddHealth(damage) 
            	end
            end
        end

        --print("Damage: " .. damagepos.x .. "," .. damagepos.y .. "," .. damagepos.z)
        local animationDelay = damagearea[i].Delay or 0
        addEvent(animation, animationDelay, damagepos, playerpos)
    end
    return combat:execute(creature, var)
end