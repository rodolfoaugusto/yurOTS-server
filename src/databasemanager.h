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

#ifndef FS_DATABASEMANAGER_H_2B75821C555E4D1D83E32B20D683217C
#define FS_DATABASEMANAGER_H_2B75821C555E4D1D83E32B20D683217C
#include "database.h"

class DatabaseManager
{
	public:
		static bool tableExists(const std::string& table);

		static int32_t getDatabaseVersion();
		static bool isDatabaseSetup();

		static bool optimizeTables();

		static bool getDatabaseConfig(const std::string& config, int32_t& value);
		static void registerDatabaseConfig(const std::string& config, int32_t value);
};
#endif
