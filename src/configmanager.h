/*
 * YurOTS, a free game server emulator 
 * Official Repository on Github <https://github.com/rodolfoaugusto/yurOTS-server>
 * Copyright (C) 2020 - Rodi <https://github.com/rodolfoaugusto>
 * A fork of The Forgotten Server(Mark Samman) branch 1.2 and part of Nostalrius(Alejandro Mujica) repositories.
 *
 * The MIT License (MIT). Copyright © 2020 <YurOTS>
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 * to deal in the Software without restriction, including without limitation 
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
*/

#ifndef FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39
#define FS_CONFIGMANAGER_H_6BDD23BD0B8344F4B7C40E8BE6AF6F39

#include <lua.hpp>

class ConfigManager
{
	public:
		enum boolean_config_t {
			SHOW_MONSTER_LOOT,
			ALLOW_CHANGEOUTFIT,
			ONE_PLAYER_ON_ACCOUNT,
			REMOVE_RUNE_CHARGES,
			EXPERIENCE_FROM_PLAYERS,
			FREE_PREMIUM,
			REPLACE_KICK_ON_LOGIN,
			ALLOW_CLONES,
			BIND_ONLY_GLOBAL_ADDRESS,
			OPTIMIZE_DATABASE,
			WARN_UNSAFE_SCRIPTS,
			CONVERT_UNSAFE_SCRIPTS,
			TELEPORT_NEWBIES,
			STACK_CUMULATIVES,
			QUERY_PLAYER_CONTAINERS,

			LAST_BOOLEAN_CONFIG /* this must be the last one */
		};

		enum string_config_t {
			DUMMY_STR,
			MAP_NAME,
			HOUSE_RENT_PERIOD,
			SERVER_NAME,
			OWNER_NAME,
			OWNER_EMAIL,
			URL,
			LOCATION,
			IP,
			MOTD,
			WORLD_TYPE,
			MYSQL_HOST,
			MYSQL_USER,
			MYSQL_PASS,
			MYSQL_DB,
			MYSQL_SOCK,
			DEFAULT_PRIORITY,
			MAP_AUTHOR,

			LAST_STRING_CONFIG /* this must be the last one */
		};

		enum integer_config_t {
			SQL_PORT,
			MAX_PLAYERS,
			PZ_LOCKED,
			DEFAULT_DESPAWNRANGE,
			DEFAULT_DESPAWNRADIUS,
			RATE_EXPERIENCE,
			RATE_SKILL,
			RATE_MAGIC,
			RATE_LOOT,
			RATE_SPAWN,
			BAN_LENGTH,
			MAX_MESSAGEBUFFER,
			ACTIONS_DELAY_INTERVAL,
			EX_ACTIONS_DELAY_INTERVAL,
			KICK_AFTER_MINUTES,
			PROTECTION_LEVEL,
			DEATH_LOSE_PERCENT,
			STATUSQUERY_TIMEOUT,
			WHITE_SKULL_TIME,
			RED_SKULL_TIME,
			KILLS_DAY_RED_SKULL,
			KILLS_WEEK_RED_SKULL,
			KILLS_MONTH_RED_SKULL,
			KILLS_DAY_BANISHMENT,
			KILLS_WEEK_BANISHMENT,
			KILLS_MONTH_BANISHMENT,
			GAME_PORT,
			LOGIN_PORT,
			STATUS_PORT,
			STAIRHOP_DELAY,
			EXP_FROM_PLAYERS_LEVEL_RANGE,
			MAX_PACKETS_PER_SECOND,
			NEWBIE_TOWN,
			NEWBIE_LEVEL_THRESHOLD,
			MONEY_RATE,
			EXTRA_ONLINE,
			RUNES_CHARGES,
			LAST_INTEGER_CONFIG /* this must be the last one */
		};

		bool load();
		bool reload();

		const std::string& getString(string_config_t what) const;
		int32_t getNumber(integer_config_t what) const;
		bool getBoolean(boolean_config_t what) const;

	private:
		static std::string getGlobalString(lua_State* L, const char* identifier, const char* defaultValue);
		static int32_t getGlobalNumber(lua_State* L, const char* identifier, const int32_t defaultValue = 0);
		static bool getGlobalBoolean(lua_State* L, const char* identifier, const bool defaultValue);

		std::string string[LAST_STRING_CONFIG] = {};
		int32_t integer[LAST_INTEGER_CONFIG] = {};
		bool boolean[LAST_BOOLEAN_CONFIG] = {};
		bool loaded = false;
};

#endif
