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

#include "outputmessage.h"
#include "protocol.h"
#include "lockfree.h"
#include "scheduler.h"

extern Scheduler g_scheduler;

const uint16_t OUTPUTMESSAGE_FREE_LIST_CAPACITY = 2048;
const std::chrono::milliseconds OUTPUTMESSAGE_AUTOSEND_DELAY {10};

class OutputMessageAllocator
{
	public:
		typedef OutputMessage value_type;
		template<typename U>
		struct rebind {typedef LockfreePoolingAllocator<U, OUTPUTMESSAGE_FREE_LIST_CAPACITY> other;};
};

void OutputMessagePool::scheduleSendAll()
{
	auto functor = std::bind(&OutputMessagePool::sendAll, this);
	g_scheduler.addEvent(createSchedulerTask(OUTPUTMESSAGE_AUTOSEND_DELAY.count(), functor));
}

void OutputMessagePool::sendAll()
{
	//dispatcher thread
	for (auto& protocol : bufferedProtocols) {
		auto& msg = protocol->getCurrentBuffer();
		if (msg) {
			protocol->send(std::move(msg));
		}
	}

	if (!bufferedProtocols.empty()) {
		scheduleSendAll();
	}
}

void OutputMessagePool::addProtocolToAutosend(Protocol_ptr protocol)
{
	//dispatcher thread
	if (bufferedProtocols.empty()) {
		scheduleSendAll();
	}
	bufferedProtocols.emplace_back(protocol);
}

void OutputMessagePool::removeProtocolFromAutosend(const Protocol_ptr& protocol)
{
	//dispatcher thread
	auto it = std::find(bufferedProtocols.begin(), bufferedProtocols.end(), protocol);
	if (it != bufferedProtocols.end()) {
		std::swap(*it, bufferedProtocols.back());
		bufferedProtocols.pop_back();
	}
}

OutputMessage_ptr OutputMessagePool::getOutputMessage()
{
	return std::allocate_shared<OutputMessage>(OutputMessageAllocator());
}
