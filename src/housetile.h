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

#ifndef FS_HOUSETILE_H_57D59BEC1CE741D9B142BFC54634505B
#define FS_HOUSETILE_H_57D59BEC1CE741D9B142BFC54634505B

#include "tile.h"

class House;

class HouseTile final : public DynamicTile
{
	public:
		HouseTile(int32_t x, int32_t y, int32_t z, House* house);

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const final;

		Tile* queryDestination(int32_t& index, const Thing& thing, Item** destItem,
				uint32_t& flags) final;

		void addThing(int32_t index, Thing* thing) final;
		void internalAddThing(uint32_t index, Thing* thing) final;

		House* getHouse() {
			return house;
		}

	private:
		void updateHouse(Item* item);

		House* house;
};

#endif
