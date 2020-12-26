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

#include "position.h"

std::ostream& operator<<(std::ostream& os, const Position& pos)
{
	os << "( " << std::setw(5) << std::setfill('0') << pos.x;
	os << " / " << std::setw(5) << std::setfill('0') << pos.y;
	os << " / " << std::setw(3) << std::setfill('0') << pos.getZ();
	os << " )";
	return os;
}

std::ostream& operator<<(std::ostream& os, const Direction& dir)
{
	switch (dir) {
		case DIRECTION_NORTH:
			os << "North";
			break;

		case DIRECTION_EAST:
			os << "East";
			break;

		case DIRECTION_WEST:
			os << "West";
			break;

		case DIRECTION_SOUTH:
			os << "South";
			break;

		case DIRECTION_SOUTHWEST:
			os << "South-West";
			break;

		case DIRECTION_SOUTHEAST:
			os << "South-East";
			break;

		case DIRECTION_NORTHWEST:
			os << "North-West";
			break;

		case DIRECTION_NORTHEAST:
			os << "North-East";
			break;

		default:
			break;
	}

	return os;
}
