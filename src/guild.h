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

#ifndef FS_GUILD_H_C00F0A1D732E4BA88FF62ACBE74D76BC
#define FS_GUILD_H_C00F0A1D732E4BA88FF62ACBE74D76BC

class Player;

struct GuildRank {
	uint32_t id;
	std::string name;
	uint8_t level;

	GuildRank(uint32_t id, std::string name, uint8_t level) :
		id(id), name(std::move(name)), level(level) {}
};

class Guild
{
	public:
		Guild(uint32_t id, std::string name) : name(std::move(name)), id(id) {}

		void addMember(Player* player);
		void removeMember(Player* player);

		uint32_t getId() const {
			return id;
		}
		const std::string& getName() const {
			return name;
		}
		const std::list<Player*>& getMembersOnline() const {
			return membersOnline;
		}
		uint32_t getMemberCount() const {
			return memberCount;
		}
		void setMemberCount(uint32_t count) {
			memberCount = count;
		}

		GuildRank* getRankById(uint32_t id);
		const GuildRank* getRankByLevel(uint8_t level) const;
		void addRank(uint32_t id, const std::string& name, uint8_t level);

	private:
		std::list<Player*> membersOnline;
		std::vector<GuildRank> ranks;
		std::string name;
		uint32_t id;
		uint32_t memberCount = 0;
};

#endif
