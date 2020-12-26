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

#ifndef FS_GLOBALEVENT_H_B3FB9B848EA3474B9AFC326873947E3C
#define FS_GLOBALEVENT_H_B3FB9B848EA3474B9AFC326873947E3C
#include "baseevents.h"

#include "const.h"

enum GlobalEvent_t {
	GLOBALEVENT_NONE,
	GLOBALEVENT_TIMER,

	GLOBALEVENT_STARTUP,
	GLOBALEVENT_SHUTDOWN,
	GLOBALEVENT_RECORD,
};

class GlobalEvent;
typedef std::map<std::string, GlobalEvent*> GlobalEventMap;

class GlobalEvents final : public BaseEvents
{
	public:
		GlobalEvents();
		~GlobalEvents();

		// non-copyable
		GlobalEvents(const GlobalEvents&) = delete;
		GlobalEvents& operator=(const GlobalEvents&) = delete;

		void startup() const;

		void timer();
		void think();
		void execute(GlobalEvent_t type) const;

		GlobalEventMap getEventMap(GlobalEvent_t type);
		static void clearMap(GlobalEventMap& map);

	protected:
		std::string getScriptBaseName() const final {
			return "globalevents";
		}
		void clear() final;

		Event* getEvent(const std::string& nodeName) final;
		bool registerEvent(Event* event, const pugi::xml_node& node) final;

		LuaScriptInterface& getScriptInterface() final {
			return scriptInterface;
		}
		LuaScriptInterface scriptInterface;

		GlobalEventMap thinkMap, serverMap, timerMap;
		int32_t thinkEventId = 0, timerEventId = 0;
};

class GlobalEvent final : public Event
{
	public:
		explicit GlobalEvent(LuaScriptInterface* interface);

		bool configureEvent(const pugi::xml_node& node) final;

		bool executeRecord(uint32_t current, uint32_t old);
		bool executeEvent();

		GlobalEvent_t getEventType() const {
			return eventType;
		}

		const std::string& getName() const {
			return name;
		}

		uint32_t getInterval() const {
			return interval;
		}

		int64_t getNextExecution() const {
			return nextExecution;
		}
		void setNextExecution(int64_t time) {
			nextExecution = time;
		}

	protected:
		GlobalEvent_t eventType = GLOBALEVENT_NONE;

		std::string getScriptEventName() const final;

		std::string name;
		int64_t nextExecution = 0;
		uint32_t interval = 0;
};

#endif
