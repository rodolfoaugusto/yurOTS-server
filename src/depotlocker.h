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

#ifndef FS_DEPOTLOCKER_H_53AD8E0606A34070B87F792611F4F3F8
#define FS_DEPOTLOCKER_H_53AD8E0606A34070B87F792611F4F3F8

#include "container.h"

class DepotLocker final : public Container
{
	public:
		explicit DepotLocker(uint16_t type);

		DepotLocker* getDepotLocker() final {
			return this;
		}
		const DepotLocker* getDepotLocker() const final {
			return this;
		}

		//serialization
		Attr_ReadValue readAttr(AttrTypes_t attr, PropStream& propStream) final;

		uint16_t getDepotId() const {
			return depotId;
		}
		void setDepotId(uint16_t depotId) {
			this->depotId = depotId;
		}

		//cylinder implementations
		ReturnValue queryAdd(int32_t index, const Thing& thing, uint32_t count,
				uint32_t flags, Creature* actor = nullptr) const final;

		void postAddNotification(Thing* thing, const Cylinder* oldParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;
		void postRemoveNotification(Thing* thing, const Cylinder* newParent, int32_t index, cylinderlink_t link = LINK_OWNER) final;

		bool canRemove() const final {
			return false;
		}

	private:
		uint16_t depotId;
};

#endif

