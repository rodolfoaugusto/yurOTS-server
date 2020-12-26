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

#ifndef FS_DEFINITIONS_H_877452FEC245450C9F96B8FD268D8963
#define FS_DEFINITIONS_H_877452FEC245450C9F96B8FD268D8963

static constexpr auto STATUS_SERVER_NAME = "YurOTS";
static constexpr auto STATUS_SERVER_VERSION = "1.5";
static constexpr auto STATUS_SERVER_DEVELOPERS = "https://github.com/rodolfoaugusto";

static constexpr auto CLIENT_VERSION_MIN = 772;
static constexpr auto CLIENT_VERSION_MAX = 772;
static constexpr auto CLIENT_VERSION_STR = "7.72";

#ifndef __FUNCTION__
#define __FUNCTION__ __func__
#endif

#ifndef _USE_MATH_DEFINES
#define _USE_MATH_DEFINES
#endif

#include <cmath>

#ifdef _WIN32
#ifndef NOMINMAX
#define NOMINMAX
#endif

#define WIN32_LEAN_AND_MEAN

#ifdef _MSC_VER
#ifdef NDEBUG
#define _SECURE_SCL 0
#define HAS_ITERATOR_DEBUGGING 0
#endif

#pragma warning(disable:4127) // conditional expression is constant
#pragma warning(disable:4244) // 'argument' : conversion from 'type1' to 'type2', possible loss of data
#pragma warning(disable:4250) // 'class1' : inherits 'class2::member' via dominance
#pragma warning(disable:4267) // 'var' : conversion from 'size_t' to 'type', possible loss of data
#pragma warning(disable:4351) // new behavior: elements of array will be default initialized
#pragma warning(disable:4458) // declaration hides class member
#endif

#define strcasecmp _stricmp
#define strncasecmp _strnicmp

#ifndef _WIN32_WINNT
// 0x0602: Windows 7
#define _WIN32_WINNT 0x0602
#endif
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#endif
