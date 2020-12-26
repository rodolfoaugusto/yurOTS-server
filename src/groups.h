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

#ifndef FS_GROUPS_H_EE39438337D148E1983FB79D936DD8F3
#define FS_GROUPS_H_EE39438337D148E1983FB79D936DD8F3

struct Group {
	std::string name;
	uint64_t flags;
	uint32_t maxDepotItems;
	uint32_t maxVipEntries;
	uint16_t id;
	bool access;
};

class Groups {
	public:
		bool load();
		Group* getGroup(uint16_t id);

	private:
		std::vector<Group> groups;
};

#endif
