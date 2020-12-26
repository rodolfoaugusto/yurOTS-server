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

#ifndef FS_NETWORKMESSAGE_H_B853CFED58D1413A87ACED07B2926E03
#define FS_NETWORKMESSAGE_H_B853CFED58D1413A87ACED07B2926E03

#include "const.h"

class Item;
class Creature;
class Player;
struct Position;
class RSA;

class NetworkMessage
{
	public:
		typedef uint16_t MsgSize_t;
		// Headers:
		// 2 bytes for unencrypted message size
		// 2 bytes for encrypted message size
		static constexpr MsgSize_t INITIAL_BUFFER_POSITION = 4;
		enum { HEADER_LENGTH = 2 };
		enum { XTEA_MULTIPLE = 8 };
		enum { MAX_BODY_LENGTH = NETWORKMESSAGE_MAXSIZE - HEADER_LENGTH - XTEA_MULTIPLE };
		enum { MAX_PROTOCOL_BODY_LENGTH = MAX_BODY_LENGTH - 10 };

		NetworkMessage() = default;

		void reset() {
			info = {};
		}

		// simply read functions for incoming message
		uint8_t getByte() {
			if (!canRead(1)) {
				return 0;
			}

			return buffer[info.position++];
		}

		uint8_t getPreviousByte() {
			return buffer[--info.position];
		}

		template<typename T>
		T get() {
			if (!canRead(sizeof(T))) {
				return 0;
			}

			T v;
			memcpy(&v, buffer + info.position, sizeof(T));
			info.position += sizeof(T);
			return v;
		}

		std::string getString(uint16_t stringLen = 0);
		Position getPosition();

		// skips count unknown/unused bytes in an incoming message
		void skipBytes(int16_t count) {
			info.position += count;
		}

		// simply write functions for outgoing message
		void addByte(uint8_t value) {
			if (!canAdd(1)) {
				return;
			}

			buffer[info.position++] = value;
			info.length++;
		}

		template<typename T>
		void add(T value) {
			if (!canAdd(sizeof(T))) {
				return;
			}

			memcpy(buffer + info.position, &value, sizeof(T));
			info.position += sizeof(T);
			info.length += sizeof(T);
		}

		void addBytes(const char* bytes, size_t size);
		void addPaddingBytes(size_t n);

		void addString(const std::string& value);

		void addDouble(double value, uint8_t precision = 2);

		// write functions for complex types
		void addPosition(const Position& pos);
		void addItem(uint16_t id, uint8_t count);
		void addItem(const Item* item);
		void addItemId(uint16_t itemId);

		MsgSize_t getLength() const {
			return info.length;
		}

		void setLength(MsgSize_t newLength) {
			info.length = newLength;
		}

		MsgSize_t getBufferPosition() const {
			return info.position;
		}

		uint16_t getLengthHeader() const {
			return static_cast<uint16_t>(buffer[0] | buffer[1] << 8);
		}

		bool isOverrun() const {
			return info.overrun;
		}

		uint8_t* getBuffer() {
			return buffer;
		}

		const uint8_t* getBuffer() const {
			return buffer;
		}

		uint8_t* getBodyBuffer() {
			info.position = 2;
			return buffer + HEADER_LENGTH;
		}

	protected:
		inline bool canAdd(size_t size) const {
			return (size + info.position) < MAX_BODY_LENGTH;
		}

		inline bool canRead(int32_t size) {
			if ((info.position + size) > (info.length + 8) || size >= (NETWORKMESSAGE_MAXSIZE - info.position)) {
				info.overrun = true;
				return false;
			}
			return true;
		}

		struct NetworkMessageInfo {
			MsgSize_t length = 0;
			MsgSize_t position = INITIAL_BUFFER_POSITION;
			bool overrun = false;
		};

		NetworkMessageInfo info;
		uint8_t buffer[NETWORKMESSAGE_MAXSIZE];
};

#endif // #ifndef __NETWORK_MESSAGE_H__
