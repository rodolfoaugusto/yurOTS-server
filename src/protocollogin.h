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

#ifndef FS_PROTOCOLLOGIN_H_1238F4B473074DF2ABC595C29E81C46D
#define FS_PROTOCOLLOGIN_H_1238F4B473074DF2ABC595C29E81C46D

#include "protocol.h"

class NetworkMessage;
class OutputMessage;

class ProtocolLogin : public Protocol
{
	public:
		// static protocol information
		enum {server_sends_first = false};
		enum {protocol_identifier = 0x01};
		enum {use_checksum = true};
		static const char* protocol_name() {
			return "login protocol";
		}

		explicit ProtocolLogin(Connection_ptr connection) : Protocol(connection) {}

		void onRecvFirstMessage(NetworkMessage& msg);

	protected:
		void sendUpdateRequest();
		void disconnectClient(const std::string& message);

		void getCharacterList(uint32_t accountNumber, const std::string& password);
};

#endif