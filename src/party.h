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

#ifndef FS_PARTY_H_41D4D7CF417C4CC99FAE94D552255044
#define FS_PARTY_H_41D4D7CF417C4CC99FAE94D552255044

#include "player.h"
#include "monsters.h"

class Player;
class Party;

typedef std::vector<Player*> PlayerVector;

class Party
{
	public:
		explicit Party(Player* leader);

		Player* getLeader() const {
			return leader;
		}
		PlayerVector& getMembers() {
			return memberList;
		}
		const PlayerVector& getInvitees() const {
			return inviteList;
		}
		size_t getMemberCount() const {
			return memberList.size();
		}
		size_t getInvitationCount() const {
			return inviteList.size();
		}

		void disband();
		bool invitePlayer(Player& player);
		bool joinParty(Player& player);
		void revokeInvitation(Player& player);
		bool passPartyLeadership(Player* player);
		bool leaveParty(Player* player);

		bool removeInvite(Player& player, bool removeFromPlayer = true);

		bool isPlayerInvited(const Player* player) const;
		void updateAllPartyIcons();
		void broadcastPartyMessage(MessageClasses msgClass, const std::string& msg, bool sendToInvitations = false);
		void broadcastPartyLoot(const std::string& loot);
		bool empty() const {
			return memberList.empty() && inviteList.empty();
		}

		void shareExperience(uint64_t experience);
		bool setSharedExperience(Player* player, bool sharedExpActive);
		bool isSharedExperienceActive() const {
			return sharedExpActive;
		}
		bool isSharedExperienceEnabled() const {
			return sharedExpEnabled;
		}
		bool canUseSharedExperience(const Player* player) const;
		void updateSharedExperience();

		void updateVocationsList();

		void updatePlayerTicks(Player* player, uint32_t points);
		void clearPlayerPoints(Player* player);

	protected:
		bool canEnableSharedExperience();

		std::map<uint32_t, int64_t> ticksMap;

		PlayerVector memberList;
		PlayerVector inviteList;

		Player* leader;

		float extraExpRate = 0.20f;

		bool sharedExpActive = false;
		bool sharedExpEnabled = false;
};

#endif
