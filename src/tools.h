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

#ifndef FS_TOOLS_H_5F9A9742DA194628830AA1C64909AE43
#define FS_TOOLS_H_5F9A9742DA194628830AA1C64909AE43

#include <random>
#include <boost/filesystem.hpp>

#include "position.h"
#include "const.h"
#include "enums.h"

void printXMLError(const std::string& where, const std::string& fileName, const pugi::xml_parse_result& result);

std::string transformToSHA1(const std::string& input);
uint8_t getLiquidColor(uint8_t type);

void extractArticleAndName(std::string& data, std::string& article, std::string& name);
std::string pluralizeString(std::string str);
void replaceString(std::string& str, const std::string& sought, const std::string& replacement);
void trim_right(std::string& source, char t);
void trim_left(std::string& source, char t);
void toLowerCaseString(std::string& source);
std::string asLowerCaseString(std::string source);
std::string asUpperCaseString(std::string source);

typedef std::vector<std::string> StringVec;
typedef std::vector<int32_t> IntegerVec;

StringVec explodeString(const std::string& inString, const std::string& separator, int32_t limit = -1);
IntegerVec vectorAtoi(const StringVec& stringVector);
inline bool hasBitSet(uint32_t flag, uint32_t flags) {
	return (flags & flag) != 0;
}

inline bool IsDigit(char c)
{
	return ('0' <= c && c <= '9');
}

std::mt19937& getRandomGenerator();
int32_t uniform_random(int32_t minNumber, int32_t maxNumber);
int32_t normal_random(int32_t minNumber, int32_t maxNumber);
bool boolean_random(double probability = 0.5);

Direction getDirection(const std::string& string);
Position getNextPosition(Direction direction, Position pos);
Direction getDirectionTo(const Position& from, const Position& to);

std::string getFirstLine(const std::string& str);

std::string formatDate(time_t time);
std::string formatDateShort(time_t time);
std::string convertIPToString(uint32_t ip);

void trimString(std::string& str);

MagicEffectClasses getMagicEffect(const std::string& strValue);
ShootType_t getShootType(const std::string& strValue);
Ammo_t getAmmoType(const std::string& strValue);
WeaponAction_t getWeaponAction(const std::string& strValue);
CombatType_t getCombatType(const std::string& strValue);
Skulls_t getSkullType(const std::string& strValue);
FluidTypes_t getFluidType(const std::string& strValue);
std::string getCombatName(CombatType_t combatType);

std::string getSkillName(uint8_t skillid);

std::string ucfirst(std::string str);
std::string ucwords(std::string str);
bool booleanString(const std::string& str);

std::string getWeaponName(WeaponType_t weaponType);

size_t combatTypeToIndex(CombatType_t combatType);
CombatType_t indexToCombatType(size_t v);

itemAttrTypes stringToItemAttribute(const std::string& str);

const char* getReturnMessage(ReturnValue value);

void getFilesInDirectory(const boost::filesystem::path& root, const std::string& ext, std::vector<boost::filesystem::path>& ret);

inline int64_t OTSYS_TIME()
{
	return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
}

#endif
