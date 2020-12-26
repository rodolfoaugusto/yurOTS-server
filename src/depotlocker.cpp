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

#include "depotlocker.h"
#include "creature.h"
#include "player.h"
#include "tools.h"

DepotLocker::DepotLocker(uint16_t type) :
	Container(type, 30), depotId(0) {}

Attr_ReadValue DepotLocker::readAttr(AttrTypes_t attr, PropStream& propStream)
{
	if (attr == ATTR_DEPOT_ID) {
		if (!propStream.read<uint16_t>(depotId)) {
			return ATTR_READ_ERROR;
		}
		return ATTR_READ_CONTINUE;
	}
	return Item::readAttr(attr, propStream);
}

ReturnValue DepotLocker::queryAdd(int32_t index, const Thing& thing, uint32_t count, uint32_t flags, Creature* actor) const
{
	const Item* item = thing.getItem();
	if (item == nullptr) {
		return RETURNVALUE_NOTPOSSIBLE;
	}

	bool skipLimit = hasBitSet(FLAG_NOLIMIT, flags);
	if (!skipLimit) {
		int32_t addCount = 0;

		if ((item->isStackable() && item->getItemCount() != count)) {
			addCount = 1;
		}

		if (item->getTopParent() != this) {
			if (const Container* container = item->getContainer()) {
				addCount = container->getItemHoldingCount() + 1;
			} else {
				addCount = 1;
			}
		}

		if (actor) {
			Player* player = actor->getPlayer();
			if (player) {
				if (getItemHoldingCount() + addCount > player->getMaxDepotItems()) {
					return RETURNVALUE_DEPOTISFULL;
				}
			}
		}
	}

	return Container::queryAdd(index, thing, count, flags, actor);
}

void DepotLocker::postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t)
{
	if (parent != nullptr) {
		parent->postAddNotification(thing, oldParent, index, LINK_PARENT);
	}
}

void DepotLocker::postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t)
{
	if (parent != nullptr) {
		parent->postRemoveNotification(thing, newParent, index, LINK_PARENT);
	}
}
