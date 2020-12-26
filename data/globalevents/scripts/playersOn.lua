function onThink(interval, lastExecution, thinkInterval)
	addEvent(broadcastMessage, 150, (#Game.getPlayers()+configManager.getNumber(configKeys.EXTRA_ONLINE)) .." players online.", MESSAGE_STATUS_DEFAULT)
	return true
end