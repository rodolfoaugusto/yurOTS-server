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

#ifndef FS_TOWN_H_3BE21D2293B44AA4A3D22D25BE1B9350
#define FS_TOWN_H_3BE21D2293B44AA4A3D22D25BE1B9350

#include "position.h"

class Town
{
	public:
		explicit Town(uint32_t id) : id(id) {}

		const Position& getTemplePosition() const {
			return templePosition;
		}
		const std::string& getName() const {
			return name;
		}

		void setTemplePos(Position pos) {
			templePosition = pos;
		}
		void setName(std::string name) {
			this->name = std::move(name);
		}
		uint32_t getID() const {
			return id;
		}

	private:
		uint32_t id;
		std::string name;
		Position templePosition;
};

typedef std::map<uint32_t, Town*> TownMap;

class Towns
{
	public:
		Towns() = default;
		~Towns() {
			for (const auto& it : townMap) {
				delete it.second;
			}
		}

		// non-copyable
		Towns(const Towns&) = delete;
		Towns& operator=(const Towns&) = delete;

		bool addTown(uint32_t townId, Town* town) {
			return townMap.emplace(townId, town).second;
		}

		Town* getTown(const std::string& townName) const {
			for (const auto& it : townMap) {
				if (strcasecmp(townName.c_str(), it.second->getName().c_str()) == 0) {
					return it.second;
				}
			}
			return nullptr;
		}

		Town* getTown(uint32_t townId) const {
			auto it = townMap.find(townId);
			if (it == townMap.end()) {
				return nullptr;
			}
			return it->second;
		}

		const TownMap& getTowns() const {
			return townMap;
		}

	private:
		TownMap townMap;
};

#endif
