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

#ifndef FS_CHAT_H_F1574642D0384ABFAB52B7ED906E5628
#define FS_CHAT_H_F1574642D0384ABFAB52B7ED906E5628

#include "const.h"
#include "luascript.h"

class Party;
class Player;

typedef std::map<uint32_t, Player*> UsersMap;
typedef std::map<uint32_t, const Player*> InvitedMap;

class ChatChannel
{
	public:
		ChatChannel() = default;
		ChatChannel(uint16_t channelId, std::string channelName):
			name(std::move(channelName)),
			id(channelId) {}

		virtual ~ChatChannel() = default;

		bool addUser(Player& player);
		bool removeUser(const Player& player);

		bool talk(const Player& fromPlayer, SpeakClasses type, const std::string& text);

		const std::string& getName() const {
			return name;
		}
		uint16_t getId() const {
			return id;
		}
		const UsersMap& getUsers() const {
			return users;
		}
		virtual const InvitedMap* getInvitedUsers() const {
			return nullptr;
		}

		virtual uint32_t getOwner() const {
			return 0;
		}

		bool isPublicChannel() const { return publicChannel; }

		bool executeOnJoinEvent(const Player& player);
		bool executeCanJoinEvent(const Player& player);
		bool executeOnLeaveEvent(const Player& player);
		bool executeOnSpeakEvent(const Player& player, SpeakClasses& type, const std::string& message);

	protected:
		UsersMap users;

		std::string name;

		int32_t canJoinEvent = -1;
		int32_t onJoinEvent = -1;
		int32_t onLeaveEvent = -1;
		int32_t onSpeakEvent = -1;

		uint16_t id;
		bool publicChannel = false;

	friend class Chat;
};

class PrivateChatChannel final : public ChatChannel
{
	public:
		PrivateChatChannel(uint16_t channelId, std::string channelName) : ChatChannel(channelId, channelName) {}

		uint32_t getOwner() const final {
			return owner;
		}
		void setOwner(uint32_t owner) {
			this->owner = owner;
		}

		bool isInvited(uint32_t guid) const;

		void invitePlayer(const Player& player, Player& invitePlayer);
		void excludePlayer(const Player& player, Player& excludePlayer);

		bool removeInvite(uint32_t guid);

		void closeChannel() const;

		const InvitedMap* getInvitedUsers() const final {
			return &invites;
		}

	protected:
		InvitedMap invites;
		uint32_t owner = 0;
};

typedef std::list<ChatChannel*> ChannelList;

class Chat
{
	public:
		Chat();

		// non-copyable
		Chat(const Chat&) = delete;
		Chat& operator=(const Chat&) = delete;

		bool load();

		ChatChannel* createChannel(const Player& player, uint16_t channelId);
		bool deleteChannel(const Player& player, uint16_t channelId);

		ChatChannel* addUserToChannel(Player& player, uint16_t channelId);
		bool removeUserFromChannel(const Player& player, uint16_t channelId);
		void removeUserFromAllChannels(const Player& player);

		bool talkToChannel(const Player& player, SpeakClasses type, const std::string& text, uint16_t channelId);

		ChannelList getChannelList(const Player& player);

		ChatChannel* getChannel(const Player& player, uint16_t channelId);
		ChatChannel* getChannelById(uint16_t channelId);
		ChatChannel* getGuildChannelById(uint32_t guildId);
		PrivateChatChannel* getPrivateChannel(const Player& player);

		LuaScriptInterface* getScriptInterface() {
			return &scriptInterface;
		}

	private:
		std::map<uint16_t, ChatChannel> normalChannels;
		std::map<uint16_t, PrivateChatChannel> privateChannels;
		std::map<Party*, ChatChannel> partyChannels;
		std::map<uint32_t, ChatChannel> guildChannels;

		LuaScriptInterface scriptInterface;

		PrivateChatChannel dummyPrivate;
};

#endif
