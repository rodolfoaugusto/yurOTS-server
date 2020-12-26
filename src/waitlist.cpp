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

#include "configmanager.h"
#include "game.h"
#include "waitlist.h"

extern ConfigManager g_config;
extern Game g_game;

WaitListIterator WaitingList::findClient(const Player* player, uint32_t& slot)
{
	slot = 1;
	for (auto it = priorityWaitList.begin(), end = priorityWaitList.end(); it != end; ++it) {
		if (it->playerGUID == player->getGUID()) {
			return it;
		}
		++slot;
	}

	for (auto it = waitList.begin(), end = waitList.end(); it != end; ++it) {
		if (it->playerGUID == player->getGUID()) {
			return it;
		}
		++slot;
	}
	return waitList.end();
}

uint32_t WaitingList::getTime(uint32_t slot)
{
	if (slot < 5) {
		return 5;
	} else if (slot < 10) {
		return 10;
	} else if (slot < 20) {
		return 20;
	} else if (slot < 50) {
		return 60;
	} else {
		return 120;
	}
}

uint32_t WaitingList::getTimeout(uint32_t slot)
{
	//timeout is set to 15 seconds longer than expected retry attempt
	return getTime(slot) + 15;
}

bool WaitingList::clientLogin(const Player* player)
{
	if (player->hasFlag(PlayerFlag_CanAlwaysLogin) || player->getAccountType() >= ACCOUNT_TYPE_GAMEMASTER) {
		return true;
	}

	uint32_t maxPlayers = static_cast<uint32_t>(g_config.getNumber(ConfigManager::MAX_PLAYERS));
	if (maxPlayers == 0 || (priorityWaitList.empty() && waitList.empty() && g_game.getPlayersOnline() < maxPlayers)) {
		return true;
	}

	WaitingList::cleanupList(priorityWaitList);
	WaitingList::cleanupList(waitList);

	uint32_t slot;

	auto it = findClient(player, slot);
	if (it != waitList.end()) {
		if ((g_game.getPlayersOnline() + slot) <= maxPlayers) {
			//should be able to login now
			waitList.erase(it);
			return true;
		}

		//let them wait a bit longer
		it->timeout = OTSYS_TIME() + (getTimeout(slot) * 1000);
		return false;
	}

	slot = priorityWaitList.size();
	if (player->isPremium()) {
		priorityWaitList.emplace_back(OTSYS_TIME() + (getTimeout(slot + 1) * 1000), player->getGUID());
	} else {
		slot += waitList.size();
		waitList.emplace_back(OTSYS_TIME() + (getTimeout(slot + 1) * 1000), player->getGUID());
	}
	return false;
}

uint32_t WaitingList::getClientSlot(const Player* player)
{
	uint32_t slot;
	auto it = findClient(player, slot);
	if (it == waitList.end()) {
		return 0;
	}
	return slot;
}

void WaitingList::cleanupList(WaitList& list)
{
	int64_t time = OTSYS_TIME();

	auto it = list.begin(), end = list.end();
	while (it != end) {
		if ((it->timeout - time) <= 0) {
			it = list.erase(it);
		} else {
			++it;
		}
	}
}
