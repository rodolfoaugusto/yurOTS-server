-- Minimum amount of magic missiles
local minMissiles = 2

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)


local function arcaneDamage(creature, var, target, missileEffectpos, animationroll)
    local creature = Creature(creature)
    local target = Creature(target)
    if creature and target then
        local level = 180
        local magiclevel = 90
        local min = (level / 5) + (magiclevel * 0.2) + 5
        local max = (level / 5) + (magiclevel * 0.8) + 12

        local damage = math.random(min, max)
        if target then
            target:animatedAddHealth(damage)
        end
        Position(missileEffectpos):sendDistanceEffect(target:getPosition(), CONST_ANI_DEATH)
        if animationroll == 1 then
            target:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
        end
        combat:execute(creature, var)
    end
    return true
end

local function arcaneBolt(creature, var, target, count)
    local creature = Creature(creature)
    local target = Creature(target)
    if creature and target then
        local playerpos = creature:getPosition()
        local creaturepos = target:getPosition()
        local missileEffectpos = Position(playerpos)
        local differencey = playerpos.y - creaturepos.y -- positive = N, negative = S
        local differencex = playerpos.x - creaturepos.x -- positive = W, negative = E
        local ymodifier = 0
        local xmodifier = 0
        local animationroll = 0
        
        -- Cycle between each side of player depending if missile is even or odd
        if count % 2 == 0 then -- even
            if differencey > 0 then -- Target it to the N
                xmodifier = xmodifier + 1
                if math.random(1,2) == 2 then
                    ymodifier = ymodifier - 1
                end
            elseif differencey < 0 then -- Target is to the S
                xmodifier = xmodifier - 1
                if differencey < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
                    ymodifier = ymodifier + 1
                end
            end
            if differencex < 0 then -- Target is to the E
                ymodifier = ymodifier + 1
                if differencex < -1 or math.random(1,2) == 2 then
                    xmodifier = xmodifier + 1
                end
            elseif differencex > 0 then -- Target is to the W
                ymodifier = ymodifier - 1
                if math.random(1,2) == 2 then
                    xmodifier = xmodifier - 1
                end
            end
        else -- odd
            animationroll = 1
            if differencey > 0 then -- Target it to the N
                xmodifier = xmodifier - 1
                if math.random(1,2) == 2 then
                    ymodifier = ymodifier - 1
                end
            elseif differencey < 0 then -- Target is to the S
                xmodifier = xmodifier + 1
                if differencey < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
                    ymodifier = ymodifier + 1
                end
            end
            if differencex < 0 then -- Target is to the E
                ymodifier = ymodifier - 1
                if differencex < -1 or math.random(1,2) == 2 then -- Force if 1sqm away due to client perspective
                    xmodifier = xmodifier + 1
                end
            elseif differencex > 0 then -- Target is to the W
                ymodifier = ymodifier + 1
                if math.random(1,2) == 2 then
                    xmodifier = xmodifier - 1
                end
            end
        end
        missileEffectpos.x = missileEffectpos.x + xmodifier
        missileEffectpos.y = missileEffectpos.y + ymodifier
        Position(playerpos):sendDistanceEffect(missileEffectpos, CONST_ANI_DEATH)
        addEvent(arcaneDamage, 150, creature.uid, var, target.uid, missileEffectpos, animationroll)
    end
    return true
end

function onCastSpell(creature, var)
    local magiclevel = 70
    local target = creature:getTarget()
    local missileCount = minMissiles + math.floor(magiclevel / 20) -- extra missile every 20 magic levels
    local count = 1
    for i = 1, missileCount do
        addEvent(arcaneBolt, 150 * (i - 1), creature.uid, var, target.uid, count)
        count = count + 1
    end
    return true
end