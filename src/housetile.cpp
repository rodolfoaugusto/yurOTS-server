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

#include "housetile.h"
#include "house.h"
#include "game.h"

extern Game g_game;

HouseTile::HouseTile(int32_t x, int32_t y, int32_t z, House* house) :
	DynamicTile(x, y, z), house(house) {}

void HouseTile::addThing(int32_t index, Thing* thing)
{
	Tile::addThing(index, thing);

	if (!thing->getParent()) {
		return;
	}

	if (Item* item = thing->getItem()) {
		updateHouse(item);
	}
}

void HouseTile::internalAddThing(uint32_t index, Thing* thing)
{
	Tile::internalAddThing(index, thing);

	if (!thing->getParent()) {
		return;
	}

	if (Item* item = thing->getItem()) {
		updateHouse(item);
	}
}

void HouseTile::updateHouse(Item* item)
{
	if (item->getParent() != this) {
		return;
	}

	Door* door = item->getDoor();
	if (door) {
		if (door->getDoorId() != 0) {
			house->addDoor(door);
		}
	} else {
		BedItem* bed = item->getBed();
		if (bed) {
			house->addBed(bed);
		}
	}
}

ReturnValue HouseTile::queryAdd(int32_t index, const Thing& thing, uint32_t count, uint32_t flags, Creature* actor/* = nullptr*/) const
{
	if (const Creature* creature = thing.getCreature()) {
		if (const Player* player = creature->getPlayer()) {
			if (!house->isInvited(player)) {
				return RETURNVALUE_PLAYERISNOTINVITED;
			}
		} else {
			return RETURNVALUE_NOTPOSSIBLE;
		}
	} else if (thing.getItem() && actor) {
		Player* actorPlayer = actor->getPlayer();
		if (!house->isInvited(actorPlayer)) {
			return RETURNVALUE_CANNOTTHROW;
		}
	}
	return Tile::queryAdd(index, thing, count, flags, actor);
}

Tile* HouseTile::queryDestination(int32_t& index, const Thing& thing, Item** destItem, uint32_t& flags)
{
	if (const Creature* creature = thing.getCreature()) {
		if (const Player* player = creature->getPlayer()) {
			if (!house->isInvited(player)) {
				const Position& entryPos = house->getEntryPosition();
				Tile* destTile = g_game.map.getTile(entryPos);
				if (!destTile) {
					std::cout << "Error: [HouseTile::queryDestination] House entry not correct"
					          << " - Name: " << house->getName()
					          << " - House id: " << house->getId()
					          << " - Tile not found: " << entryPos << std::endl;

					destTile = g_game.map.getTile(player->getTemplePosition());
					if (!destTile) {
						destTile = &(Tile::nullptr_tile);
					}
				}

				index = -1;
				*destItem = nullptr;
				return destTile;
			}
		}
	}

	return Tile::queryDestination(index, thing, destItem, flags);
}
