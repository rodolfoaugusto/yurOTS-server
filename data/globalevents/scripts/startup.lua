DailyMonster = 'Amazon'
DailyBonus = 0
function newDailyMonster()
	local daily = {}

	local resultId = db.storeQuery("SELECT `id`,`name` FROM `monsters` WHERE `daily` = 1 ORDER BY RAND() LIMIT 1")
	if resultId ~= false then
		local monsterId = result.getDataInt(resultId, "id")
		local monsterName = result.getDataString(resultId, "name")
		local monsterBonus = math.random(15,35)

		DailyMonster = monsterName
		DailyBonus = monsterBonus

		db.asyncQuery("UPDATE `dailymonster` SET `monster` = ".. monsterId ..",`bonus` = ".. monsterBonus)
		daily = {name=monsterName,bonus=monsterBonus}
		result.free(resultId)
	end
	return daily
end

function onStartup()
	math.randomseed(os.mtime())
	local npcsList = {
						{name='perac',pos=Position(5983,6045,5)},
						{name='darkrodo',pos=Position(5967,6041,6)},
						{name='lector',pos=Position(5966,6040,7)},
						{name='darkrodo',pos=Position(6046,6062,7)},
						{name='seller',pos=Position(6047,6071,7)},
						{name='darkrodo',pos=Position(6166,6075,6)},
						{name='dufi',pos=Position(6173,6069,6)},
						{name='perac',pos=Position(6173,6075,6)},
						{name='captain3',pos=Position(6012,6055,7)},
						{name='captain4',pos=Position(6120,6077,7)},
						{name='captain2',pos=Position(6195,6094,7)},
						{name='angel',pos=Position(6139,6042,7)},
						{name='obi',pos=Position(6012,6037,7)},
						{name='geralt',pos=Position(5971,6021,4)},
					}
	for ni=1,#npcsList do
		Game.createNpc(npcsList[ni].name,npcsList[ni].pos)
	end
	db.query("TRUNCATE TABLE `players_online`")
	db.asyncQuery("DELETE FROM `guild_wars` WHERE `status` = 0")
	db.asyncQuery("DELETE FROM `players` WHERE `deletion` != 0 AND `deletion` < " .. os.time())
	db.asyncQuery("DELETE FROM `ip_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())

	local lastWeek = os.time() - 604800

	--local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `lastlogout` <= " .. lastWeek)
	--if resultId ~= false then
	--	repeat
	--		local playerHId = result.getDataInt(resultId, "id")

			--local getHouse = db.storeQuery("SELECT `id` FROM `houses` WHERE `owner` = " .. playerHId)
			--if getHouse ~= false then
			--	local houseId = result.getDataInt(getHouse, "id")
		--		db.asyncQuery("UPDATE `houses` SET `owner` = 0 WHERE `id` = " .. houseId)
		--	end
		--until not result.next(resultId)
		--result.free(resultId)
	--end

	-- Move expired bans to ban history
	local resultId = db.storeQuery("SELECT * FROM `account_bans` WHERE `expires_at` != 0 AND `expires_at` <= " .. os.time())
	if resultId ~= false then
		repeat
			local accountId = result.getDataInt(resultId, "account_id")
			db.asyncQuery("INSERT INTO `account_ban_history` (`account_id`, `reason`, `banned_at`, `expired_at`, `banned_by`) VALUES (" .. accountId .. ", " .. db.escapeString(result.getDataString(resultId, "reason")) .. ", " .. result.getDataLong(resultId, "banned_at") .. ", " .. result.getDataLong(resultId, "expires_at") .. ", " .. result.getDataInt(resultId, "banned_by") .. ")")
			db.asyncQuery("DELETE FROM `account_bans` WHERE `account_id` = " .. accountId)
		until not result.next(resultId)
		result.free(resultId)
	end
	
	-- Remove murders that are more than 30 days old
	local resultId = db.storeQuery("SELECT * FROM `player_murders` WHERE `date` <= " .. os.time() - 60 * 24 * 60 * 30)
	if resultId ~= false then
		repeat
			local playerId = result.getDataInt(resultId, "player_id")
			local id = result.getDataLong(resultId, "id")
			
			db.asyncQuery("DELETE FROM `player_murders` WHERE `player_id` = " .. playerId .. " AND `id` = " .. id)
		until not result.next(resultId)
		result.free(resultId)
	end

	newDailyMonster()
end
