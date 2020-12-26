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

#ifndef FS_ACTIONS_H_87F60C5F587E4B84948F304A6451E6E6
#define FS_ACTIONS_H_87F60C5F587E4B84948F304A6451E6E6

#include "baseevents.h"
#include "enums.h"
#include "luascript.h"

class Action : public Event
{
	public:
		explicit Action(const Action* copy);
		explicit Action(LuaScriptInterface* interface);

		bool configureEvent(const pugi::xml_node& node) override;

		//scripting
		virtual bool executeUse(Player* player, Item* item, const Position& fromPosition,
			Thing* target, const Position& toPosition);
		//

		bool getAllowFarUse() const {
			return allowFarUse;
		}
		void setAllowFarUse(bool v) {
			allowFarUse = v;
		}

		bool getCheckLineOfSight() const {
			return checkLineOfSight;
		}
		void setCheckLineOfSight(bool v) {
			checkLineOfSight = v;
		}

		bool getCheckFloor() const {
			return checkFloor;
		}
		void setCheckFloor(bool v) {
			checkFloor = v;
		}

		virtual ReturnValue canExecuteAction(const Player* player, const Position& toPos);
		virtual bool hasOwnErrorHandler() {
			return false;
		}
		virtual Thing* getTarget(Player* player, Creature* targetCreature, const Position& toPosition, uint8_t toStackPos) const;

	protected:
		std::string getScriptEventName() const override;

		bool allowFarUse;
		bool checkFloor;
		bool checkLineOfSight;
};

class Actions final : public BaseEvents
{
	public:
		Actions();
		~Actions();

		// non-copyable
		Actions(const Actions&) = delete;
		Actions& operator=(const Actions&) = delete;

		bool useItem(Player* player, const Position& pos, uint8_t index, Item* item);
		bool useItemEx(Player* player, const Position& fromPos, const Position& toPos, uint8_t toStackPos, Item* item, Creature* creature = nullptr);

		ReturnValue canUse(const Player* player, const Position& pos);
		ReturnValue canUse(const Player* player, const Position& pos, const Item* item);
		ReturnValue canUseFar(const Creature* creature, const Position& toPos, bool checkLineOfSight, bool checkFloor);

	protected:
		ReturnValue internalUseItem(Player* player, const Position& pos, uint8_t index, Item* item);

		void clear() final;
		LuaScriptInterface& getScriptInterface() final;
		std::string getScriptBaseName() const final;
		Event* getEvent(const std::string& nodeName) final;
		bool registerEvent(Event* event, const pugi::xml_node& node) final;

		typedef std::map<uint16_t, Action*> ActionUseMap;
		ActionUseMap useItemMap;
		ActionUseMap actionItemMap;

		Action* getAction(const Item* item);
		void clearMap(ActionUseMap& map);

		LuaScriptInterface scriptInterface;
};

#endif
