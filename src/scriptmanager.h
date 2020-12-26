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

#ifndef FS_SCRIPTMANAGER_H_F9428B7803A44FB88EB1A915CFD37F8B
#define FS_SCRIPTMANAGER_H_F9428B7803A44FB88EB1A915CFD37F8B

class ScriptingManager
{
	public:
		ScriptingManager() = default;
		~ScriptingManager();

		// non-copyable
		ScriptingManager(const ScriptingManager&) = delete;
		ScriptingManager& operator=(const ScriptingManager&) = delete;

		static ScriptingManager* getInstance() {
			static ScriptingManager instance;
			return &instance;
		}

		bool loadScriptSystems();
};

#endif
