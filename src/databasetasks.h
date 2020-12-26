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

#ifndef FS_DATABASETASKS_H_9CBA08E9F5FEBA7275CCEE6560059576
#define FS_DATABASETASKS_H_9CBA08E9F5FEBA7275CCEE6560059576

#include <condition_variable>
#include "thread_holder_base.h"
#include "database.h"
#include "enums.h"

struct DatabaseTask {
	DatabaseTask(std::string query, std::function<void(DBResult_ptr, bool)> callback, bool store) :
		query(std::move(query)), callback(std::move(callback)), store(store) {}

	std::string query;
	std::function<void(DBResult_ptr, bool)> callback;
	bool store;
};

class DatabaseTasks : public ThreadHolder<DatabaseTasks>
{
	public:
		DatabaseTasks() = default;
		void start();
		void flush();
		void shutdown();

		void addTask(const std::string& query, const std::function<void(DBResult_ptr, bool)>& callback = nullptr, bool store = false);

		void threadMain();
	private:
		void runTask(const DatabaseTask& task);

		Database db;
		std::thread thread;
		std::list<DatabaseTask> tasks;
		std::mutex taskLock;
		std::condition_variable taskSignal;
};

extern DatabaseTasks g_databaseTasks;

#endif
