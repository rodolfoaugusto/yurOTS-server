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

#ifndef FS_SERVER_H_984DA68ABF744127850F90CC710F281B
#define FS_SERVER_H_984DA68ABF744127850F90CC710F281B

#include "connection.h"
#include <memory>

class Protocol;

class ServiceBase
{
	public:
		virtual bool is_single_socket() const = 0;
		virtual uint8_t get_protocol_identifier() const = 0;
		virtual const char* get_protocol_name() const = 0;

		virtual Protocol_ptr make_protocol(const Connection_ptr& c) const = 0;
};

template <typename ProtocolType>
class Service final : public ServiceBase
{
	public:
		bool is_single_socket() const final {
			return ProtocolType::server_sends_first;
		}
		uint8_t get_protocol_identifier() const final {
			return ProtocolType::protocol_identifier;
		}
		const char* get_protocol_name() const final {
			return ProtocolType::protocol_name();
		}

		Protocol_ptr make_protocol(const Connection_ptr& c) const final {
			return std::make_shared<ProtocolType>(c);
		}
};

class ServicePort : public std::enable_shared_from_this<ServicePort>
{
	public:
		explicit ServicePort(boost::asio::io_service& io_service) : io_service(io_service) {}
		~ServicePort();

		// non-copyable
		ServicePort(const ServicePort&) = delete;
		ServicePort& operator=(const ServicePort&) = delete;

		static void openAcceptor(std::weak_ptr<ServicePort> weak_service, uint16_t port);
		void open(uint16_t port);
		void close();
		bool is_single_socket() const;
		std::string get_protocol_names() const;

		bool add_service(const Service_ptr& new_svc);
		Protocol_ptr make_protocol(NetworkMessage& msg, const Connection_ptr& connection) const;

		void onStopServer();
		void onAccept(Connection_ptr connection, const boost::system::error_code& error);

	protected:
		void accept();

		boost::asio::io_service& io_service;
		std::unique_ptr<boost::asio::ip::tcp::acceptor> acceptor;
		std::vector<Service_ptr> services;

		uint16_t serverPort = 0;
		bool pendingStart = false;
};

class ServiceManager
{
	public:
		ServiceManager() = default;
		~ServiceManager();

		// non-copyable
		ServiceManager(const ServiceManager&) = delete;
		ServiceManager& operator=(const ServiceManager&) = delete;

		void run();
		void stop();

		template <typename ProtocolType>
		bool add(uint16_t port);

		bool is_running() const {
			return acceptors.empty() == false;
		}

	protected:
		void die();

		std::unordered_map<uint16_t, ServicePort_ptr> acceptors;

		boost::asio::io_service io_service;
		boost::asio::deadline_timer death_timer { io_service };
		bool running = false;
};

template <typename ProtocolType>
bool ServiceManager::add(uint16_t port)
{
	if (port == 0) {
		std::cout << "ERROR: No port provided for service " << ProtocolType::protocol_name() << ". Service disabled." << std::endl;
		return false;
	}

	ServicePort_ptr service_port;

	auto foundServicePort = acceptors.find(port);

	if (foundServicePort == acceptors.end()) {
		service_port = std::make_shared<ServicePort>(io_service);
		service_port->open(port);
		acceptors[port] = service_port;
	} else {
		service_port = foundServicePort->second;

		if (service_port->is_single_socket() || ProtocolType::server_sends_first) {
			std::cout << "ERROR: " << ProtocolType::protocol_name() <<
			          " and " << service_port->get_protocol_names() <<
			          " cannot use the same port " << port << '.' << std::endl;
			return false;
		}
	}

	return service_port->add_service(std::make_shared<Service<ProtocolType>>());
}

#endif
