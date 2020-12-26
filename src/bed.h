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

#ifndef FS_BED_H_84DE19758D424C6C9789189231946BFF
#define FS_BED_H_84DE19758D424C6C9789189231946BFF

#include "item.h"

class House;
class Player;

class BedItem final : public Item
{
	public:
		explicit BedItem(uint16_t id);

		BedItem* getBed() final {
			return this;
		}
		const BedItem* getBed() const final {
			return this;
		}

		Attr_ReadValue readAttr(AttrTypes_t attr, PropStream& propStream) final;
		void serializeAttr(PropWriteStream& propWriteStream) const final;

		bool canRemove() const final {
			return house == nullptr;
		}

		uint32_t getSleeper() const {
			return sleeperGUID;
		}

		House* getHouse() const {
			return house;
		}
		void setHouse(House* h) {
			house = h;
		}

		bool canUse(Player* player);

		bool trySleep(Player* player);
		bool sleep(Player* player);
		void wakeUp(Player* player);

		BedItem* getNextBedItem() const;

	protected:
		void updateAppearance(const Player* player);
		void regeneratePlayer(Player* player) const;
		void internalSetSleeper(const Player* player);
		void internalRemoveSleeper();

		House* house = nullptr;
		uint64_t sleepStart;
		uint32_t sleeperGUID;
};

#endif
