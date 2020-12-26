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

#ifndef FS_IOLOGINDATA_H_28B0440BEC594654AC0F4E1A5E42B2EF
#define FS_IOLOGINDATA_H_28B0440BEC594654AC0F4E1A5E42B2EF

#include "account.h"
#include "player.h"
#include "database.h"

typedef std::list<std::pair<int32_t, Item*>> ItemBlockList;

class IOLoginData
{
	public:
		static Account loadAccount(uint32_t accno);
		static bool saveAccount(const Account& acc);

		static bool loginserverAuthentication(uint32_t accountNumber, const std::string& password, Account& account);
		static uint32_t gameworldAuthentication(uint32_t accountNumber, const std::string& password, std::string& characterName);

		static AccountType_t getAccountType(uint32_t accountId);
		static void setAccountType(uint32_t accountId, AccountType_t accountType);
		static void updateOnlineStatus(uint32_t guid, bool login);
		static bool preloadPlayer(Player* player, const std::string& name);

		static bool loadPlayerById(Player* player, uint32_t id);
		static bool loadPlayerByName(Player* player, const std::string& name);
		static bool loadPlayer(Player* player, DBResult_ptr result);
		static bool savePlayer(Player* player);
		static uint32_t getGuidByName(const std::string& name);
		static bool getGuidByNameEx(uint32_t& guid, bool& specialVip, std::string& name);
		static std::string getNameByGuid(uint32_t guid);
		static bool formatPlayerName(std::string& name);
		static void increaseBankBalance(uint32_t guid, uint64_t bankBalance);
		static bool hasBiddedOnHouse(uint32_t guid);

		static std::forward_list<VIPEntry> getVIPEntries(uint32_t accountId);
		static void addVIPEntry(uint32_t accountId, uint32_t guid);
		static void removeVIPEntry(uint32_t accountId, uint32_t guid);

		static void addPremiumDays(uint32_t accountId, int32_t addDays);
		static void removePremiumDays(uint32_t accountId, int32_t removeDays);

	protected:
		typedef std::map<uint32_t, std::pair<Item*, uint32_t>> ItemMap;

		static void loadItems(ItemMap& itemMap, DBResult_ptr result);
		static bool saveItems(const Player* player, const ItemBlockList& itemList, DBInsert& query_insert, PropWriteStream& stream);
};

#endif
