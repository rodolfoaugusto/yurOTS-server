-- Combat settings
-- NOTE: valid values for worldType are: "pvp", "no-pvp" and "pvp-enforced"
worldType = "pvp"
protectionLevel = 50
pzLocked = 60000
removeChargesFromRunes = true
stairJumpExhaustion = 0
experienceByKillingPlayers = false
expFromPlayersLevelRange = 75

-- Skull System
banLength = 2 * 24 * 60 * 60
whiteSkullTime = 15 * 60
redSkullTime = 2 * 24 * 60 * 60
killsDayRedSkull = 5
killsWeekRedSkull = 14
killsMonthRedSkull = 38
killsDayBanishment = 8
killsWeekBanishment = 26
killsMonthBanishment = 52

-- Connection Config
-- NOTE: maxPlayers set to 0 means no limit
ip = "127.0.0.1"
bindOnlyGlobalAddress = false
loginProtocolPort = 7171
gameProtocolPort = 7373
statusProtocolPort = 7272
maxPlayers = 0
motd = "HAPPY NEW YEAR!\n\nYurOTS."
onePlayerOnlinePerAccount = true
allowClones = false
serverName = "YurOTS"
statusTimeout = 5000
replaceKickOnLogin = true
maxPacketsPerSecond = 50
autoStackCumulatives = true
moneyRate = 1
runesCharges = 2
extraOnline = 1

-- Deaths
-- NOTE: Leave deathLosePercent as -1 if you want to use the default
-- death penalty formula. For the old formula, set it to 10. For
-- no skill/experience loss, set it to 0.
deathLosePercent = 10

-- Houses
houseRentPeriod = "weekly"

-- Item Usage
timeBetweenActions = 600
timeBetweenExActions = 900

-- Map
-- NOTE: set mapName WITHOUT .otbm at the end
mapName = "map"
mapAuthor = "Yurez - Rodi"

-- MySQL
mysqlHost = "127.0.0.1"
mysqlUser = "root"
mysqlPass = ""
mysqlDatabase = "yurots"
mysqlPort = 3306
mysqlSock = ""

-- Misc.
allowChangeOutfit = true
freePremium = false
kickIdlePlayerAfterMinutes = 60 * 24
maxMessageBuffer = 4
showMonsterLoot = true
queryPlayerContainers = false

-- Character Rooking
-- Level threshold is the level requirement to teleport players back to newbie town
teleportNewbies = false
newbieTownId = 1
newbieLevelThreshold = 5

-- Rates
-- NOTE: rateExp is not used if you have enabled stages in data/XML/stages.xml
rateExp = 1
rateSkill = 1
rateMagic = 1
rateLoot = 1
rateSpawn = 1

-- Monsters
deSpawnRange = 99999
deSpawnRadius = 99999

-- Scripts
warnUnsafeScripts = true
convertUnsafeScripts = true

-- Startup
-- NOTE: defaultPriority only works on Windows and sets process
-- priority, valid values are: "normal", "above-normal", "high"
defaultPriority = "high"
startupDatabaseOptimization = false

-- Status server information
ownerName = ""
ownerEmail = "yourEmail@gmail.com"
url = "https://127.0.0.1/"
location = "Canada"