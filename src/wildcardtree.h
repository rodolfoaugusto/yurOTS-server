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

#ifndef FS_WILDCARDTREE_H_054C9BA46A1D4EA4B7C77ECE60ED4DEB
#define FS_WILDCARDTREE_H_054C9BA46A1D4EA4B7C77ECE60ED4DEB

#include "enums.h"

class WildcardTreeNode
{
	public:
		explicit WildcardTreeNode(bool breakpoint) : breakpoint(breakpoint) {}
		WildcardTreeNode(WildcardTreeNode&& other) = default;

		// non-copyable
		WildcardTreeNode(const WildcardTreeNode&) = delete;
		WildcardTreeNode& operator=(const WildcardTreeNode&) = delete;

		WildcardTreeNode* getChild(char ch);
		const WildcardTreeNode* getChild(char ch) const;
		WildcardTreeNode* addChild(char ch, bool breakpoint);

		void insert(const std::string& str);
		void remove(const std::string& str);

		ReturnValue findOne(const std::string& query, std::string& result) const;

	private:
		std::map<char, WildcardTreeNode> children;
		bool breakpoint;
};

#endif
