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

#ifndef FS_POSITION_H_5B684192F7034FB8857C8280D2CC6C75
#define FS_POSITION_H_5B684192F7034FB8857C8280D2CC6C75

enum Direction : uint8_t {
	DIRECTION_NORTH = 0,
	DIRECTION_EAST = 1,
	DIRECTION_SOUTH = 2,
	DIRECTION_WEST = 3,

	DIRECTION_DIAGONAL_MASK = 4,
	DIRECTION_SOUTHWEST = DIRECTION_DIAGONAL_MASK | 0,
	DIRECTION_SOUTHEAST = DIRECTION_DIAGONAL_MASK | 1,
	DIRECTION_NORTHWEST = DIRECTION_DIAGONAL_MASK | 2,
	DIRECTION_NORTHEAST = DIRECTION_DIAGONAL_MASK | 3,

	DIRECTION_LAST = DIRECTION_NORTHEAST,
	DIRECTION_NONE = 8,
};

struct Position
{
	constexpr Position() = default;
	constexpr Position(uint16_t x, uint16_t y, uint8_t z) : x(x), y(y), z(z) {}

	template<int_fast32_t deltax, int_fast32_t deltay>
	inline static bool areInRange(const Position& p1, const Position& p2) {
		return Position::getDistanceX(p1, p2) <= deltax && Position::getDistanceY(p1, p2) <= deltay;
	}

	template<int_fast32_t deltax, int_fast32_t deltay, int_fast16_t deltaz>
	inline static bool areInRange(const Position& p1, const Position& p2) {
		return Position::getDistanceX(p1, p2) <= deltax && Position::getDistanceY(p1, p2) <= deltay && Position::getDistanceZ(p1, p2) <= deltaz;
	}

	inline static int_fast32_t getOffsetX(const Position& p1, const Position& p2) {
		return p1.getX() - p2.getX();
	}
	inline static int_fast32_t getOffsetY(const Position& p1, const Position& p2) {
		return p1.getY() - p2.getY();
	}
	inline static int_fast16_t getOffsetZ(const Position& p1, const Position& p2) {
		return p1.getZ() - p2.getZ();
	}

	inline static int32_t getDistanceX(const Position& p1, const Position& p2) {
		return std::abs(Position::getOffsetX(p1, p2));
	}
	inline static int32_t getDistanceY(const Position& p1, const Position& p2) {
		return std::abs(Position::getOffsetY(p1, p2));
	}
	inline static int16_t getDistanceZ(const Position& p1, const Position& p2) {
		return std::abs(Position::getOffsetZ(p1, p2));
	}

	uint16_t x = 0;
	uint16_t y = 0;
	uint8_t z = 0;

	bool operator<(const Position& p) const {
		if (z < p.z) {
			return true;
		}

		if (z > p.z) {
			return false;
		}

		if (y < p.y) {
			return true;
		}

		if (y > p.y) {
			return false;
		}

		if (x < p.x) {
			return true;
		}

		if (x > p.x) {
			return false;
		}

		return false;
	}

	bool operator>(const Position& p) const {
		return ! (*this < p);
	}

	bool operator==(const Position& p) const {
		return p.x == x && p.y == y && p.z == z;
	}

	bool operator!=(const Position& p) const {
		return p.x != x || p.y != y || p.z != z;
	}

	Position operator+(const Position& p1) const {
		return Position(x + p1.x, y + p1.y, z + p1.z);
	}

	Position operator-(const Position& p1) const {
		return Position(x - p1.x, y - p1.y, z - p1.z);
	}

	inline int_fast32_t getX() const { return x; }
	inline int_fast32_t getY() const { return y; }
	inline int_fast16_t getZ() const { return z; }
};

std::ostream& operator<<(std::ostream&, const Position&);
std::ostream& operator<<(std::ostream&, const Direction&);

#endif
