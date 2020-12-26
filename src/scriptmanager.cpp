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

#include "otpch.h"

#include "scriptmanager.h"

#include "actions.h"
#include "chat.h"
#include "talkaction.h"
#include "spells.h"
#include "movement.h"
#include "globalevent.h"

Actions* g_actions = nullptr;
CreatureEvents* g_creatureEvents = nullptr;
Chat* g_chat = nullptr;
GlobalEvents* g_globalEvents = nullptr;
Spells* g_spells = nullptr;
TalkActions* g_talkActions = nullptr;
MoveEvents* g_moveEvents = nullptr;

extern LuaEnvironment g_luaEnvironment;

ScriptingManager::~ScriptingManager()
{
	delete g_spells;
	delete g_actions;
	delete g_talkActions;
	delete g_moveEvents;
	delete g_chat;
	delete g_creatureEvents;
	delete g_globalEvents;
}

bool ScriptingManager::loadScriptSystems()
{
	if (g_luaEnvironment.loadFile("data/global.lua") == -1) {
		std::cout << "[Warning - ScriptingManager::loadScriptSystems] Can not load data/global.lua" << std::endl;
	}

	g_chat = new Chat();

	g_spells = new Spells();
	if (!g_spells->loadFromXml()) {
		std::cout << "> ERROR: Unable to load spells!" << std::endl;
		return false;
	}

	g_actions = new Actions();
	if (!g_actions->loadFromXml()) {
		std::cout << "> ERROR: Unable to load actions!" << std::endl;
		return false;
	}

	g_talkActions = new TalkActions();
	if (!g_talkActions->loadFromXml()) {
		std::cout << "> ERROR: Unable to load talk actions!" << std::endl;
		return false;
	}

	g_moveEvents = new MoveEvents();
	if (!g_moveEvents->loadFromXml()) {
		std::cout << "> ERROR: Unable to load move events!" << std::endl;
		return false;
	}

	g_creatureEvents = new CreatureEvents();
	if (!g_creatureEvents->loadFromXml()) {
		std::cout << "> ERROR: Unable to load creature events!" << std::endl;
		return false;
	}

	g_globalEvents = new GlobalEvents();
	if (!g_globalEvents->loadFromXml()) {
		std::cout << "> ERROR: Unable to load global events!" << std::endl;
		return false;
	}

	return true;
}
