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

#include "rsa.h"

#include <cryptopp/base64.h>
#include <cryptopp/osrng.h>

#include <fstream>
#include <sstream>

static CryptoPP::AutoSeededRandomPool prng;

void RSA::decrypt(char* msg) const
{
	try {
		CryptoPP::Integer m{reinterpret_cast<uint8_t*>(msg), 128};
		auto c = pk.CalculateInverse(prng, m);
		c.Encode(reinterpret_cast<uint8_t*>(msg), 128);
	} catch (const CryptoPP::Exception& e) {
		std::cout << e.what() << '\n';
	}
}

static const std::string header = "-----BEGIN RSA PRIVATE KEY-----";
static const std::string footer = "-----END RSA PRIVATE KEY-----";

void RSA::loadPEM(const std::string& filename)
{
	std::ifstream file{filename};

	if (!file.is_open()) {
		throw std::runtime_error("Missing file " + filename + ".");
 	}

	std::ostringstream oss;
	for (std::string line; std::getline(file, line); oss << line);
	std::string key = oss.str();

	if (key.substr(0, header.size()) != header) {
		throw std::runtime_error("Missing RSA private key header.");
	}

	if (key.substr(key.size() - footer.size(), footer.size()) != footer) {
		throw std::runtime_error("Missing RSA private key footer.");
	}

	key = key.substr(header.size(), key.size() - footer.size());

	CryptoPP::ByteQueue queue;
	CryptoPP::Base64Decoder decoder;
	decoder.Attach(new CryptoPP::Redirector(queue));
	decoder.Put(reinterpret_cast<const uint8_t*>(key.c_str()), key.size());
	decoder.MessageEnd();

	try {
		pk.BERDecodePrivateKey(queue, false, queue.MaxRetrievable());

		if (!pk.Validate(prng, 3)) {
			throw std::runtime_error("RSA private key is not valid.");
		}
	} catch (const CryptoPP::Exception& e) {
		std::cout << e.what() << '\n';
	}
}