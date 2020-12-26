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

#ifndef FS_VOCATION_H_ADCAA356C0DB44CEBA994A0D678EC92D
#define FS_VOCATION_H_ADCAA356C0DB44CEBA994A0D678EC92D

#include "enums.h"
#include "item.h"

class Vocation
{
	public:
		explicit Vocation(uint16_t id) : id(id) {}

		const std::string& getVocName() const {
			return name;
		}
		const std::string& getVocDescription() const {
			return description;
		}
		uint64_t getReqSkillTries(uint8_t skill, uint16_t level);
		uint64_t getReqMana(uint32_t magLevel);

		uint16_t getId() const {
			return id;
		}
		uint16_t getFlagId() const {
			return flagid;
		}

		uint32_t getHPGain() const {
			return gainHP;
		}
		uint32_t getManaGain() const {
			return gainMana;
		}
		uint32_t getCapGain() const {
			return gainCap;
		}

		uint32_t getManaGainTicks() const {
			return gainManaTicks;
		}
		uint32_t getManaGainAmount() const {
			return gainManaAmount;
		}
		uint32_t getHealthGainTicks() const {
			return gainHealthTicks;
		}
		uint32_t getHealthGainAmount() const {
			return gainHealthAmount;
		}

		uint8_t getSoulMax() const {
			return soulMax;
		}
		uint16_t getSoulGainTicks() const {
			return gainSoulTicks;
		}

		uint32_t getAttackSpeed() const {
			return attackSpeed;
		}
		uint32_t getBaseSpeed() const {
			return baseSpeed;
		}

		uint32_t getFromVocation() const {
			return fromVocation;
		}

	protected:
		friend class Vocations;

		std::map<uint32_t, uint64_t> cacheMana;
		std::map<uint32_t, uint32_t> cacheSkill[SKILL_LAST + 1];

		std::string name = "none";
		std::string description;

		float skillMultipliers[SKILL_LAST + 1] = {1.5f, 2.0f, 2.0f, 2.0f, 2.0f, 1.5f, 1.1f};
		float manaMultiplier = 4.0f;

		uint32_t gainHealthTicks = 6;
		uint32_t gainHealthAmount = 1;
		uint32_t gainManaTicks = 6;
		uint32_t gainManaAmount = 1;
		uint32_t gainCap = 500;
		uint32_t gainMana = 5;
		uint32_t gainHP = 5;
		uint32_t fromVocation = VOCATION_NONE;
		uint32_t attackSpeed = 1500;
		uint32_t baseSpeed = 70;
		uint16_t id;
		uint16_t flagid;

		uint16_t gainSoulTicks = 120;

		uint8_t soulMax = 100;

		static uint32_t skillBase[SKILL_LAST + 1];
};

class Vocations
{
	public:
		bool loadFromXml();

		Vocation* getVocation(uint16_t id);
		int32_t getVocationId(const std::string& name) const;
		uint16_t getPromotedVocation(uint16_t vocationId) const;

	private:
		std::map<uint16_t, Vocation> vocationsMap;
};

#endif
