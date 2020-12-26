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

#ifndef FS_BAN_H_CADB975222D745F0BDA12D982F1006E3
#define FS_BAN_H_CADB975222D745F0BDA12D982F1006E3

struct BanInfo {
	std::string bannedBy;
	std::string reason;
	time_t expiresAt;
};

struct ConnectBlock {
	constexpr ConnectBlock(uint64_t lastAttempt, uint64_t blockTime, uint32_t count) :
		lastAttempt(lastAttempt), blockTime(blockTime), count(count) {}

	uint64_t lastAttempt;
	uint64_t blockTime;
	uint32_t count;
};

typedef std::map<uint32_t, ConnectBlock> IpConnectMap;

class Ban
{
	public:
		bool acceptConnection(uint32_t clientip);

	protected:
		IpConnectMap ipConnectMap;
		std::recursive_mutex lock;
};

class IOBan
{
	public:
		static bool isAccountBanned(uint32_t accountId, BanInfo& banInfo);
		static bool isIpBanned(uint32_t ip, BanInfo& banInfo);
		static bool isPlayerNamelocked(uint32_t playerId);
};

#endif
