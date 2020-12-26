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

#ifndef FS_NPC_H_B090D0CB549D4435AFA03647195D156F
#define FS_NPC_H_B090D0CB549D4435AFA03647195D156F

#include "creature.h"

#include <set>

class Npc;
class Player;
class BehaviourDatabase;

class Npcs
{
	public:
		static void loadNpcs();
		static void reload();
};

class Npc final : public Creature
{
	public:
		~Npc();

		// non-copyable
		Npc(const Npc&) = delete;
		Npc& operator=(const Npc&) = delete;

		Npc* getNpc() final {
			return this;
		}
		const Npc* getNpc() const final {
			return this;
		}

		bool isPushable() const final {
			return baseSpeed > 0;
		}

		void setID() final {
			if (id == 0) {
				id = npcAutoID++;
			}
		}

		void removeList() final;
		void addList() final;

		static Npc* createNpc(const std::string& name);

		bool canSee(const Position& pos) const final;

		bool load();
		void reload();

		const std::string& getName() const final {
			return name;
		}
		const std::string& getNameDescription() const final {
			return name;
		}

		void doSay(const std::string& text);

		void doMoveTo(const Position& pos);

		int32_t getMasterRadius() const {
			return masterRadius;
		}
		const Position& getMasterPos() const {
			return masterPos;
		}
		void setMasterPos(Position pos, int32_t radius = 1) {
			masterPos = pos;
			if (masterRadius == 0) {
				masterRadius = radius;
			}
		}

		void turnToCreature(Creature* creature);
		void setCreatureFocus(Creature* creature);

		static uint32_t npcAutoID;

	protected:
		explicit Npc(const std::string& name);

		void onCreatureAppear(Creature* creature, bool isLogin) final;
		void onRemoveCreature(Creature* creature, bool isLogout) final;
		void onCreatureMove(Creature* creature, const Tile* newTile, const Position& newPos,
		                            const Tile* oldTile, const Position& oldPos, bool teleport) final;

		void onCreatureSay(Creature* creature, SpeakClasses type, const std::string& text) final;
		void onThink(uint32_t interval) final;
		std::string getDescription(int32_t lookDistance) const final;

		bool isImmune(CombatType_t) const final {
			return true;
		}
		bool isImmune(ConditionType_t) const final {
			return true;
		}
		bool isAttackable() const final {
			return false;
		}
		bool getNextStep(Direction& dir, uint32_t& flags) final;

		void setIdle(bool idle);
		void updateIdleStatus();

		bool canWalkTo(const Position& fromPos, Direction dir) const;
		bool getRandomStep(Direction& dir) const;

		void reset();

		std::set<Player*> spectators;

		std::string name;
		std::string filename;

		Position masterPos;

		uint32_t lastTalkCreature;
		uint32_t focusCreature;
		uint32_t masterRadius;

		int64_t conversationStartTime;
		int64_t conversationEndTime;
		int64_t staticMovementTime;

		bool loaded;
		bool isIdle;

		BehaviourDatabase* behaviourDatabase;

		friend class Npcs;
		friend class BehaviourDatabase;
};

#endif
