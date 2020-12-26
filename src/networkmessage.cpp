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

#include "networkmessage.h"

#include "container.h"
#include "creature.h"

std::string NetworkMessage::getString(uint16_t stringLen/* = 0*/)
{
	if (stringLen == 0) {
		stringLen = get<uint16_t>();
	}

	if (!canRead(stringLen)) {
		return std::string();
	}

	char* v = reinterpret_cast<char*>(buffer) + info.position; //does not break strict aliasing
	info.position += stringLen;
	return std::string(v, stringLen);
}

Position NetworkMessage::getPosition()
{
	Position pos;
	pos.x = get<uint16_t>();
	pos.y = get<uint16_t>();
	pos.z = getByte();
	return pos;
}

void NetworkMessage::addString(const std::string& value)
{
	size_t stringLen = value.length();
	if (!canAdd(stringLen + 2) || stringLen > 8192) {
		return;
	}

	add<uint16_t>(stringLen);
	memcpy(buffer + info.position, value.c_str(), stringLen);
	info.position += stringLen;
	info.length += stringLen;
}

void NetworkMessage::addDouble(double value, uint8_t precision/* = 2*/)
{
	addByte(precision);
	add<uint32_t>((value * std::pow(static_cast<float>(10), precision)) + std::numeric_limits<int32_t>::max());
}

void NetworkMessage::addBytes(const char* bytes, size_t size)
{
	if (!canAdd(size) || size > 8192) {
		return;
	}

	memcpy(buffer + info.position, bytes, size);
	info.position += size;
	info.length += size;
}

void NetworkMessage::addPaddingBytes(size_t n)
{
	if (!canAdd(n)) {
		return;
	}

	memset(buffer + info.position, 0x33, n);
	info.length += n;
}

void NetworkMessage::addPosition(const Position& pos)
{
	add<uint16_t>(pos.x);
	add<uint16_t>(pos.y);
	addByte(pos.z);
}

void NetworkMessage::addItem(uint16_t id, uint8_t count)
{
	const ItemType& it = Item::items[id];

	if (it.disguise) {
		add<uint16_t>(it.disguiseId);
	} else {
		add<uint16_t>(it.id);
	}

	if (it.stackable) {
		addByte(count);
	} else if (it.isSplash() || it.isFluidContainer()) {
		addByte(getLiquidColor(count));
	}
}

void NetworkMessage::addItem(const Item* item)
{
	const ItemType& it = Item::items[item->getID()];

	if (it.disguise) {
		add<uint16_t>(it.disguiseId);
	} else {
		add<uint16_t>(it.id);
	}

	if (it.stackable) {
		addByte(std::min<uint16_t>(0xFF, item->getItemCount()));
	} else if (it.isSplash() || it.isFluidContainer()) {
		addByte(getLiquidColor(item->getFluidType()));
	}
}

void NetworkMessage::addItemId(uint16_t itemId)
{
	add<uint16_t>(itemId);
}
