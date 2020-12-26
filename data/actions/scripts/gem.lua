local weaponTypes = {WEAPON_SWORD,WEAPON_CLUB,WEAPON_AXE}

local attrConfig = {maxValue = 10}  -- FROM ORIGINAL VALUE,
local attrs = {
				--[1] = {code = ITEM_ATTRIBUTE_ARMOR,effect=CONST_ME_MAGIC_RED},
				[1] = {code = ITEM_ATTRIBUTE_LIFELEECH,effect=CONST_ME_MAGIC_GREEN},
				[2] = {code = ITEM_ATTRIBUTE_MANALEECH,effect=CONST_ME_MAGIC_BLUE},
				[3] = {code = ITEM_ATTRIBUTE_CRITICAL,effect=CONST_ME_CRITICAL_DAMAGE},
				[4] = {code = ITEM_ATTRIBUTE_ATTACK,effect=CONST_ME_DRAWBLOOD,base=true},
				[5] = {code = ITEM_ATTRIBUTE_DEFENSE,effect=CONST_ME_BLOCKHIT,base=true}
			}
local gemsEeffect = {
						[5245] = {	
									chance = 10,
								},
						[5246] = {chance = 15},
						[5247] = {chance = 35},
						[5248] = {chance = 50},
						[5249] = {chance = 100},
					}

function onUse(player, item, fromPosition, target, toPosition)
	if target:isItem() == nil then
		return false
	end
	if not target:isItem() then
		return false
	end

	local itemTarget = target:getId()
	local itemtype = ItemType(itemTarget)
	local weapontype = itemtype:getWeaponType()

	if not table.contains(weaponTypes, weapontype) then
		return false
	end
	local attrEnchantCount = target:getCustomAttribute('maxattr')
	if attrEnchantCount == nil then 
		attrEnchantCount = 1
	end
	if(attrEnchantCount > 10) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "This equipment cannot be enchanted more than 10 times.")
		return false
	end

	if item:remove(1) then
		local currentGem = gemsEeffect[item:getId()]
		if math.random(1, 100) <= math.min(math.max(10, currentGem.chance)) then
			local randomAttr = math.random(1,#attrs)

			local getCurrentAttr = target:getAttribute(attrs[randomAttr].code)

			if getCurrentAttr == nil or getCurrentAttr == 0 then
				getCurrentAttr = 1
				if attrs[randomAttr].base then
					if attrs[randomAttr].code == ITEM_ATTRIBUTE_ATTACK then
						getCurrentAttr = itemtype:getAttack() + 1
					elseif attrs[randomAttr].code == ITEM_ATTRIBUTE_DEFENSE then
						getCurrentAttr = itemtype:getDefense() + 1
					end
				end
			else
				getCurrentAttr = (getCurrentAttr+1)
			end

			if math.random(1, 100) <= math.min(math.max(10, (1+attrEnchantCount))) then
				if item:getId() ~= 5249 then
					player:say('Crack..!', TALKTYPE_MONSTER_SAY)
					target:remove()
				end
			else
				target:setAttribute(attrs[randomAttr].code, getCurrentAttr)
				target:setCustomAttribute('maxattr',(attrEnchantCount+1))
				target:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION,'This equipment was enchanted '..attrEnchantCount..' time'..(attrEnchantCount == 1 and '' or 's')..'.')
				target:getPosition():sendMagicEffect(attrs[randomAttr].effect)
			end
		end
	end
	
	return true
end
