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

#ifndef FS_SCHEDULER_H_2905B3D5EAB34B4BA8830167262D2DC1
#define FS_SCHEDULER_H_2905B3D5EAB34B4BA8830167262D2DC1

#include "tasks.h"
#include <unordered_set>
#include <queue>

#include "thread_holder_base.h"

static constexpr int32_t SCHEDULER_MINTICKS = 50;

class SchedulerTask : public Task
{
	public:
		void setEventId(uint32_t id) {
			eventId = id;
		}
		uint32_t getEventId() const {
			return eventId;
		}

		std::chrono::system_clock::time_point getCycle() const {
			return expiration;
		}

	protected:
		SchedulerTask(uint32_t delay, const std::function<void (void)>& f) : Task(delay, f) {}

		uint32_t eventId = 0;

		friend SchedulerTask* createSchedulerTask(uint32_t, const std::function<void (void)>&);
};

inline SchedulerTask* createSchedulerTask(uint32_t delay, const std::function<void (void)>& f)
{
	return new SchedulerTask(delay, f);
}

struct TaskComparator {
	bool operator()(const SchedulerTask* lhs, const SchedulerTask* rhs) const {
		return lhs->getCycle() > rhs->getCycle();
	}
};

class Scheduler : public ThreadHolder<Scheduler>
{
	public:
		uint32_t addEvent(SchedulerTask* task);
		bool stopEvent(uint32_t eventId);

		void shutdown();

		void threadMain();
	protected:
		std::thread thread;
		std::mutex eventLock;
		std::condition_variable eventSignal;

		uint32_t lastEventId {0};
		std::priority_queue<SchedulerTask*, std::deque<SchedulerTask*>, TaskComparator> eventList;
		std::unordered_set<uint32_t> eventIds;
};

extern Scheduler g_scheduler;

#endif
