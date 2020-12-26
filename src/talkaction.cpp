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

#include "player.h"
#include "talkaction.h"
#include "pugicast.h"

TalkActions::TalkActions()
	: scriptInterface("TalkAction Interface")
{
	scriptInterface.initState();
}

TalkActions::~TalkActions()
{
	clear();
}

void TalkActions::clear()
{
	for (TalkAction* talkAction : talkActions) {
		delete talkAction;
	}
	talkActions.clear();

	scriptInterface.reInitState();
}

LuaScriptInterface& TalkActions::getScriptInterface()
{
	return scriptInterface;
}

std::string TalkActions::getScriptBaseName() const
{
	return "talkactions";
}

Event* TalkActions::getEvent(const std::string& nodeName)
{
	if (strcasecmp(nodeName.c_str(), "talkaction") != 0) {
		return nullptr;
	}
	return new TalkAction(&scriptInterface);
}

bool TalkActions::registerEvent(Event* event, const pugi::xml_node&)
{
	talkActions.push_front(static_cast<TalkAction*>(event)); // event is guaranteed to be a TalkAction
	return true;
}

TalkActionResult_t TalkActions::playerSaySpell(Player* player, SpeakClasses type, const std::string& words) const
{
	size_t wordsLength = words.length();
	for (TalkAction* talkAction : talkActions) {
		const std::string& talkactionWords = talkAction->getWords();
		size_t talkactionLength = talkactionWords.length();
		if (wordsLength < talkactionLength || strncasecmp(words.c_str(), talkactionWords.c_str(), talkactionLength) != 0) {
			continue;
		}

		std::string param;
		if (wordsLength != talkactionLength) {
			param = words.substr(talkactionLength);
			if (param.front() != ' ') {
				continue;
			}
			trim_left(param, ' ');

			char separator = talkAction->getSeparator();
			if (separator != ' ') {
				if (!param.empty()) {
					if (param.front() != separator) {
						continue;
					} else {
						param.erase(param.begin());
					}
				}
			}
		}

		if (talkAction->executeSay(player, param, type)) {
			return TALKACTION_CONTINUE;
		} else {
			return TALKACTION_BREAK;
		}
	}
	return TALKACTION_CONTINUE;
}

bool TalkAction::configureEvent(const pugi::xml_node& node)
{
	pugi::xml_attribute wordsAttribute = node.attribute("words");
	if (!wordsAttribute) {
		std::cout << "[Error - TalkAction::configureEvent] Missing words for talk action or spell" << std::endl;
		return false;
	}

	pugi::xml_attribute separatorAttribute = node.attribute("separator");
	if (separatorAttribute) {
		separator = pugi::cast<char>(separatorAttribute.value());
	}

	words = wordsAttribute.as_string();
	return true;
}

std::string TalkAction::getScriptEventName() const
{
	return "onSay";
}

bool TalkAction::executeSay(Player* player, const std::string& param, SpeakClasses type) const
{
	//onSay(player, words, param, type)
	if (!scriptInterface->reserveScriptEnv()) {
		std::cout << "[Error - TalkAction::executeSay] Call stack overflow" << std::endl;
		return false;
	}

	ScriptEnvironment* env = scriptInterface->getScriptEnv();
	env->setScriptId(scriptId, scriptInterface);

	lua_State* L = scriptInterface->getLuaState();

	scriptInterface->pushFunction(scriptId);

	LuaScriptInterface::pushUserdata<Player>(L, player);
	LuaScriptInterface::setMetatable(L, -1, "Player");

	LuaScriptInterface::pushString(L, words);
	LuaScriptInterface::pushString(L, param);
	lua_pushnumber(L, type);

	return scriptInterface->callFunction(4);
}
