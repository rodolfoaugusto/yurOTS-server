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

#include "configmanager.h"
#include "databasemanager.h"
#include "luascript.h"

extern ConfigManager g_config;

bool DatabaseManager::optimizeTables()
{
	Database* db = Database::getInstance();
	std::ostringstream query;

	query << "SELECT `TABLE_NAME` FROM `information_schema`.`TABLES` WHERE `TABLE_SCHEMA` = " << db->escapeString(g_config.getString(ConfigManager::MYSQL_DB)) << " AND `DATA_FREE` > 0";
	DBResult_ptr result = db->storeQuery(query.str());
	if (!result) {
		return false;
	}

	do {
		std::string tableName = result->getString("TABLE_NAME");
		std::cout << "> Optimizing table " << tableName << "..." << std::flush;

		query.str(std::string());
		query << "OPTIMIZE TABLE `" << tableName << '`';

		if (db->executeQuery(query.str())) {
			std::cout << " [success]" << std::endl;
		} else {
			std::cout << " [failed]" << std::endl;
		}
	} while (result->next());
	return true;
}

bool DatabaseManager::tableExists(const std::string& tableName)
{
	Database* db = Database::getInstance();

	std::ostringstream query;
	query << "SELECT `TABLE_NAME` FROM `information_schema`.`tables` WHERE `TABLE_SCHEMA` = " << db->escapeString(g_config.getString(ConfigManager::MYSQL_DB)) << " AND `TABLE_NAME` = " << db->escapeString(tableName) << " LIMIT 1";
	return db->storeQuery(query.str()).get() != nullptr;
}

bool DatabaseManager::isDatabaseSetup()
{
	Database* db = Database::getInstance();
	std::ostringstream query;
	query << "SELECT `TABLE_NAME` FROM `information_schema`.`tables` WHERE `TABLE_SCHEMA` = " << db->escapeString(g_config.getString(ConfigManager::MYSQL_DB));
	return db->storeQuery(query.str()).get() != nullptr;
}

int32_t DatabaseManager::getDatabaseVersion()
{
	if (!tableExists("server_config")) {
		Database* db = Database::getInstance();
		db->executeQuery("CREATE TABLE `server_config` (`config` VARCHAR(50) NOT NULL, `value` VARCHAR(256) NOT NULL DEFAULT '', UNIQUE(`config`)) ENGINE = InnoDB");
		db->executeQuery("INSERT INTO `server_config` VALUES ('db_version', 0)");
		return 0;
	}

	int32_t version = 0;
	if (getDatabaseConfig("db_version", version)) {
		return version;
	}
	return -1;
}

bool DatabaseManager::getDatabaseConfig(const std::string& config, int32_t& value)
{
	Database* db = Database::getInstance();
	std::ostringstream query;
	query << "SELECT `value` FROM `server_config` WHERE `config` = " << db->escapeString(config);

	DBResult_ptr result = db->storeQuery(query.str());
	if (!result) {
		return false;
	}

	value = result->getNumber<int32_t>("value");
	return true;
}

void DatabaseManager::registerDatabaseConfig(const std::string& config, int32_t value)
{
	Database* db = Database::getInstance();
	std::ostringstream query;

	int32_t tmp;

	if (!getDatabaseConfig(config, tmp)) {
		query << "INSERT INTO `server_config` VALUES (" << db->escapeString(config) << ", '" << value << "')";
	} else {
		query << "UPDATE `server_config` SET `value` = '" << value << "' WHERE `config` = " << db->escapeString(config);
	}

	db->executeQuery(query.str());
}
