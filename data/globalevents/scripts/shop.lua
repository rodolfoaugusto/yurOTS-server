function onThink(interval, lastExecution, thinkInterval)
	local players = Game.getPlayers()
	for _, targetPlayer in ipairs(players) do
		if targetPlayer then
			targetPlayer:shop()
		end
	end
	return true
end