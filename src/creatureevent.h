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

#ifndef FS_CREATUREEVENT_H_73FCAF4608CB41399D53C919316646A9
#define FS_CREATUREEVENT_H_73FCAF4608CB41399D53C919316646A9

#include "luascript.h"
#include "baseevents.h"
#include "enums.h"

enum CreatureEventType_t {
	CREATURE_EVENT_NONE,
	CREATURE_EVENT_LOGIN,
	CREATURE_EVENT_LOGOUT,
	CREATURE_EVENT_THINK,
	CREATURE_EVENT_PREPAREDEATH,
	CREATURE_EVENT_DEATH,
	CREATURE_EVENT_KILL,
	CREATURE_EVENT_ADVANCE,
	CREATURE_EVENT_EXTENDED_OPCODE, // otclient additional network opcodes
};

class CreatureEvent;

class CreatureEvents final : public BaseEvents
{
	public:
		CreatureEvents();
		~CreatureEvents();

		// non-copyable
		CreatureEvents(const CreatureEvents&) = delete;
		CreatureEvents& operator=(const CreatureEvents&) = delete;

		// global events
		bool playerLogin(Player* player) const;
		bool playerLogout(Player* player) const;
		bool playerAdvance(Player* player, skills_t, uint32_t, uint32_t);

		CreatureEvent* getEventByName(const std::string& name, bool forceLoaded = true);

	protected:
		LuaScriptInterface& getScriptInterface() final;
		std::string getScriptBaseName() const final;
		Event* getEvent(const std::string& nodeName) final;
		bool registerEvent(Event* event, const pugi::xml_node& node) final;
		void clear() final;

		//creature events
		typedef std::map<std::string, CreatureEvent*> CreatureEventList;
		CreatureEventList creatureEvents;

		LuaScriptInterface scriptInterface;
};

class CreatureEvent final : public Event
{
	public:
		explicit CreatureEvent(LuaScriptInterface* interface);

		bool configureEvent(const pugi::xml_node& node) final;

		CreatureEventType_t getEventType() const {
			return type;
		}
		const std::string& getName() const {
			return eventName;
		}
		bool isLoaded() const {
			return loaded;
		}

		void clearEvent();
		void copyEvent(CreatureEvent* creatureEvent);

		//scripting
		bool executeOnLogin(Player* player);
		bool executeOnLogout(Player* player);
		bool executeOnThink(Creature* creature, uint32_t interval);
		bool executeOnPrepareDeath(Creature* creature, Creature* killer);
		bool executeOnDeath(Creature* creature, Item* corpse, Creature* killer, Creature* mostDamageKiller, bool lastHitUnjustified, bool mostDamageUnjustified);
		void executeOnKill(Creature* creature, Creature* target);
		bool executeAdvance(Player* player, skills_t, uint32_t, uint32_t);
		void executeExtendedOpcode(Player* player, uint8_t opcode, const std::string& buffer);
		//

	protected:
		std::string getScriptEventName() const final;

		std::string eventName;
		CreatureEventType_t type;
		bool loaded;
};

#endif
