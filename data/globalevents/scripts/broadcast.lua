function onThink(interval, lastExecution, thinkInterval)
	local msgs = {
					'Enter in discord server to receive in first hand the information about new updates: https://discord.gg/vKe9bqy',
					'Help and get helped! The game can be better with cooperation.',
					'Have a great idea to improve server quality? Enter in your Discord server: https://discord.gg/vKe9bqy',
				}
	local choosed = math.random(1,#msgs)
	addEvent(broadcastMessage, 150, msgs[choosed], MESSAGE_STATUS_DEFAULT)
	return true
end