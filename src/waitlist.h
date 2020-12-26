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

#ifndef FS_WAITLIST_H_7E4299E552E44F10BC4F4E50BF3D7241
#define FS_WAITLIST_H_7E4299E552E44F10BC4F4E50BF3D7241

#include "player.h"

struct Wait {
	constexpr Wait(int64_t timeout, uint32_t playerGUID) :
		timeout(timeout), playerGUID(playerGUID) {}

	int64_t timeout;
	uint32_t playerGUID;
};

typedef std::list<Wait> WaitList;
typedef WaitList::iterator WaitListIterator;

class WaitingList
{
	public:
		static WaitingList* getInstance() {
			static WaitingList waitingList;
			return &waitingList;
		}

		bool clientLogin(const Player* player);
		uint32_t getClientSlot(const Player* player);
		static uint32_t getTime(uint32_t slot);

	protected:
		WaitList priorityWaitList;
		WaitList waitList;

		static uint32_t getTimeout(uint32_t slot);
		WaitListIterator findClient(const Player* player, uint32_t& slot);
		static void cleanupList(WaitList& list);
};

#endif
