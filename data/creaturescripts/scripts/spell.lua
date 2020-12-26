function onAdvance(player, skill, oldLevel, newLevel)
    if skill ~= SKILL_MAGLEVEL then
        return true
    end

	
	local count = getPlayerInstantSpellCount(player)
	local text = nil
	local spells = {}
	for i = 0, count - 1 do
		local spell = getPlayerInstantSpellInfo(player, i)
		if spell.mlevel ~= (nil) and spell.mana > 0 then
			if spell.manapercent > 0 then
				spell.mana = spell.manapercent .. "%"
			end
			spells[#spells + 1] = spell
		end
	end

	table.sort(spells, function(a, b) return a.mlevel < b.mlevel end)

	for i, spell in ipairs(spells) do
		local line = ""
		if newLevel == spell.mlevel then
			if i ~= 1 then
				line = "\n"
			end
			if text == nil then
				text=''
			end
			text = text .. line .. "   " .. spell.words .. " - " .. spell.name .. " : " .. spell.mana .. "\n"
		end
	end
	if text ~= nil then
		text = "Now you have available:" .. text
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE,text)
	end
	return true

end