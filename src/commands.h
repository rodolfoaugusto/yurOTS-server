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

#ifndef FS_COMMANDS_H_C95A575CCADF434699D26CD042690970
#define FS_COMMANDS_H_C95A575CCADF434699D26CD042690970

#include "enums.h"

class Player;

struct Command;
struct s_defcommands;

class Commands
{
	public:
		Commands();
		~Commands();

		// non-copyable
		Commands(const Commands&) = delete;
		Commands& operator=(const Commands&) = delete;

		bool loadFromXml();
		bool reload();

		bool exeCommand(Player& player, const std::string& cmd);

	protected:
		//commands
		void reloadInfo(Player& player, const std::string& param);
		void sellHouse(Player& player, const std::string& param);
		void forceRaid(Player& player, const std::string& param);

		//table of commands
		static s_defcommands defined_commands[];

		std::map<std::string, Command*> commandMap;
};

typedef void (Commands::*CommandFunc)(Player&, const std::string&);

struct Command {
	Command(CommandFunc f, uint32_t groupId, AccountType_t accountType, bool log)
		: f(f), groupId(groupId), accountType(accountType), log(log) {}

	CommandFunc f;
	uint32_t groupId;
	AccountType_t accountType;
	bool log;
};

struct s_defcommands {
	const char* name;
	CommandFunc f;
};

#endif
