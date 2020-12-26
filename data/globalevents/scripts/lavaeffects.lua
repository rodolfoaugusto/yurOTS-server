function onThink(interval, lastExecution, thinkInterval)
	
	local spectators = Game.getSpectators(Position(5968,6087,10), false, false, 7, 7, 7, 7)
	local spots = {
			{pos=Position(5968,6086,10),effect=CONST_ME_MORTAREA},
			{pos=Position(5966,6088,10),effect=CONST_ME_MORTAREA},
			{pos=Position(5969,6087,10),effect=CONST_ME_MORTAREA},
		}

	if #spectators > 0 then
		for i=1,#spots do
			local chance = math.random(1,5)
			if chance >= 3 then
				spots[i].pos:sendMagicEffect(spots[i].effect)
			end
		end
	end

	return true
end