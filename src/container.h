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

#ifndef FS_CONTAINER_H_5590165FD8A2451B98D71F13CD3ED8DC
#define FS_CONTAINER_H_5590165FD8A2451B98D71F13CD3ED8DC

#include <queue>

#include "cylinder.h"
#include "item.h"

class Container;
class DepotLocker;

class ContainerIterator
{
	public:
		bool hasNext() const {
			return !over.empty();
		}

		void advance();
		Item* operator*();

	protected:
		std::list<const Container*> over;
		ItemDeque::const_iterator cur;

		friend class Container;
};

class Container : public Item, public Cylinder
{
	public:
		explicit Container(uint16_t type);
		Container(uint16_t type, uint16_t size);
		~Container();

		// non-copyable
		Container(const Container&) = delete;
		Container& operator=(const Container&) = delete;

		Item* clone() const final;

		Container* getContainer() final {
			return this;
		}
		const Container* getContainer() const final {
			return this;
		}

		virtual DepotLocker* getDepotLocker() {
			return nullptr;
		}
		virtual const DepotLocker* getDepotLocker() const {
			return nullptr;
		}

		Attr_ReadValue readAttr(AttrTypes_t attr, PropStream& propStream) override;
		bool unserializeItemNode(FileLoader& f, NODE node, PropStream& propStream) override;
		std::string getContentDescription() const;

		size_t size() const {
			return itemlist.size();
		}
		bool empty() const {
			return itemlist.empty();
		}
		uint32_t capacity() const {
			return maxSize;
		}

		ContainerIterator iterator() const;

		const ItemDeque& getItemList() const {
			return itemlist;
		}

		ItemDeque::const_reverse_iterator getReversedItems() const {
			return itemlist.rbegin();
		}
		ItemDeque::const_reverse_iterator getReversedEnd() const {
			return itemlist.rend();
		}

		bool hasParent() const;
		void addItem(Item* item);
		Item* getItemByIndex(size_t index) const;
		bool isHoldingItem(const Item* item) const;

		uint32_t getItemHoldingCount() const;
		uint32_t getWeight() const final;

		//cylinder implementations
		virtual ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const override;
		ReturnValue queryMaxCount(int32_t index, const Thing& thing, uint32_t count, uint32_t& maxQueryCount,
				uint32_t flags) const final;
		ReturnValue queryRemove(const Thing& thing, uint32_t count, uint32_t flags) const final;
		Cylinder* queryDestination(int32_t& index, const Thing& thing, Item** destItem,
				uint32_t& flags) final;

		void addThing(Thing* thing) final;
		void addThing(int32_t index, Thing* thing) final;
		void addItemBack(Item* item);

		void updateThing(Thing* thing, uint16_t itemId, uint32_t count) final;
		void replaceThing(uint32_t index, Thing* thing) final;

		void removeThing(Thing* thing, uint32_t count) final;

		int32_t getThingIndex(const Thing* thing) const final;
		size_t getFirstIndex() const final;
		size_t getLastIndex() const final;
		uint32_t getItemTypeCount(uint16_t itemId, int32_t subType = -1) const final;
		std::map<uint32_t, uint32_t>& getAllItemTypeCount(std::map<uint32_t, uint32_t>& countMap) const final;
		Thing* getThing(size_t index) const final;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) override;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) override;

		void internalAddThing(Thing* thing) final;
		void internalAddThing(uint32_t index, Thing* thing) final;
		void startDecaying() final;

	private:
		void onAddContainerItem(Item* item);
		void onUpdateContainerItem(uint32_t index, Item* oldItem, Item* newItem);
		void onRemoveContainerItem(uint32_t index, Item* item);

		Container* getParentContainer();
		void updateItemWeight(int32_t diff);

	protected:
		std::ostringstream& getContentDescription(std::ostringstream& os) const;

		uint32_t maxSize;
		uint32_t totalWeight = 0;
		ItemDeque itemlist;
		uint32_t serializationCount = 0;

		friend class ContainerIterator;
		friend class IOMapSerialize;
};

#endif
