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

#include "cylinder.h"

VirtualCylinder* VirtualCylinder::virtualCylinder = new VirtualCylinder;

int32_t Cylinder::getThingIndex(const Thing*) const
{
	return -1;
}

size_t Cylinder::getFirstIndex() const
{
	return 0;
}

size_t Cylinder::getLastIndex() const
{
	return 0;
}

uint32_t Cylinder::getItemTypeCount(uint16_t, int32_t) const
{
	return 0;
}

std::map<uint32_t, uint32_t>& Cylinder::getAllItemTypeCount(std::map<uint32_t, uint32_t>& countMap) const
{
	return countMap;
}

Thing* Cylinder::getThing(size_t) const
{
	return nullptr;
}

void Cylinder::internalAddThing(Thing*)
{
	//
}

void Cylinder::internalAddThing(uint32_t, Thing*)
{
	//
}

void Cylinder::startDecaying()
{
	//
}
