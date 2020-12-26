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

#ifndef FS_TASKS_H_A66AC384766041E59DCA059DAB6E1976
#define FS_TASKS_H_A66AC384766041E59DCA059DAB6E1976

#include <condition_variable>
#include "thread_holder_base.h"
#include "enums.h"

const int DISPATCHER_TASK_EXPIRATION = 2000;
const auto SYSTEM_TIME_ZERO = std::chrono::system_clock::time_point(std::chrono::milliseconds(0));

class Task
{
	public:
		// DO NOT allocate this class on the stack
		explicit Task(std::function<void (void)> f) : func(std::move(f)) {}
		Task(uint32_t ms, std::function<void (void)> f) :
			expiration(std::chrono::system_clock::now() + std::chrono::milliseconds(ms)), func(std::move(f)) {}

		virtual ~Task() = default;
		void operator()() {
			func();
		}

		void setDontExpire() {
			expiration = SYSTEM_TIME_ZERO;
		}

		bool hasExpired() const {
			if (expiration == SYSTEM_TIME_ZERO) {
				return false;
			}
			return expiration < std::chrono::system_clock::now();
		}

	protected:
		// Expiration has another meaning for scheduler tasks,
		// then it is the time the task should be added to the
		// dispatcher
		std::chrono::system_clock::time_point expiration = SYSTEM_TIME_ZERO;
		std::function<void (void)> func;
};

inline Task* createTask(const std::function<void (void)>& f)
{
	return new Task(f);
}

inline Task* createTask(uint32_t expiration, const std::function<void (void)>& f)
{
	return new Task(expiration, f);
}

class Dispatcher : public ThreadHolder<Dispatcher> {
	public:
		void addTask(Task* task, bool push_front = false);

		void shutdown();

		uint64_t getDispatcherCycle() const {
			return dispatcherCycle;
		}

		void threadMain();

	protected:
		std::thread thread;
		std::mutex taskLock;
		std::condition_variable taskSignal;

		std::list<Task*> taskList;
		uint64_t dispatcherCycle = 0;
};

extern Dispatcher g_dispatcher;

#endif
