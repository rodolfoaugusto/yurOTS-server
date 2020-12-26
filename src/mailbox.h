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

#ifndef FS_MAILBOX_H_D231C6BE8D384CAAA3AE410C1323F9DB
#define FS_MAILBOX_H_D231C6BE8D384CAAA3AE410C1323F9DB

#include "item.h"
#include "cylinder.h"
#include "const.h"

class Mailbox final : public Item, public Cylinder
{
	public:
		explicit Mailbox(uint16_t itemId) : Item(itemId) {}

		Mailbox* getMailbox() final {
			return this;
		}
		const Mailbox* getMailbox() const final {
			return this;
		}

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const final;
		ReturnValue queryMaxCount(int32_t index, const Thing& thing, uint32_t count,
				uint32_t& maxQueryCount, uint32_t flags) const final;
		ReturnValue queryRemove(const Thing& thing, uint32_t count, uint32_t flags) const final;
		Cylinder* queryDestination(int32_t& index, const Thing& thing, Item** destItem,
				uint32_t& flags) final;

		void addThing(Thing* thing) final;
		void addThing(int32_t index, Thing* thing) final;

		void updateThing(Thing* thing, uint16_t itemId, uint32_t count) final;
		void replaceThing(uint32_t index, Thing* thing) final;

		void removeThing(Thing* thing, uint32_t count) final;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;

	private:
		bool getDestination(Item* item, std::string& name, std::string& town) const;
		bool sendItem(Item* item) const;

		static bool canSend(const Item* item);
};

#endif
