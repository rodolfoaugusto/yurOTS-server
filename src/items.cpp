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

#include "items.h"
#include "spells.h"
#include "movement.h"
#include "script.h"

#include "pugicast.h"

extern MoveEvents* g_moveEvents;

Items::Items()
{
	items.reserve(6000);
	nameToItems.reserve(6000);
}

void Items::clear()
{
	items.clear();
	nameToItems.clear();
}

bool Items::reload()
{
	clear();
	if (!loadItems()) {
		return false;
	}

	g_moveEvents->reload();
	return true;
}

bool Items::loadItems()
{
	ScriptReader script;
	if (!script.open("data/items/items.srv")) {
		return false;
	}

	std::string identifier;
	uint16_t id = 0;
	while (true) {
		script.nextToken();
		if (script.Token == ENDOFFILE) {
			break;
		}

		if (script.Token != IDENTIFIER) {
			script.error("Identifier expected");
			return false;
		}

		identifier = script.getIdentifier();
		script.readSymbol('=');

		if (identifier == "typeid") {
			id = script.readNumber();
			if (id >= items.size()) {
				items.resize(id + 1);
			}

			if (items[id].id) {
				script.error("item type already defined");
				return false;
			}

			items[id].id = id;
		} else if (identifier == "name") {
			items[id].name = script.readString();
		} else if (identifier == "description") {
			items[id].description = script.readString();
		} else if (identifier == "flags") {
			script.readSymbol('{');
			while (true) {
				while (true) {
					script.nextToken();
					if (script.Token == SPECIAL) {
						break;
					}

					identifier = script.getIdentifier();
					
					if (identifier == "bank") {
						items[id].group = ITEM_GROUP_GROUND;
					} else if (identifier == "clip") {
						items[id].alwaysOnTop = true;
						items[id].alwaysOnTopOrder = 1;
					} else if (identifier == "bottom") {
						items[id].alwaysOnTop = true;
						items[id].alwaysOnTopOrder = 2;
					} else if (identifier == "top") {
						items[id].alwaysOnTop = true;
						items[id].alwaysOnTopOrder = 3;
					} else if (identifier == "container") {
						items[id].type = ITEM_TYPE_CONTAINER;
					} else if (identifier == "quiver") {
						items[id].group = ITEM_GROUP_QUIVER;
					} else if (identifier == "multiweapon") {
						items[id].group = ITEM_GROUP_MULTIWEAPON;
					} else if (identifier == "multishot") {
						items[id].group = ITEM_GROUP_MULTISHOT;
					} else if (identifier == "chest") {
						items[id].type = ITEM_TYPE_CHEST;
					} else if (identifier == "cumulative") {
						items[id].stackable = true;
					} else if (identifier == "changeuse") {
						items[id].changeUse = true;
					} else if (identifier == "forceuse") {
						items[id].forceUse = true;
					} else if (identifier == "key") {
						items[id].type = ITEM_TYPE_KEY;
						items[id].group = ITEM_GROUP_KEY;
					} else if (identifier == "door") {
						items[id].type = ITEM_TYPE_DOOR;
					} else if (identifier == "bed") {
						items[id].type = ITEM_TYPE_BED;
					} else if (identifier == "rune") {
						items[id].type = ITEM_TYPE_RUNE;
					} else if (identifier == "depot") {
						items[id].type = ITEM_TYPE_DEPOT;
					} else if (identifier == "mailbox") {
						items[id].type = ITEM_TYPE_MAILBOX;
					} else if (identifier == "allowdistread") {
						items[id].allowDistRead = true;
					} else if (identifier == "text") {
						items[id].canReadText = true;
					} else if (identifier == "write") {
						items[id].canWriteText = true;
					} else if (identifier == "writeonce") {
						items[id].canWriteText = true;
						items[id].writeOnceItemId = id;
					} else if (identifier == "fluidcontainer") {
						items[id].group = ITEM_GROUP_FLUID;
					} else if (identifier == "splash") {
						items[id].group = ITEM_GROUP_SPLASH;
					} else if (identifier == "unpass") {
						items[id].blockSolid = true;
					} else if (identifier == "unmove") {
						items[id].moveable = false;
					} else if (identifier == "unthrow") {
						items[id].blockProjectile = true;
					} else if (identifier == "unlay") {
						items[id].allowPickupable = false;
					} else if (identifier == "avoid") {
						items[id].blockPathFind = true;
					} else if (identifier == "magicfield") {
						items[id].type = ITEM_TYPE_MAGICFIELD;
						items[id].group = ITEM_GROUP_MAGICFIELD;
					} else if (identifier == "take") {
						items[id].pickupable = true;
					} else if (identifier == "hang") {
						items[id].isHangable = true;
					} else if (identifier == "hooksouth") {
						items[id].isHorizontal = true;
					} else if (identifier == "hookeast") {
						items[id].isVertical = true;
					} else if (identifier == "rotate") {
						items[id].rotatable = true;
					} else if (identifier == "destroy") {
						items[id].destroy = true;
					} else if (identifier == "corpse") {
						items[id].corpse = true;
					} else if (identifier == "expire") {
						items[id].stopTime = false;
					} else if (identifier == "expirestop") {
						items[id].stopTime = true;
					} else if (identifier == "weapon") {
						items[id].group = ITEM_GROUP_WEAPON;
					} else if (identifier == "shield") {
						items[id].weaponType = WEAPON_SHIELD;
					} else if (identifier == "distance") {
						items[id].weaponType = WEAPON_DISTANCE;
					} else if (identifier == "wand") {
						items[id].weaponType = WEAPON_WAND;
					} else if (identifier == "ammo") {
						items[id].weaponType = WEAPON_AMMO;
					} else if (identifier == "armor") {
						items[id].group = ITEM_GROUP_ARMOR;
					} else if (identifier == "height") {
						items[id].hasHeight = true;
					} else if (identifier == "disguise") {
						items[id].disguise = true;
					} else if (identifier == "showdetail") {
						items[id].showDuration = true;
					} else if (identifier == "noreplace") {
						items[id].replaceable = false;
					} else if (identifier == "collisionevent") {
						items[id].collisionEvent = true;
					} else if (identifier == "separationevent") {
						items[id].separationEvent = true;
					} else if (identifier == "useevent") {
						items[id].useEvent = true;
					} else if (identifier == "distuse") {
						items[id].distUse = true;
					} else if (identifier == "multiuse") {
						items[id].multiUseEvent = true;
					} else {
						script.error("Unknown flag");
						return false;
					}
				}

				if (script.getSpecial() == '}') {
					break;
				}

				if (script.Token != SPECIAL || script.getSpecial() != ',') {
					continue;
				}
			}
		} else if (identifier == "attributes") {
			script.readSymbol('{');
			while (true) {
				while (true) {
					script.nextToken();
					if (script.Token == SPECIAL) {
						break;
					}

					identifier = script.getIdentifier();
					script.readSymbol('=');

					if (identifier == "waypoints") {
						items[id].speed = script.readNumber();
					} else if (identifier == "capacity") {
						items[id].maxItems = script.readNumber();
					} else if (identifier == "changetarget") {
						items[id].transformToOnUse = script.readNumber();
					} else if (identifier == "nutrition") {
						items[id].nutrition = script.readNumber();
					} else if (identifier == "maxlength") {
						items[id].maxTextLen = script.readNumber();
					} else if (identifier == "fluidsource") {
						items[id].fluidSource = getFluidType(script.readIdentifier());
					} else if (identifier == "avoiddamagetypes") {
						items[id].combatType = getCombatType(script.readIdentifier());
					} else if (identifier == "damagetype") {
						items[id].damageType = getCombatType(script.readIdentifier());
					} else if (identifier == "attackstrength") {
						items[id].attackStrength = script.readNumber();
					} else if (identifier == "reflect") {
						items[id].reflect = script.readNumber();
					} else if (identifier == "critical") {
						items[id].critical = script.readNumber();
					} else if (identifier == "lifeleech") {
						items[id].lifeLeech = script.readNumber();
					} else if (identifier == "manaleech") {
						items[id].manaLeech = script.readNumber();
					} else if (identifier == "attackvariation") {
						items[id].attackVariation = script.readNumber();
					} else if (identifier == "manaconsumption") {
						items[id].manaConsumption = script.readNumber();
					} else if (identifier == "minimumlevel") {
						items[id].minReqLevel = script.readNumber();
						items[id].wieldInfo |= WIELDINFO_LEVEL;
					} else if (identifier == "mages") {
						items[id].mages = script.readNumber();

						std::list<std::string> vocationStringList;

						std::string vocationString;
						vocationStringList.push_back("sorcerer");
						vocationStringList.push_back("druid");

						for (const std::string& str : vocationStringList) {
							if (!vocationString.empty()) {
								if (str != vocationStringList.back()) {
									vocationString.push_back(',');
									vocationString.push_back(' ');
								} else {
									vocationString += " and ";
								}
							}

							vocationString += str;
							vocationString.push_back('s');
						}

						items[id].wieldInfo |= WIELDINFO_VOCREQ;
						items[id].vocationString = vocationString;
					} else if (identifier == "vocations") {
						int32_t vocations = script.readNumber();
						items[id].vocations = vocations;

						std::list<std::string> vocationStringList;

						if (hasBitSet(VOCATION_SORCERER, vocations)) {
							vocationStringList.push_back("sorcerer");
						}

						if (hasBitSet(VOCATION_DRUID, vocations)) {
							vocationStringList.push_back("druid");
						}

						if (hasBitSet(VOCATION_PALADIN, vocations)) {
							vocationStringList.push_back("paladin");
						}

						if (hasBitSet(VOCATION_KNIGHT, vocations)) {
							vocationStringList.push_back("knight");
						}

						std::string vocationString;
						for (const std::string& str : vocationStringList) {
							if (!vocationString.empty()) {
								if (str != vocationStringList.back()) {
									vocationString.push_back(',');
									vocationString.push_back(' ');
								} else {
									vocationString += " and ";
								}
							}

							vocationString += str;
							vocationString.push_back('s');
						}

						items[id].wieldInfo |= WIELDINFO_VOCREQ;
						items[id].vocationString = vocationString;
					} else if (identifier == "weaponspecialeffect") {
						items[id].weaponSpecialEffect = script.readNumber();
					} else if (identifier == "beddirection") {
						items[id].bedPartnerDir = getDirection(script.readIdentifier());
					} else if (identifier == "bedtarget") {
						items[id].transformToOnUse = script.readNumber();
					} else if (identifier == "bedfree") {
						items[id].transformToFree = script.readNumber();
					} else if (identifier == "weight") {
						items[id].weight = script.readNumber();
					} else if (identifier == "rotatetarget") {
						items[id].rotateTo = script.readNumber();
					} else if (identifier == "destroytarget") {
						items[id].destroyTarget = script.readNumber();
					} else if (identifier == "slottype") {
						identifier = asLowerCaseString(script.readIdentifier());
						if (identifier == "head") {
							items[id].slotPosition |= SLOTP_HEAD;
						} else if (identifier == "body") {
							items[id].slotPosition |= SLOTP_ARMOR;
						} else if (identifier == "legs") {
							items[id].slotPosition |= SLOTP_LEGS;
						} else if (identifier == "feet") {
							items[id].slotPosition |= SLOTP_FEET;
						} else if (identifier == "backpack") {
							items[id].slotPosition |= SLOTP_BACKPACK;
						} else if (identifier == "twohanded") {
							items[id].slotPosition |= SLOTP_TWO_HAND;
						} else if (identifier == "righthand") {
							items[id].slotPosition &= ~SLOTP_LEFT;
						} else if (identifier == "lefthand") {
							items[id].slotPosition &= ~SLOTP_RIGHT;
						} else if (identifier == "necklace") {
							items[id].slotPosition |= SLOTP_NECKLACE;
						} else if (identifier == "ring") {
							items[id].slotPosition |= SLOTP_RING;
						} else if (identifier == "ammo") {
							items[id].slotPosition |= SLOTP_AMMO;
						} else if (identifier == "hand") {
							items[id].slotPosition |= SLOTP_HAND;
						} else {
							script.error("Unknown slot position");
							return false;
						}
					} else if (identifier == "speedboost") {
						items[id].getAbilities().speed = script.readNumber();
					} else if (identifier == "fistboost") {
						items[id].getAbilities().skills[SKILL_FIST] = script.readNumber();
					} else if (identifier == "swordboost") {
						items[id].getAbilities().skills[SKILL_SWORD] = script.readNumber();
					} else if (identifier == "clubboost") {
						items[id].getAbilities().skills[SKILL_CLUB] = script.readNumber();
					} else if (identifier == "axeboost") {
						items[id].getAbilities().skills[SKILL_AXE] = script.readNumber();
					} else if (identifier == "shieldboost") {
						items[id].getAbilities().skills[SKILL_SHIELD] = script.readNumber();
					} else if (identifier == "distanceboost") {
						items[id].getAbilities().skills[SKILL_DISTANCE] = script.readNumber();
					} else if (identifier == "magicboost") {
						items[id].getAbilities().stats[STAT_MAGICPOINTS] = script.readNumber();
					} else if (identifier == "percenthp") {
						int32_t currentPoint = script.readNumber(); 
						items[id].maxPoints = currentPoint;
						items[id].getAbilities().statsPercent[STAT_MAXHITPOINTS] = currentPoint;
					} else if (identifier == "percentmp") {
						int32_t currentPoint = script.readNumber(); 
						items[id].maxPoints = currentPoint;
						items[id].getAbilities().statsPercent[STAT_MAXMANAPOINTS] = currentPoint;
					} else if (identifier == "suppressdrunk") {
						if (script.readNumber()) {
							items[id].getAbilities().conditionSuppressions |= CONDITION_DRUNK;
						}
					} else if (identifier == "suppressfreeze") {
						if (script.readNumber()) {
							items[id].getAbilities().conditionSuppressions |= CONDITION_FREEZING;
						}
					} else if (identifier == "suppresscurse") {
						if (script.readNumber()) {
							items[id].getAbilities().conditionSuppressions |= CONDITION_CURSED;
						}
					} else if (identifier == "suppressdazzle") {
						if (script.readNumber()) {
							items[id].getAbilities().conditionSuppressions |= CONDITION_DAZZLED;
						}
					} else if (identifier == "invisible") {
						if (script.readNumber()) {
							items[id].getAbilities().invisible = true;
						}
					} else if (identifier == "manashield") {
						if (script.readNumber()) {
							items[id].getAbilities().manaShield = true;
						}
					} else if (identifier == "healthticks") {
						Abilities& abilities = items[id].getAbilities();
						abilities.regeneration = true;
						abilities.healthTicks = script.readNumber();
					} else if (identifier == "healthgain") {
						Abilities& abilities = items[id].getAbilities();
						abilities.regeneration = true;
						abilities.healthGain = script.readNumber();
					} else if (identifier == "manaticks") {
						Abilities& abilities = items[id].getAbilities();
						abilities.regeneration = true;
						abilities.manaTicks = script.readNumber();
					} else if (identifier == "managain") {
						Abilities& abilities = items[id].getAbilities();
						abilities.regeneration = true;
						abilities.manaGain = script.readNumber();
					} else if (identifier == "absorbmagic") {
						int32_t percent = script.readNumber();
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_ENERGYDAMAGE)] += percent;
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_FIREDAMAGE)] += percent;
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_EARTHDAMAGE)] += percent;
					} else if (identifier == "absorbenergy") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_ENERGYDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbfire") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_FIREDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbpoison") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_EARTHDAMAGE)] += script.readNumber();
					} else if (identifier == "absorblifedrain") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_LIFEDRAIN)] += script.readNumber();
					} else if (identifier == "absorbmanadrain") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_MANADRAIN)] += script.readNumber();
					} else if (identifier == "absorbice") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_ICEDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbholy") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_HOLYDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbdeath") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_DEATHDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbphysical") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_PHYSICALDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbhealing") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_HEALING)] += script.readNumber();
					} else if (identifier == "absorbundefined") {
						items[id].getAbilities().absorbPercent[combatTypeToIndex(COMBAT_UNDEFINEDDAMAGE)] += script.readNumber();
					} else if (identifier == "absorbfirefield") {
						items[id].getAbilities().fieldAbsorbPercent[combatTypeToIndex(COMBAT_FIREDAMAGE)] += static_cast<int16_t>(script.readNumber());
					} else if (identifier == "brightness") {
						items[id].lightLevel = script.readNumber();
					} else if (identifier == "lightcolor") {
						items[id].lightColor = script.readNumber();
					} else if (identifier == "totalexpiretime") {
						items[id].decayTime = script.readNumber();
					} else if (identifier == "expiretarget") {
						items[id].decayTo = script.readNumber();
					} else if (identifier == "totaluses") {
						items[id].charges = script.readNumber();
					} else if (identifier == "weapontype") {
						identifier = script.readIdentifier();
						if (identifier == "sword") {
							items[id].weaponType = WEAPON_SWORD;
						} else if (identifier == "club") {
							items[id].weaponType = WEAPON_CLUB;
						} else if (identifier == "axe") {
							items[id].weaponType = WEAPON_AXE;
						} else if (identifier == "shield") {
							items[id].weaponType = WEAPON_SHIELD;
						} else if (identifier == "distance") {
							items[id].weaponType = WEAPON_DISTANCE;
						} else if (identifier == "wand") {
							items[id].weaponType = WEAPON_WAND;
						} else if (identifier == "ammunition") {
							items[id].weaponType = WEAPON_AMMO;
						} else {
							script.error("Unknown weapon type");
							return false;
						}
					} else if (identifier == "attack") {
						items[id].attack = script.readNumber();
					} else if (identifier == "defense") {
						items[id].defense = script.readNumber();
					} else if (identifier == "range") {
						items[id].shootRange = static_cast<uint8_t>(script.readNumber());
					} else if (identifier == "ammotype") {
						items[id].ammoType = getAmmoType(script.readIdentifier());
						if (items[id].ammoType == AMMO_NONE) {
							script.error("Unknown ammo type");
							return false;
						}
					} else if (identifier == "missileeffect") {
						items[id].shootType = static_cast<ShootType_t>(script.readNumber());
					} else if (identifier == "fragility") {
						items[id].fragility = script.readNumber();
					} else if (identifier == "armorvalue") {
						items[id].armor = script.readNumber();
					} else if (identifier == "disguisetarget") {
						items[id].disguiseId = script.readNumber();
					} else if (identifier == "equiptarget") {
						items[id].transformEquipTo = script.readNumber();
					} else if (identifier == "deequiptarget") {
						items[id].transformDeEquipTo = script.readNumber();
					} else {
						script.error("Unknown attribute");
						return false;
					}
				}

				if (script.getSpecial() == '}') {
					break;
				}

				if (script.Token != SPECIAL || script.getSpecial() != ',') {
					continue;
				}
			}
		} else if (identifier == "magicfield") {
			script.readSymbol('{');

			CombatType_t combatType = COMBAT_NONE;
			ConditionDamage* conditionDamage = nullptr;

			int32_t cycles = 0;
			int32_t hit_damage = 0;

			while (true) {
				while (true) {
					script.nextToken();
					if (script.Token == SPECIAL) {
						break;
					}

					identifier = script.getIdentifier();
					script.readSymbol('=');

					if (identifier == "type") {
						identifier = script.readIdentifier();
						if (identifier == "fire") {
							conditionDamage = new ConditionDamage(CONDITIONID_COMBAT, CONDITION_FIRE);
							combatType = COMBAT_FIREDAMAGE;
							items[id].combatType = combatType;
							items[id].conditionDamage.reset(conditionDamage);
						} else if (identifier == "energy") {
							conditionDamage = new ConditionDamage(CONDITIONID_COMBAT, CONDITION_ENERGY);
							combatType = COMBAT_ENERGYDAMAGE;
							items[id].combatType = combatType;
							items[id].conditionDamage.reset(conditionDamage);
						} else if (identifier == "poison") {
							conditionDamage = new ConditionDamage(CONDITIONID_COMBAT, CONDITION_POISON);
							conditionDamage->setParam(CONDITION_PARAM_DELAYED, true);
							combatType = COMBAT_EARTHDAMAGE;
							items[id].combatType = combatType;
							items[id].conditionDamage.reset(conditionDamage);
						} else {
							script.error("unknown magicfield type");
							return false;
						}
					} else if (identifier == "count") {
						cycles = script.readNumber();
					} else if (identifier == "damage") {
						hit_damage = script.readNumber();
					} else {
						script.error("unknown identifier");
						return false;
					}
				}

				if (script.getSpecial() == '}') {
					break;
				}

				if (script.Token != SPECIAL || script.getSpecial() != ',') {
					continue;
				}
			}

			int32_t count = 3;

			if (combatType == COMBAT_FIREDAMAGE) {
				cycles /= 10;
				count = 8;
			} else if (combatType == COMBAT_ENERGYDAMAGE) {
				cycles /= 20;
				count = 10;
			}

			conditionDamage->setParam(CONDITION_PARAM_CYCLE, cycles);
			conditionDamage->setParam(CONDITION_PARAM_COUNT, count);
			conditionDamage->setParam(CONDITION_PARAM_MAX_COUNT, count);
			conditionDamage->setParam(CONDITION_PARAM_HIT_DAMAGE, hit_damage);

			conditionDamage->setParam(CONDITION_PARAM_FIELD, 1);
		}
	}

	script.close();
	items.shrink_to_fit();

	for (ItemType& type : items) {
		std::string& name = type.name;
		extractArticleAndName(name, type.article, type.name);
		nameToItems.insert({ asLowerCaseString(type.name), type.id });
		if (!name.empty()) {
			if (type.stackable) {
				type.showCount = true;
				type.pluralName = pluralizeString(name);
			}
		}
	}

	return true;
}

ItemType& Items::getItemType(size_t id)
{
	if (id < items.size()) {
		return items[id];
	}
	return items.front();
}

const ItemType& Items::getItemType(size_t id) const
{
	if (id < items.size()) {
		return items[id];
	}
	return items.front();
}

uint16_t Items::getItemIdByName(const std::string& name)
{
	auto result = nameToItems.find(asLowerCaseString(name));

	if (result == nameToItems.end())
		return 0;

	return result->second;
}
