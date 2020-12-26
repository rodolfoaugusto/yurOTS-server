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

#ifndef FS_THING_H_6F16A8E566AF4ACEAE02CF32A7246144
#define FS_THING_H_6F16A8E566AF4ACEAE02CF32A7246144

#include "position.h"

class Tile;
class Cylinder;
class Item;
class Creature;
class Container;

class Thing
{
	protected:
		constexpr Thing() = default;
		~Thing() = default;

	public:
		// non-copyable
		Thing(const Thing&) = delete;
		Thing& operator=(const Thing&) = delete;

		virtual std::string getDescription(int32_t lookDistance) const = 0;

		virtual Cylinder* getParent() const {
			return nullptr;
		}
		virtual Cylinder* getRealParent() const {
			return getParent();
		}

		virtual void setParent(Cylinder*) {
			//
		}

		virtual Tile* getTile();
		virtual const Tile* getTile() const;

		virtual const Position& getPosition() const;
		virtual int32_t getThrowRange() const = 0;
		virtual bool isPushable() const = 0;

		virtual Container* getContainer() {
			return nullptr;
		}
		virtual const Container* getContainer() const {
			return nullptr;
		}
		virtual Item* getItem() {
			return nullptr;
		}
		virtual const Item* getItem() const {
			return nullptr;
		}
		virtual Creature* getCreature() {
			return nullptr;
		}
		virtual const Creature* getCreature() const {
			return nullptr;
		}

		virtual bool isRemoved() const {
			return true;
		}
};

#endif
