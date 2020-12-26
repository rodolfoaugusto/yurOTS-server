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

#include "tasks.h"
#include "game.h"

extern Game g_game;

void Dispatcher::threadMain()
{
	// NOTE: second argument defer_lock is to prevent from immediate locking
	std::unique_lock<std::mutex> taskLockUnique(taskLock, std::defer_lock);

	while (getState() != THREAD_STATE_TERMINATED) {
		// check if there are tasks waiting
		taskLockUnique.lock();

		if (taskList.empty()) {
			//if the list is empty wait for signal
			taskSignal.wait(taskLockUnique);
		}

		if (!taskList.empty()) {
			// take the first task
			Task* task = taskList.front();
			taskList.pop_front();
			taskLockUnique.unlock();

			if (!task->hasExpired()) {
				++dispatcherCycle;
				// execute it
				(*task)();

				g_game.map.clearSpectatorCache();
			}
			delete task;
		} else {
			taskLockUnique.unlock();
		}
	}
}

void Dispatcher::addTask(Task* task, bool push_front /*= false*/)
{
	bool do_signal = false;

	taskLock.lock();

	if (getState() == THREAD_STATE_RUNNING) {
		do_signal = taskList.empty();

		if (push_front) {
			taskList.push_front(task);
		} else {
			taskList.push_back(task);
		}
	} else {
		delete task;
	}

	taskLock.unlock();

	// send a signal if the list was empty
	if (do_signal) {
		taskSignal.notify_one();
	}
}

void Dispatcher::shutdown()
{
	Task* task = createTask([this]() {
		setState(THREAD_STATE_TERMINATED);
		taskSignal.notify_one();
	});

	std::lock_guard<std::mutex> lockClass(taskLock);
	taskList.push_back(task);

	taskSignal.notify_one();
}
