-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: 28-Dez-2020 às 12:54
-- Versão do servidor: 5.7.32-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yurots`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `password` char(40) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `password`, `type`, `premdays`, `lastday`, `name`) VALUES
(1234567, '41da8bef22aaef9d7c5821fa0f0de7cccc4dda4d', 5, 0, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Acionadores `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `started` bigint(15) NOT NULL DEFAULT '0',
  `ended` bigint(15) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `beds` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(1, 0, 0, 0, 'Pirate Street', 23000, 1, 0, 0, 0, 0, 46, 0),
(2, 0, 0, 0, 'River Street V', 23000, 1, 0, 0, 0, 0, 16, 0),
(3, 0, 0, 0, 'River Street IV', 23000, 1, 0, 0, 0, 0, 16, 0),
(4, 0, 0, 0, 'River Street III', 23000, 1, 0, 0, 0, 0, 16, 0),
(5, 0, 0, 0, 'River Street II', 23000, 1, 0, 0, 0, 0, 13, 0),
(6, 0, 0, 0, 'River Street I', 23000, 1, 0, 0, 0, 0, 13, 0),
(7, 0, 0, 0, 'Small Street I', 13000, 1, 0, 0, 0, 0, 7, 0),
(8, 0, 0, 0, 'Small Street II', 8000, 1, 0, 0, 0, 0, 4, 0),
(9, 0, 0, 0, 'Small Street III', 13000, 1, 0, 0, 0, 0, 7, 0),
(10, 0, 0, 0, 'Small Street IV', 8000, 1, 0, 0, 0, 0, 4, 0),
(11, 0, 0, 0, 'Small Street V', 13000, 1, 0, 0, 0, 0, 7, 0),
(12, 0, 0, 0, 'Small Street VI', 8000, 1, 0, 0, 0, 0, 4, 0),
(13, 0, 0, 0, 'Great Street I', 13000, 1, 0, 0, 0, 0, 42, 0),
(14, 0, 0, 0, 'Great Street II', 13000, 1, 0, 0, 0, 0, 22, 0),
(15, 0, 0, 0, 'Great Street III', 13000, 1, 0, 0, 0, 0, 25, 0),
(16, 0, 0, 0, 'Great Street IV', 13000, 1, 0, 0, 0, 0, 37, 0),
(17, 0, 0, 0, 'Upper Street I', 23000, 1, 0, 0, 0, 0, 35, 0),
(18, 0, 0, 0, 'Upper Street III', 23000, 1, 0, 0, 0, 0, 13, 0),
(19, 0, 0, 0, 'Upper Street II', 23000, 1, 0, 0, 0, 0, 16, 0),
(20, 0, 0, 0, 'Upper Street IV', 23000, 1, 0, 0, 0, 0, 24, 0),
(21, 0, 0, 0, 'Upper Street V', 23000, 1, 0, 0, 0, 0, 26, 0),
(22, 0, 0, 0, 'Green Street III', 13000, 1, 0, 0, 0, 0, 16, 0),
(23, 0, 0, 0, 'Green Street II', 13000, 1, 0, 0, 0, 0, 16, 0),
(24, 0, 0, 0, 'Green Street I', 13000, 1, 0, 0, 0, 0, 16, 0),
(25, 0, 0, 0, 'Castle of the Snakes', 100000, 1, 0, 0, 0, 0, 317, 0),
(26, 0, 0, 0, 'The Tibianic', 200000, 1, 0, 0, 0, 0, 367, 0),
(27, 0, 0, 0, 'Desert Street V', 3000, 1, 0, 0, 0, 0, 22, 0),
(28, 0, 0, 0, 'Desert Street VI', 3000, 1, 0, 0, 0, 0, 23, 0),
(29, 0, 0, 0, 'Desert Street II', 3000, 1, 0, 0, 0, 0, 16, 0),
(30, 0, 0, 0, 'Desert Street I', 3000, 1, 0, 0, 0, 0, 16, 0),
(31, 0, 0, 0, 'Desert Street IV', 3000, 1, 0, 0, 0, 0, 31, 0),
(32, 0, 0, 0, 'Desert Street III', 3000, 1, 0, 0, 0, 0, 16, 0),
(33, 0, 0, 0, 'Sand Mansion', 53000, 1, 0, 0, 0, 0, 142, 0),
(34, 0, 0, 0, 'Alai Flats, Flat 06', 0, 2, 0, 0, 0, 0, 25, 2),
(35, 0, 0, 0, 'Jungle I', 13000, 1, 0, 0, 0, 0, 16, 0),
(36, 0, 0, 0, 'Jungle II', 13000, 1, 0, 0, 0, 0, 14, 0),
(37, 0, 0, 0, 'Jungle III', 13000, 1, 0, 0, 0, 0, 13, 0),
(38, 0, 0, 0, 'Jungle IV', 13000, 1, 0, 0, 0, 0, 13, 0),
(39, 0, 0, 0, 'Ice Land I', 13000, 1, 0, 0, 0, 0, 74, 0),
(40, 0, 0, 0, 'Ice Land II', 13000, 1, 0, 0, 0, 0, 27, 2),
(41, 0, 0, 0, 'Ice Land Gate', 23000, 1, 0, 0, 0, 0, 54, 2),
(42, 0, 0, 0, 'Ice Land III', 13000, 1, 0, 0, 0, 0, 34, 2),
(43, 0, 0, 0, 'Ice Land IV', 13000, 1, 0, 0, 0, 0, 66, 0),
(44, 0, 0, 0, 'Ice Land V', 13000, 1, 0, 0, 0, 0, 21, 0),
(45, 0, 0, 0, 'Ice Land VI', 13000, 1, 0, 0, 0, 0, 56, 2),
(46, 0, 0, 0, 'Ice Land VII', 13000, 1, 0, 0, 0, 0, 17, 1),
(47, 0, 0, 0, 'Ice Land VIII', 13000, 1, 0, 0, 0, 0, 17, 1),
(48, 0, 0, 0, 'Ice Land IX', 13000, 1, 0, 0, 0, 0, 17, 1),
(49, 0, 0, 0, 'Ice Land X', 13000, 1, 0, 0, 0, 0, 17, 2),
(50, 0, 0, 0, 'Ice Land XI', 13000, 1, 0, 0, 0, 0, 17, 1),
(51, 0, 0, 0, 'Ice Land XII', 13000, 1, 0, 0, 0, 0, 17, 1),
(52, 0, 0, 0, 'Ice Land XIII', 13000, 1, 0, 0, 0, 0, 17, 1),
(53, 0, 0, 0, 'Ice Land XIV', 13000, 1, 0, 0, 0, 0, 34, 2),
(54, 0, 0, 0, 'Upper Swamp Lane 4', 300, 2, 0, 0, 0, 0, 89, 4),
(55, 0, 0, 0, 'Lower Swamp Lane 1', 300, 2, 0, 0, 0, 0, 89, 4),
(56, 0, 0, 0, 'Lower Swamp Lane 3', 300, 2, 0, 0, 0, 0, 89, 4),
(57, 0, 0, 0, 'Upper Swamp Lane 8', 200, 2, 0, 0, 0, 0, 151, 3),
(58, 0, 0, 0, 'Southern Thais Guildhall', 1500, 2, 0, 0, 0, 0, 446, 16),
(59, 0, 0, 0, 'Upper Swamp Lane 10', 200, 2, 0, 0, 0, 0, 31, 3),
(60, 0, 0, 0, 'Upper Swamp Lane 12', 200, 2, 0, 0, 0, 0, 72, 3),
(61, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 100, 2, 0, 0, 0, 0, 21, 2),
(62, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 100, 2, 0, 0, 0, 0, 17, 2),
(63, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 105, 2, 0, 0, 0, 0, 21, 2),
(64, 0, 0, 0, 'Sorcerer\'s Avenue 5', 105, 2, 0, 0, 0, 0, 50, 1),
(65, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 105, 2, 0, 0, 0, 0, 13, 1),
(66, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 105, 2, 0, 0, 0, 0, 13, 1),
(67, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 105, 2, 0, 0, 0, 0, 13, 1),
(68, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 105, 2, 0, 0, 0, 0, 13, 1),
(69, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 105, 2, 0, 0, 0, 0, 13, 1),
(70, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 105, 2, 0, 0, 0, 0, 13, 1),
(71, 0, 0, 0, 'Thais Clanhall', 900, 2, 0, 0, 0, 0, 227, 10),
(72, 0, 0, 0, 'Harbour Street 4', 0, 2, 0, 0, 0, 0, 17, 1),
(73, 0, 0, 0, 'Thais Hostel', 2300, 2, 0, 0, 0, 0, 120, 24),
(74, 0, 0, 0, 'Farm Lane, Basement (Shop)', 0, 2, 0, 0, 0, 0, 21, 0),
(75, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 0, 2, 0, 0, 0, 0, 21, 0),
(76, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 0, 2, 0, 0, 0, 0, 21, 0),
(77, 0, 0, 0, 'Warriors Guildhall', 1000, 2, 0, 0, 0, 0, 382, 11),
(78, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 0, 2, 0, 0, 0, 0, 34, 0),
(79, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 0, 2, 0, 0, 0, 0, 17, 0),
(80, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 0, 2, 0, 0, 0, 0, 30, 0),
(81, 0, 0, 0, 'Mill Avenue 1 (Shop)', 0, 2, 0, 0, 0, 0, 29, 1),
(82, 0, 0, 0, 'Mill Avenue 2 (Shop)', 100, 2, 0, 0, 0, 0, 49, 2),
(83, 0, 0, 0, 'Mill Avenue 3', 100, 2, 0, 0, 0, 0, 26, 2),
(84, 0, 0, 0, 'Mill Avenue 4', 100, 2, 0, 0, 0, 0, 26, 2),
(85, 0, 0, 0, 'Mill Avenue 5', 300, 2, 0, 0, 0, 0, 70, 4),
(86, 0, 0, 0, 'The City Wall 5a', 0, 2, 0, 0, 0, 0, 13, 1),
(87, 0, 0, 0, 'The City Wall 5b', 0, 2, 0, 0, 0, 0, 13, 1),
(88, 0, 0, 0, 'The City Wall 5c', 0, 2, 0, 0, 0, 0, 13, 1),
(89, 0, 0, 0, 'The City Wall 5d', 0, 2, 0, 0, 0, 0, 13, 1),
(90, 0, 0, 0, 'The City Wall 5e', 0, 2, 0, 0, 0, 0, 13, 1),
(91, 0, 0, 0, 'The City Wall 5f', 0, 2, 0, 0, 0, 0, 13, 1),
(92, 0, 0, 0, 'The City Wall 7a', 0, 2, 0, 0, 0, 0, 13, 1),
(93, 0, 0, 0, 'The City Wall 7b', 0, 2, 0, 0, 0, 0, 13, 1),
(94, 0, 0, 0, 'The City Wall 7c', 100, 2, 0, 0, 0, 0, 17, 2),
(95, 0, 0, 0, 'The City Wall 7d', 100, 2, 0, 0, 0, 0, 17, 2),
(96, 0, 0, 0, 'The City Wall 7e', 100, 2, 0, 0, 0, 0, 17, 2),
(97, 0, 0, 0, 'The City Wall 7f', 100, 2, 0, 0, 0, 0, 17, 2),
(98, 0, 0, 0, 'The City Wall 7g', 0, 2, 0, 0, 0, 0, 13, 1),
(99, 0, 0, 0, 'The City Wall 7h', 0, 2, 0, 0, 0, 0, 13, 1),
(100, 0, 0, 0, 'The City Wall 9', 100, 2, 0, 0, 0, 0, 19, 2),
(101, 0, 0, 0, 'The City Wall 3a', 100, 2, 0, 0, 0, 0, 21, 2),
(102, 0, 0, 0, 'The City Wall 3b', 100, 2, 0, 0, 0, 0, 21, 2),
(103, 0, 0, 0, 'The City Wall 3c', 100, 2, 0, 0, 0, 0, 21, 2),
(104, 0, 0, 0, 'The City Wall 3d', 100, 2, 0, 0, 0, 0, 21, 2),
(105, 0, 0, 0, 'The City Wall 3e', 100, 2, 0, 0, 0, 0, 21, 2),
(106, 0, 0, 0, 'The City Wall 3f', 100, 2, 0, 0, 0, 0, 21, 2),
(107, 0, 0, 0, 'The City Wall 1a', 100, 2, 0, 0, 0, 0, 26, 2),
(108, 0, 0, 0, 'The City Wall 1b', 100, 2, 0, 0, 0, 0, 26, 2),
(109, 0, 0, 0, 'Harbour Place 2 (Shop)', 0, 2, 0, 0, 0, 0, 29, 1),
(110, 0, 0, 0, 'Harbour Place 1 (Shop)', 0, 2, 0, 0, 0, 0, 25, 0),
(111, 0, 0, 0, 'Mercenary Tower', 2500, 2, 0, 0, 0, 0, 729, 26),
(112, 0, 0, 0, 'Guildhall of the Red Rose', 1400, 2, 0, 0, 0, 0, 449, 15),
(113, 0, 0, 0, 'Fibula Village 1', 0, 2, 0, 0, 0, 0, 13, 1),
(114, 0, 0, 0, 'Fibula Village 2', 0, 2, 0, 0, 0, 0, 13, 1),
(115, 0, 0, 0, 'Fibula Village 3', 300, 2, 0, 0, 0, 0, 58, 4),
(116, 0, 0, 0, 'Fibula Village 4', 100, 2, 0, 0, 0, 0, 26, 2),
(117, 0, 0, 0, 'Fibula Village 5', 100, 2, 0, 0, 0, 0, 26, 2),
(118, 0, 0, 0, 'Fibula Village, Tower Flat', 100, 2, 0, 0, 0, 0, 91, 2),
(119, 0, 0, 0, 'Fibula Village, Bar', 100, 2, 0, 0, 0, 0, 86, 2),
(120, 0, 0, 0, 'Fibula Clanhall', 990, 2, 0, 0, 0, 0, 198, 10),
(121, 0, 0, 0, 'Fibula Village, Villa', 600, 2, 0, 0, 0, 0, 288, 7),
(122, 0, 0, 0, 'The Tibianic', 2100, 2, 0, 0, 0, 0, 462, 22),
(123, 0, 0, 0, 'Castle of Greenshore', 1100, 2, 0, 0, 0, 0, 370, 12),
(124, 0, 0, 0, 'Greenshore Village, Villa', 300, 2, 0, 0, 0, 0, 199, 4),
(125, 0, 0, 0, 'Greenshore Village, Shop', 0, 2, 0, 0, 0, 0, 37, 1),
(126, 0, 0, 0, 'Greenshore Village 1', 200, 2, 0, 0, 0, 0, 37, 3),
(127, 0, 0, 0, 'Greenshore Village 2', 0, 2, 0, 0, 0, 0, 13, 1),
(128, 0, 0, 0, 'Greenshore Village 3', 0, 2, 0, 0, 0, 0, 13, 1),
(129, 0, 0, 0, 'Greenshore Village 4', 0, 2, 0, 0, 0, 0, 13, 1),
(130, 0, 0, 0, 'Greenshore Village 5', 0, 2, 0, 0, 0, 0, 13, 1),
(131, 0, 0, 0, 'Greenshore Village 6', 100, 2, 0, 0, 0, 0, 76, 2),
(132, 0, 0, 0, 'Greenshore Village 7', 0, 2, 0, 0, 0, 0, 21, 1),
(133, 0, 0, 0, 'Greenshore Clanhall', 900, 2, 0, 0, 0, 0, 203, 10),
(134, 0, 0, 0, 'Moonkeep', 1500, 3, 0, 0, 0, 0, 366, 16),
(135, 0, 0, 0, 'House of Recreation', 6500, 3, 0, 0, 0, 0, 527, 15),
(136, 0, 0, 0, 'Nordic Stronghold', 1900, 3, 0, 0, 0, 0, 534, 21),
(137, 0, 0, 0, 'Druids Retreat A', 100, 3, 0, 0, 0, 0, 31, 2),
(138, 0, 0, 0, 'Druids Retreat B', 100, 3, 0, 0, 0, 0, 29, 2),
(139, 0, 0, 0, 'Druids Retreat C', 100, 3, 0, 0, 0, 0, 22, 2),
(140, 0, 0, 0, 'Druids Retreat D', 100, 3, 0, 0, 0, 0, 27, 2),
(141, 0, 0, 0, 'Central Plaza 3', 0, 3, 0, 0, 0, 0, 12, 0),
(142, 0, 0, 0, 'Central Plaza 2', 0, 3, 0, 0, 0, 0, 12, 0),
(143, 0, 0, 0, 'Central Plaza 1', 0, 3, 0, 0, 0, 0, 12, 0),
(144, 0, 0, 0, 'Park Lane 1a', 100, 3, 0, 0, 0, 0, 28, 2),
(145, 0, 0, 0, 'Park Lane 1b', 100, 3, 0, 0, 0, 0, 32, 2),
(146, 0, 0, 0, 'Park Lane 3b', 2100, 2, 0, 0, 0, 0, 25, 2),
(147, 0, 0, 0, 'Park Lane 3b', 100, 3, 0, 0, 0, 0, 25, 2),
(148, 0, 0, 0, 'Park Lane 3a', 100, 3, 0, 0, 0, 0, 28, 2),
(149, 0, 0, 0, 'Park Lane 4', 100, 3, 0, 0, 0, 0, 22, 2),
(150, 0, 0, 0, 'Park Lane 2', 100, 3, 0, 0, 0, 0, 22, 2),
(151, 0, 0, 0, 'Theater Avenue 6a', 100, 3, 0, 0, 0, 0, 16, 2),
(152, 0, 0, 0, 'Theater Avenue 6b', 100, 3, 0, 0, 0, 0, 16, 2),
(153, 0, 0, 0, 'Theater Avenue 6c', 0, 3, 0, 0, 0, 0, 5, 1),
(154, 0, 0, 0, 'Theater Avenue 6d', 0, 3, 0, 0, 0, 0, 5, 1),
(155, 0, 0, 0, 'Theater Avenue 6e', 100, 3, 0, 0, 0, 0, 16, 2),
(156, 0, 0, 0, 'Theater Avenue 6f', 100, 3, 0, 0, 0, 0, 16, 2),
(157, 0, 0, 0, 'Theater Avenue 5a', 0, 3, 0, 0, 0, 0, 10, 1),
(158, 0, 0, 0, 'Theater Avenue 5b', 0, 3, 0, 0, 0, 0, 10, 1),
(159, 0, 0, 0, 'Theater Avenue 5c', 0, 3, 0, 0, 0, 0, 10, 1),
(160, 0, 0, 0, 'Theater Avenue 5d', 0, 3, 0, 0, 0, 0, 10, 1),
(161, 0, 0, 0, 'Theater Avenue 8a', 100, 3, 0, 0, 0, 0, 26, 2),
(162, 0, 0, 0, 'Theater Avenue 8b', 200, 3, 0, 0, 0, 0, 26, 3),
(163, 0, 0, 0, 'Theater Avenue 7, Flat 01', 0, 3, 0, 0, 0, 0, 7, 1),
(164, 0, 0, 0, 'Theater Avenue 7, Flat 02', 0, 3, 0, 0, 0, 0, 9, 1),
(165, 0, 0, 0, 'Theater Avenue 7, Flat 03', 0, 3, 0, 0, 0, 0, 9, 1),
(166, 0, 0, 0, 'Theater Avenue 7, Flat 04', 0, 3, 0, 0, 0, 0, 11, 1),
(167, 0, 0, 0, 'Theater Avenue 7, Flat 05', 0, 3, 0, 0, 0, 0, 9, 1),
(168, 0, 0, 0, 'Theater Avenue 7, Flat 06', 0, 3, 0, 0, 0, 0, 7, 1),
(169, 0, 0, 0, 'Theater Avenue 7, Flat 11', 0, 3, 0, 0, 0, 0, 11, 1),
(170, 0, 0, 0, 'Theater Avenue 7, Flat 12', 0, 3, 0, 0, 0, 0, 9, 1),
(171, 0, 0, 0, 'Theater Avenue 7, Flat 13', 0, 3, 0, 0, 0, 0, 9, 1),
(172, 0, 0, 0, 'Theater Avenue 7, Flat 14', 0, 3, 0, 0, 0, 0, 11, 1),
(173, 0, 0, 0, 'Theater Avenue 7, Flat 15', 0, 3, 0, 0, 0, 0, 9, 1),
(174, 0, 0, 0, 'Theater Avenue 7, Flat 16', 0, 3, 0, 0, 0, 0, 9, 1),
(175, 0, 0, 0, 'Theater Avenue 10', 100, 3, 0, 0, 0, 0, 22, 2),
(176, 0, 0, 0, 'Theater Avenue 12', 100, 3, 0, 0, 0, 0, 19, 2),
(177, 0, 0, 0, 'Theater Avenue 14 (Shop)', 0, 3, 0, 0, 0, 0, 47, 1),
(178, 0, 0, 0, 'Theater Avenue 11a', 100, 3, 0, 0, 0, 0, 29, 2),
(179, 0, 0, 0, 'Theater Avenue 11b', 0, 3, 0, 0, 0, 0, 13, 1),
(180, 0, 0, 0, 'Theater Avenue 11c', 0, 3, 0, 0, 0, 0, 13, 1),
(181, 0, 0, 0, 'Magician\'s Alley 1', 100, 3, 0, 0, 0, 0, 19, 2),
(182, 0, 0, 0, 'Magician\'s Alley 1a', 100, 3, 0, 0, 0, 0, 12, 2),
(183, 0, 0, 0, 'Magician\'s Alley 1b', 100, 3, 0, 0, 0, 0, 13, 2),
(184, 0, 0, 0, 'Magician\'s Alley 1c', 0, 3, 0, 0, 0, 0, 10, 1),
(185, 0, 0, 0, 'Magician\'s Alley 1d', 0, 3, 0, 0, 0, 0, 9, 1),
(186, 0, 0, 0, 'Magician\'s Alley 5a', 0, 3, 0, 0, 0, 0, 7, 1),
(187, 0, 0, 0, 'Magician\'s Alley 5b', 0, 3, 0, 0, 0, 0, 10, 1),
(188, 0, 0, 0, 'Magician\'s Alley 5c', 100, 3, 0, 0, 0, 0, 21, 2),
(189, 0, 0, 0, 'Magician\'s Alley 5d', 0, 3, 0, 0, 0, 0, 10, 1),
(190, 0, 0, 0, 'Magician\'s Alley 5e', 0, 3, 0, 0, 0, 0, 10, 1),
(191, 0, 0, 0, 'Magician\'s Alley 5f', 100, 3, 0, 0, 0, 0, 21, 2),
(192, 0, 0, 0, 'Magician\'s Alley 4', 300, 3, 0, 0, 0, 0, 49, 4),
(193, 0, 0, 0, 'Magician\'s Alley 8', 100, 3, 0, 0, 0, 0, 26, 2),
(194, 0, 0, 0, 'Carlin Clanhall', 900, 3, 0, 0, 0, 0, 219, 9),
(195, 0, 0, 0, 'Northern Street 1a', 100, 3, 0, 0, 0, 0, 21, 2),
(196, 0, 0, 0, 'Northern Street 1b', 100, 3, 0, 0, 0, 0, 21, 2),
(197, 0, 0, 0, 'Northern Street 1c', 100, 3, 0, 0, 0, 0, 16, 2),
(198, 0, 0, 0, 'Northern Street 3a', 100, 3, 0, 0, 0, 0, 16, 2),
(199, 0, 0, 0, 'Northern Street 3b', 100, 3, 0, 0, 0, 0, 17, 2),
(200, 0, 0, 0, 'Northern Street 5', 100, 3, 0, 0, 0, 0, 47, 2),
(201, 0, 0, 0, 'Northern Street 7', 100, 3, 0, 0, 0, 0, 40, 2),
(202, 0, 0, 0, 'Harbour Lane 1 (Shop)', 0, 3, 0, 0, 0, 0, 29, 0),
(203, 0, 0, 0, 'Harbour Lane 3', 200, 3, 0, 0, 0, 0, 86, 3),
(204, 0, 0, 0, 'Harbour Lane 2a (Shop)', 0, 3, 0, 0, 0, 0, 19, 0),
(205, 0, 0, 0, 'Harbour Lane 2b (Shop)', 0, 3, 0, 0, 0, 0, 19, 0),
(206, 0, 0, 0, 'Harbour Flats, Flat 11', 0, 3, 0, 0, 0, 0, 13, 1),
(207, 0, 0, 0, 'Harbour Flats, Flat 12', 0, 3, 0, 0, 0, 0, 10, 1),
(208, 0, 0, 0, 'Harbour Flats, Flat 13', 0, 3, 0, 0, 0, 0, 13, 1),
(209, 0, 0, 0, 'Harbour Flats, Flat 14', 0, 3, 0, 0, 0, 0, 10, 1),
(210, 0, 0, 0, 'Harbour Flats, Flat 15', 0, 3, 0, 0, 0, 0, 9, 1),
(211, 0, 0, 0, 'Harbour Flats, Flat 16', 0, 3, 0, 0, 0, 0, 10, 1),
(212, 0, 0, 0, 'Harbour Flats, Flat 17', 0, 3, 0, 0, 0, 0, 9, 1),
(213, 0, 0, 0, 'Harbour Flats, Flat 18', 0, 3, 0, 0, 0, 0, 10, 1),
(214, 0, 0, 0, 'Harbour Flats, Flat 21', 100, 3, 0, 0, 0, 0, 19, 2),
(215, 0, 0, 0, 'Harbour Flats, Flat 22', 100, 3, 0, 0, 0, 0, 22, 2),
(216, 0, 0, 0, 'Harbour Flats, Flat 23', 0, 3, 0, 0, 0, 0, 10, 1),
(217, 0, 0, 0, 'East Lane 1a', 100, 3, 0, 0, 0, 0, 54, 2),
(218, 0, 0, 0, 'East Lane 1b', 100, 3, 0, 0, 0, 0, 40, 2),
(219, 0, 0, 0, 'East Lane 2', 100, 3, 0, 0, 0, 0, 113, 2),
(220, 0, 0, 0, 'Suntower', 800, 3, 0, 0, 0, 0, 288, 9),
(221, 0, 0, 0, 'Lonely Sea Side Hostel', 700, 3, 0, 0, 0, 0, 324, 8),
(222, 0, 0, 0, 'Northport Village 1', 100, 3, 0, 0, 0, 0, 25, 2),
(223, 0, 0, 0, 'Northport Village 2', 100, 3, 0, 0, 0, 0, 25, 2),
(224, 0, 0, 0, 'Northport Village 3', 100, 3, 0, 0, 0, 0, 104, 2),
(225, 0, 0, 0, 'Northport Village 4', 100, 3, 0, 0, 0, 0, 47, 1),
(226, 0, 0, 0, 'Seawatch', 1800, 3, 0, 0, 0, 0, 513, 19),
(227, 0, 0, 0, 'Northport Village 5', 100, 3, 0, 0, 0, 0, 31, 2),
(228, 0, 0, 0, 'Northport Village 6', 100, 3, 0, 0, 0, 0, 37, 2),
(229, 0, 0, 0, 'Northport Clanhall', 900, 3, 0, 0, 0, 0, 197, 10),
(230, 0, 0, 0, 'Senja Village 1a', 0, 3, 0, 0, 0, 0, 17, 1),
(231, 0, 0, 0, 'Senja Village 1b', 100, 3, 0, 0, 0, 0, 37, 2),
(232, 0, 0, 0, 'Senja Village 2', 0, 3, 0, 0, 0, 0, 17, 1),
(233, 0, 0, 0, 'Senja Village 3', 100, 3, 0, 0, 0, 0, 37, 2),
(234, 0, 0, 0, 'Senja Village 4', 0, 3, 0, 0, 0, 0, 17, 1),
(235, 0, 0, 0, 'Senja Village 5', 100, 3, 0, 0, 0, 0, 25, 2),
(236, 0, 0, 0, 'Senja Village 6a', 0, 3, 0, 0, 0, 0, 17, 1),
(237, 0, 0, 0, 'Senja Village 6b', 0, 3, 0, 0, 0, 0, 17, 1),
(238, 0, 0, 0, 'Senja Village 7', 100, 3, 0, 0, 0, 0, 17, 2),
(239, 0, 0, 0, 'Senja Village 8', 100, 3, 0, 0, 0, 0, 35, 2),
(240, 0, 0, 0, 'Senja Village 9', 100, 3, 0, 0, 0, 0, 61, 2),
(241, 0, 0, 0, 'Senja Village 10', 0, 3, 0, 0, 0, 0, 33, 1),
(242, 0, 0, 0, 'Senja Village 11', 100, 3, 0, 0, 0, 0, 61, 2),
(243, 0, 0, 0, 'Senja Clanhall', 900, 3, 0, 0, 0, 0, 271, 10),
(244, 0, 0, 0, 'Wolftower', 2200, 4, 0, 0, 0, 0, 464, 23),
(245, 0, 0, 0, 'Hill Hideout', 1400, 4, 0, 0, 0, 0, 290, 15),
(246, 0, 0, 0, 'Riverspring', 1800, 4, 0, 0, 0, 0, 432, 19),
(247, 0, 0, 0, 'The Farms 1', 200, 4, 0, 0, 0, 0, 45, 3),
(248, 0, 0, 0, 'The Farms 2', 100, 4, 0, 0, 0, 0, 26, 2),
(249, 0, 0, 0, 'The Farms 3', 100, 4, 0, 0, 0, 0, 26, 2),
(250, 0, 0, 0, 'The Farms 4', 100, 4, 0, 0, 0, 0, 26, 2),
(251, 0, 0, 0, 'The Farms 5', 100, 4, 0, 0, 0, 0, 26, 2),
(252, 0, 0, 0, 'The Farms 6, Fishing Hut', 100, 4, 0, 0, 0, 0, 21, 2),
(253, 0, 0, 0, 'Nobility Quarter 1', 200, 4, 0, 0, 0, 0, 37, 3),
(254, 0, 0, 0, 'Nobility Quarter 2', 200, 4, 0, 0, 0, 0, 37, 3),
(255, 0, 0, 0, 'Nobility Quarter 3', 200, 4, 0, 0, 0, 0, 37, 3),
(256, 0, 0, 0, 'Nobility Quarter 4', 0, 4, 0, 0, 0, 0, 17, 1),
(257, 0, 0, 0, 'Nobility Quarter 5', 0, 4, 0, 0, 0, 0, 17, 1),
(258, 0, 0, 0, 'Nobility Quarter 6', 0, 4, 0, 0, 0, 0, 17, 1),
(259, 0, 0, 0, 'Nobility Quarter 7', 0, 4, 0, 0, 0, 0, 17, 1),
(260, 0, 0, 0, 'Nobility Quarter 8', 0, 4, 0, 0, 0, 0, 17, 1),
(261, 0, 0, 0, 'Nobility Quarter 9', 0, 4, 0, 0, 0, 0, 17, 1),
(262, 0, 0, 0, 'Upper Barracks 1', 0, 4, 0, 0, 0, 0, 7, 1),
(263, 0, 0, 0, 'Upper Barracks 2', 0, 4, 0, 0, 0, 0, 7, 1),
(264, 0, 0, 0, 'Upper Barracks 3', 0, 4, 0, 0, 0, 0, 7, 1),
(265, 0, 0, 0, 'Upper Barracks 4', 0, 4, 0, 0, 0, 0, 7, 1),
(266, 0, 0, 0, 'Upper Barracks 5', 0, 4, 0, 0, 0, 0, 7, 1),
(267, 0, 0, 0, 'Upper Barracks 6', 0, 4, 0, 0, 0, 0, 7, 1),
(268, 0, 0, 0, 'Upper Barracks 7', 0, 4, 0, 0, 0, 0, 7, 1),
(269, 0, 0, 0, 'Upper Barracks 8', 0, 4, 0, 0, 0, 0, 7, 1),
(270, 0, 0, 0, 'Upper Barracks 9', 0, 4, 0, 0, 0, 0, 7, 1),
(271, 0, 0, 0, 'Upper Barracks 10', 0, 4, 0, 0, 0, 0, 7, 1),
(272, 0, 0, 0, 'Upper Barracks 11', 0, 4, 0, 0, 0, 0, 7, 1),
(273, 0, 0, 0, 'Upper Barracks 12', 0, 4, 0, 0, 0, 0, 7, 1),
(274, 0, 0, 0, 'Upper Barracks 13', 0, 4, 0, 0, 0, 0, 16, 2),
(275, 0, 0, 0, 'The Market 1 (Shop)', 0, 4, 0, 0, 0, 0, 13, 0),
(276, 0, 0, 0, 'The Market 2 (Shop)', 0, 4, 0, 0, 0, 0, 22, 0),
(277, 0, 0, 0, 'The Market 3 (Shop)', 0, 4, 0, 0, 0, 0, 29, 0),
(278, 0, 0, 0, 'The Market 4 (Shop)', 0, 4, 0, 0, 0, 0, 36, 0),
(279, 0, 0, 0, 'Lower Barracks 1', 0, 4, 0, 0, 0, 0, 10, 1),
(280, 0, 0, 0, 'Lower Barracks 2', 0, 4, 0, 0, 0, 0, 10, 1),
(281, 0, 0, 0, 'Lower Barracks 3', 0, 4, 0, 0, 0, 0, 10, 1),
(282, 0, 0, 0, 'Lower Barracks 4', 0, 4, 0, 0, 0, 0, 10, 1),
(283, 0, 0, 0, 'Lower Barracks 5', 0, 4, 0, 0, 0, 0, 10, 1),
(284, 0, 0, 0, 'Lower Barracks 6', 0, 4, 0, 0, 0, 0, 10, 1),
(285, 0, 0, 0, 'Lower Barracks 7', 0, 4, 0, 0, 0, 0, 10, 1),
(286, 0, 0, 0, 'Lower Barracks 8', 0, 4, 0, 0, 0, 0, 10, 1),
(287, 0, 0, 0, 'Lower Barracks 9', 0, 4, 0, 0, 0, 0, 10, 1),
(288, 0, 0, 0, 'Lower Barracks 10', 0, 4, 0, 0, 0, 0, 10, 1),
(289, 0, 0, 0, 'Lower Barracks 11', 0, 4, 0, 0, 0, 0, 10, 1),
(290, 0, 0, 0, 'Lower Barracks 12', 0, 4, 0, 0, 0, 0, 10, 1),
(291, 0, 0, 0, 'Lower Barracks 13', 0, 4, 0, 0, 0, 0, 10, 1),
(292, 0, 0, 0, 'Lower Barracks 14', 0, 4, 0, 0, 0, 0, 10, 1),
(293, 0, 0, 0, 'Lower Barracks 15', 0, 4, 0, 0, 0, 0, 10, 1),
(294, 0, 0, 0, 'Lower Barracks 16', 0, 4, 0, 0, 0, 0, 10, 1),
(295, 0, 0, 0, 'Lower Barracks 17', 0, 4, 0, 0, 0, 0, 10, 1),
(296, 0, 0, 0, 'Lower Barracks 18', 0, 4, 0, 0, 0, 0, 10, 1),
(297, 0, 0, 0, 'Lower Barracks 19', 0, 4, 0, 0, 0, 0, 10, 1),
(298, 0, 0, 0, 'Lower Barracks 20', 0, 4, 0, 0, 0, 0, 10, 1),
(299, 0, 0, 0, 'Lower Barracks 21', 0, 4, 0, 0, 0, 0, 10, 1),
(300, 0, 0, 0, 'Lower Barracks 22', 0, 4, 0, 0, 0, 0, 10, 1),
(301, 0, 0, 0, 'Lower Barracks 23', 0, 4, 0, 0, 0, 0, 10, 1),
(302, 0, 0, 0, 'Lower Barracks 24', 0, 4, 0, 0, 0, 0, 10, 1),
(303, 0, 0, 0, 'Tunnel Gardens 1', 200, 4, 0, 0, 0, 0, 27, 3),
(304, 0, 0, 0, 'Tunnel Gardens 2', 200, 4, 0, 0, 0, 0, 27, 3),
(305, 0, 0, 0, 'Tunnel Gardens 3', 200, 4, 0, 0, 0, 0, 30, 3),
(306, 0, 0, 0, 'Tunnel Gardens 4', 200, 4, 0, 0, 0, 0, 30, 3),
(307, 0, 0, 0, 'Tunnel Gardens 5', 100, 4, 0, 0, 0, 0, 21, 2),
(308, 0, 0, 0, 'Tunnel Gardens 6', 100, 4, 0, 0, 0, 0, 21, 2),
(309, 0, 0, 0, 'Tunnel Gardens 7', 100, 4, 0, 0, 0, 0, 21, 2),
(310, 0, 0, 0, 'Tunnel Gardens 8', 100, 4, 0, 0, 0, 0, 21, 2),
(311, 0, 0, 0, 'Tunnel Gardens 9', 100, 4, 0, 0, 0, 0, 15, 2),
(312, 0, 0, 0, 'Tunnel Gardens 10', 100, 4, 0, 0, 0, 0, 15, 2),
(313, 0, 0, 0, 'Tunnel Gardens 11', 100, 4, 0, 0, 0, 0, 16, 2),
(314, 0, 0, 0, 'Tunnel Gardens 12', 100, 4, 0, 0, 0, 0, 16, 2),
(315, 0, 0, 0, 'Marble Guildhall', 1600, 4, 0, 0, 0, 0, 427, 17),
(316, 0, 0, 0, 'Iron Guildhall', 1700, 4, 0, 0, 0, 0, 377, 18),
(317, 0, 0, 0, 'Granite Guildhall', 1600, 4, 0, 0, 0, 0, 434, 17),
(318, 0, 0, 0, 'Outlaw Camp 1', 100, 4, 0, 0, 0, 0, 42, 2),
(319, 0, 0, 0, 'Outlaw Camp 2', 0, 4, 0, 0, 0, 0, 7, 1),
(320, 0, 0, 0, 'Outlaw Camp 3', 100, 4, 0, 0, 0, 0, 16, 2),
(321, 0, 0, 0, 'Outlaw Camp 4', 0, 4, 0, 0, 0, 0, 5, 1),
(322, 0, 0, 0, 'Outlaw Camp 5', 0, 4, 0, 0, 0, 0, 5, 1),
(323, 0, 0, 0, 'Outlaw Camp 6', 0, 4, 0, 0, 0, 0, 5, 1),
(324, 0, 0, 0, 'Outlaw Camp 7', 100, 4, 0, 0, 0, 0, 17, 2),
(325, 0, 0, 0, 'Outlaw Camp 8', 0, 4, 0, 0, 0, 0, 7, 1),
(326, 0, 0, 0, 'Outlaw Camp 9', 0, 4, 0, 0, 0, 0, 5, 1),
(327, 0, 0, 0, 'Outlaw Camp 10', 0, 4, 0, 0, 0, 0, 5, 1),
(328, 0, 0, 0, 'Outlaw Camp 11', 0, 4, 0, 0, 0, 0, 5, 1),
(329, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 0, 4, 0, 0, 0, 0, 9, 0),
(330, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 0, 4, 0, 0, 0, 0, 9, 0),
(331, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 0, 4, 0, 0, 0, 0, 20, 0),
(332, 0, 0, 0, 'Outlaw Castle', 800, 4, 0, 0, 0, 0, 218, 9),
(333, 0, 0, 0, 'Blessed Shield Guildhall', 800, 8, 0, 0, 0, 0, 190, 9),
(334, 0, 0, 0, 'Steel Home', 1200, 8, 0, 0, 0, 0, 325, 13),
(335, 0, 0, 0, 'Swamp Watch', 1100, 8, 0, 0, 0, 0, 259, 12),
(336, 0, 0, 0, 'Golden Axe Guildhall', 900, 8, 0, 0, 0, 0, 265, 10),
(337, 0, 0, 0, 'Valorous Venore', 800, 8, 0, 0, 0, 0, 364, 9),
(338, 0, 0, 0, 'Dagger Alley 1', 100, 8, 0, 0, 0, 0, 61, 2),
(339, 0, 0, 0, 'Iron Alley 1', 300, 8, 0, 0, 0, 0, 73, 4),
(340, 0, 0, 0, 'Iron Alley 2', 300, 8, 0, 0, 0, 0, 73, 4),
(341, 0, 0, 0, 'Dream Street 1 (Shop)', 100, 8, 0, 0, 0, 0, 109, 2),
(342, 0, 0, 0, 'Dream Street 2', 100, 8, 0, 0, 0, 0, 82, 2),
(343, 0, 0, 0, 'Dream Street 3', 100, 8, 0, 0, 0, 0, 61, 2),
(344, 0, 0, 0, 'Dream Street 4', 300, 8, 0, 0, 0, 0, 91, 4),
(345, 0, 0, 0, 'Elm Street 1', 100, 8, 0, 0, 0, 0, 61, 2),
(346, 0, 0, 0, 'Elm Street 2', 100, 8, 0, 0, 0, 0, 61, 2),
(347, 0, 0, 0, 'Elm Street 3', 200, 8, 0, 0, 0, 0, 61, 3),
(348, 0, 0, 0, 'Elm Street 4', 100, 8, 0, 0, 0, 0, 61, 2),
(349, 0, 0, 0, 'Seagull Walk 1', 100, 8, 0, 0, 0, 0, 129, 2),
(350, 0, 0, 0, 'Seagull Walk 2', 200, 8, 0, 0, 0, 0, 67, 3),
(351, 0, 0, 0, 'Lucky Lane 1 (Shop)', 300, 8, 0, 0, 0, 0, 169, 4),
(352, 0, 0, 0, 'Paupers Palace, Flat 01', 0, 8, 0, 0, 0, 0, 9, 1),
(353, 0, 0, 0, 'Paupers Palace, Flat 02', 0, 8, 0, 0, 0, 0, 10, 1),
(354, 0, 0, 0, 'Paupers Palace, Flat 03', 0, 8, 0, 0, 0, 0, 9, 1),
(355, 0, 0, 0, 'Paupers Palace, Flat 04', 0, 8, 0, 0, 0, 0, 10, 1),
(356, 0, 0, 0, 'Paupers Palace, Flat 05', 0, 8, 0, 0, 0, 0, 7, 1),
(357, 0, 0, 0, 'Paupers Palace, Flat 06', 0, 8, 0, 0, 0, 0, 10, 1),
(358, 0, 0, 0, 'Paupers Palace, Flat 07', 100, 8, 0, 0, 0, 0, 13, 2),
(359, 0, 0, 0, 'Paupers Palace, Flat 12', 100, 8, 0, 0, 0, 0, 13, 2),
(360, 0, 0, 0, 'Paupers Palace, Flat 11', 0, 8, 0, 0, 0, 0, 7, 1),
(361, 0, 0, 0, 'Paupers Palace, Flat 13', 0, 8, 0, 0, 0, 0, 10, 1),
(362, 0, 0, 0, 'Paupers Palace, Flat 14', 0, 8, 0, 0, 0, 0, 13, 1),
(363, 0, 0, 0, 'Paupers Palace, Flat 15', 0, 8, 0, 0, 0, 0, 10, 1),
(364, 0, 0, 0, 'Paupers Palace, Flat 16', 0, 8, 0, 0, 0, 0, 13, 1),
(365, 0, 0, 0, 'Paupers Palace, Flat 17', 0, 8, 0, 0, 0, 0, 10, 1),
(366, 0, 0, 0, 'Paupers Palace, Flat 18', 0, 8, 0, 0, 0, 0, 7, 1),
(367, 0, 0, 0, 'Paupers Palace, Flat 21', 0, 8, 0, 0, 0, 0, 7, 1),
(368, 0, 0, 0, 'Paupers Palace, Flat 22', 0, 8, 0, 0, 0, 0, 10, 1),
(369, 0, 0, 0, 'Paupers Palace, Flat 23', 0, 8, 0, 0, 0, 0, 13, 1),
(370, 0, 0, 0, 'Paupers Palace, Flat 24', 0, 8, 0, 0, 0, 0, 10, 1),
(371, 0, 0, 0, 'Paupers Palace, Flat 25', 0, 8, 0, 0, 0, 0, 13, 1),
(372, 0, 0, 0, 'Paupers Palace, Flat 26', 0, 8, 0, 0, 0, 0, 10, 1),
(373, 0, 0, 0, 'Paupers Palace, Flat 27', 100, 8, 0, 0, 0, 0, 13, 2),
(374, 0, 0, 0, 'Paupers Palace, Flat 28', 0, 8, 0, 0, 0, 0, 7, 1),
(375, 0, 0, 0, 'Paupers Palace, Flat 31', 0, 8, 0, 0, 0, 0, 19, 1),
(376, 0, 0, 0, 'Paupers Palace, Flat 32', 100, 8, 0, 0, 0, 0, 25, 2),
(377, 0, 0, 0, 'Paupers Palace, Flat 33', 0, 8, 0, 0, 0, 0, 19, 1),
(378, 0, 0, 0, 'Paupers Palace, Flat 34', 100, 8, 0, 0, 0, 0, 37, 2),
(379, 0, 0, 0, 'Salvation Street 1 (Shop)', 300, 8, 0, 0, 0, 0, 154, 4),
(380, 0, 0, 0, 'Salvation Street 2', 100, 8, 0, 0, 0, 0, 85, 2),
(381, 0, 0, 0, 'Salvation Street 3', 100, 8, 0, 0, 0, 0, 85, 2),
(382, 0, 0, 0, 'Mystic Lane 1', 200, 8, 0, 0, 0, 0, 66, 3),
(383, 0, 0, 0, 'Mystic Lane 2', 100, 8, 0, 0, 0, 0, 66, 2),
(384, 0, 0, 0, 'Silver Street 1', 0, 8, 0, 0, 0, 0, 58, 1),
(385, 0, 0, 0, 'Silver Street 2', 0, 8, 0, 0, 0, 0, 46, 1),
(386, 0, 0, 0, 'Silver Street 3', 0, 8, 0, 0, 0, 0, 46, 1),
(387, 0, 0, 0, 'Silver Street 4', 100, 8, 0, 0, 0, 0, 82, 2),
(388, 0, 0, 0, 'Loot Lane 1 (Shop)', 200, 8, 0, 0, 0, 0, 115, 3),
(389, 0, 0, 0, 'Old Lighthouse', 100, 8, 0, 0, 0, 0, 78, 2),
(390, 0, 0, 0, 'Market Street 1', 200, 8, 0, 0, 0, 0, 161, 3),
(391, 0, 0, 0, 'Market Street 2', 200, 8, 0, 0, 0, 0, 118, 3),
(392, 0, 0, 0, 'Market Street 3', 100, 8, 0, 0, 0, 0, 81, 2),
(393, 0, 0, 0, 'Market Street 4 (Shop)', 200, 8, 0, 0, 0, 0, 127, 3),
(394, 0, 0, 0, 'Market Street 5 (Shop)', 300, 8, 0, 0, 0, 0, 148, 4),
(395, 0, 0, 0, 'Market Street 6', 400, 8, 0, 0, 0, 0, 127, 5),
(396, 0, 0, 0, 'Market Street 7', 100, 8, 0, 0, 0, 0, 55, 2),
(397, 0, 0, 0, 'Shadow Towers', 1700, 5, 0, 0, 0, 0, 427, 18),
(398, 0, 0, 0, 'The Hideout', 1900, 5, 0, 0, 0, 0, 401, 20),
(399, 0, 0, 0, 'Underwood 1', 100, 5, 0, 0, 0, 0, 31, 2),
(400, 0, 0, 0, 'Underwood 2', 100, 5, 0, 0, 0, 0, 31, 2),
(401, 0, 0, 0, 'Underwood 3', 200, 5, 0, 0, 0, 0, 33, 3),
(402, 0, 0, 0, 'Underwood 4', 300, 5, 0, 0, 0, 0, 43, 4),
(403, 0, 0, 0, 'Underwood 5', 200, 5, 0, 0, 0, 0, 26, 2),
(404, 0, 0, 0, 'Underwood 6', 200, 5, 0, 0, 0, 0, 31, 3),
(405, 0, 0, 0, 'Underwood 7', 200, 5, 0, 0, 0, 0, 28, 2),
(406, 0, 0, 0, 'Underwood 8', 100, 5, 0, 0, 0, 0, 17, 2),
(407, 0, 0, 0, 'Underwood 9', 0, 5, 0, 0, 0, 0, 13, 1),
(408, 0, 0, 0, 'Underwood 10', 0, 5, 0, 0, 0, 0, 13, 1),
(409, 0, 0, 0, 'Ab\'Dendriel Clanhall', 900, 5, 0, 0, 0, 0, 354, 10),
(410, 0, 0, 0, 'Castle of the Winds', 1700, 5, 0, 0, 0, 0, 593, 18),
(411, 0, 0, 0, 'Great Willow 1a', 0, 5, 0, 0, 0, 0, 10, 1),
(412, 0, 0, 0, 'Great Willow 1b', 0, 5, 0, 0, 0, 0, 13, 1),
(413, 0, 0, 0, 'Great Willow 1c', 0, 5, 0, 0, 0, 0, 10, 1),
(414, 0, 0, 0, 'Great Willow 2a', 0, 5, 0, 0, 0, 0, 13, 1),
(415, 0, 0, 0, 'Great Willow 2b', 0, 5, 0, 0, 0, 0, 9, 1),
(416, 0, 0, 0, 'Great Willow 2c', 0, 5, 0, 0, 0, 0, 13, 1),
(417, 0, 0, 0, 'Great Willow 2d', 0, 5, 0, 0, 0, 0, 9, 1),
(418, 0, 0, 0, 'Great Willow 3a', 0, 5, 0, 0, 0, 0, 13, 1),
(419, 0, 0, 0, 'Great Willow 3b', 0, 5, 0, 0, 0, 0, 9, 1),
(420, 0, 0, 0, 'Great Willow 3c', 0, 5, 0, 0, 0, 0, 13, 1),
(421, 0, 0, 0, 'Great Willow 3d', 0, 5, 0, 0, 0, 0, 9, 1),
(422, 0, 0, 0, 'Great Willow 4a', 100, 5, 0, 0, 0, 0, 17, 2),
(423, 0, 0, 0, 'Great Willow 4b', 100, 5, 0, 0, 0, 0, 17, 2),
(424, 0, 0, 0, 'Great Willow 4c', 100, 5, 0, 0, 0, 0, 17, 2),
(425, 0, 0, 0, 'Great Willow 4d', 0, 5, 0, 0, 0, 0, 15, 1),
(426, 0, 0, 0, 'Mangrove 1', 200, 5, 0, 0, 0, 0, 31, 3),
(427, 0, 0, 0, 'Mangrove 2', 100, 5, 0, 0, 0, 0, 25, 2),
(428, 0, 0, 0, 'Mangrove 3', 100, 5, 0, 0, 0, 0, 21, 2),
(429, 0, 0, 0, 'Mangrove 4', 100, 5, 0, 0, 0, 0, 17, 2),
(430, 0, 0, 0, 'Treetop 1', 0, 5, 0, 0, 0, 0, 13, 1),
(431, 0, 0, 0, 'Treetop 2', 0, 5, 0, 0, 0, 0, 13, 1),
(432, 0, 0, 0, 'Treetop 3 (Shop)', 0, 5, 0, 0, 0, 0, 25, 1),
(433, 0, 0, 0, 'Treetop 4 (Shop)', 0, 5, 0, 0, 0, 0, 25, 1),
(434, 0, 0, 0, 'Treetop 5 (Shop)', 0, 5, 0, 0, 0, 0, 30, 1),
(435, 0, 0, 0, 'Treetop 6', 0, 5, 0, 0, 0, 0, 9, 1),
(436, 0, 0, 0, 'Treetop 7', 0, 5, 0, 0, 0, 0, 16, 1),
(437, 0, 0, 0, 'Treetop 8', 0, 5, 0, 0, 0, 0, 16, 1),
(438, 0, 0, 0, 'Treetop 9', 100, 5, 0, 0, 0, 0, 21, 2),
(439, 0, 0, 0, 'Treetop 10', 100, 5, 0, 0, 0, 0, 21, 2),
(440, 0, 0, 0, 'Treetop 11', 100, 5, 0, 0, 0, 0, 16, 2),
(441, 0, 0, 0, 'Treetop 12 (Shop)', 0, 5, 0, 0, 0, 0, 30, 1),
(442, 0, 0, 0, 'Treetop 13', 100, 5, 0, 0, 0, 0, 26, 2),
(443, 0, 0, 0, 'Coastwood 1', 100, 5, 0, 0, 0, 0, 16, 2),
(444, 0, 0, 0, 'Coastwood 2', 100, 5, 0, 0, 0, 0, 16, 2),
(445, 0, 0, 0, 'Coastwood 3', 100, 5, 0, 0, 0, 0, 22, 2),
(446, 0, 0, 0, 'Coastwood 4', 100, 5, 0, 0, 0, 0, 19, 2),
(447, 0, 0, 0, 'Coastwood 5', 100, 5, 0, 0, 0, 0, 26, 2),
(448, 0, 0, 0, 'Coastwood 6 (Shop)', 0, 5, 0, 0, 0, 0, 32, 1),
(449, 0, 0, 0, 'Coastwood 7', 0, 5, 0, 0, 0, 0, 12, 1),
(450, 0, 0, 0, 'Coastwood 8', 100, 5, 0, 0, 0, 0, 21, 2),
(451, 0, 0, 0, 'Coastwood 9', 0, 5, 0, 0, 0, 0, 17, 1),
(452, 0, 0, 0, 'Coastwood 10', 200, 5, 0, 0, 0, 0, 26, 3),
(453, 0, 0, 0, 'Shadow Caves 1', 0, 5, 0, 0, 0, 0, 10, 1),
(454, 0, 0, 0, 'Shadow Caves 2', 0, 5, 0, 0, 0, 0, 10, 1),
(455, 0, 0, 0, 'Shadow Caves 3', 0, 5, 0, 0, 0, 0, 10, 1),
(456, 0, 0, 0, 'Shadow Caves 4', 0, 5, 0, 0, 0, 0, 10, 1),
(457, 0, 0, 0, 'Shadow Caves 11', 0, 5, 0, 0, 0, 0, 10, 1),
(458, 0, 0, 0, 'Shadow Caves 12', 0, 5, 0, 0, 0, 0, 10, 1),
(459, 0, 0, 0, 'Shadow Caves 13', 0, 5, 0, 0, 0, 0, 10, 1),
(460, 0, 0, 0, 'Shadow Caves 14', 0, 5, 0, 0, 0, 0, 10, 1),
(461, 0, 0, 0, 'Shadow Caves 15', 0, 5, 0, 0, 0, 0, 10, 1),
(462, 0, 0, 0, 'Shadow Caves 16', 0, 5, 0, 0, 0, 0, 10, 1),
(463, 0, 0, 0, 'Shadow Caves 17', 0, 5, 0, 0, 0, 0, 10, 1),
(464, 0, 0, 0, 'Shadow Caves 18', 0, 5, 0, 0, 0, 0, 10, 1),
(465, 0, 0, 0, 'Shadow Caves 21', 0, 5, 0, 0, 0, 0, 10, 1),
(466, 0, 0, 0, 'Shadow Caves 22', 0, 5, 0, 0, 0, 0, 10, 1),
(467, 0, 0, 0, 'Shadow Caves 23', 0, 5, 0, 0, 0, 0, 10, 1),
(468, 0, 0, 0, 'Shadow Caves 24', 0, 5, 0, 0, 0, 0, 10, 1),
(469, 0, 0, 0, 'Shadow Caves 25', 0, 5, 0, 0, 0, 0, 10, 1),
(470, 0, 0, 0, 'Shadow Caves 26', 0, 5, 0, 0, 0, 0, 10, 1),
(471, 0, 0, 0, 'Shadow Caves 27', 0, 5, 0, 0, 0, 0, 10, 1),
(472, 0, 0, 0, 'Shadow Caves 28', 0, 5, 0, 0, 0, 0, 10, 1),
(473, 0, 0, 0, 'Castle Shop 1', 0, 6, 0, 0, 0, 0, 42, 1),
(474, 0, 0, 0, 'Castle Shop 2', 0, 6, 0, 0, 0, 0, 42, 1),
(475, 0, 0, 0, 'Castle Shop 3', 0, 6, 0, 0, 0, 0, 42, 1),
(476, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 0, 6, 0, 0, 0, 0, 13, 1),
(477, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 0, 6, 0, 0, 0, 0, 17, 1),
(478, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 0, 6, 0, 0, 0, 0, 13, 1),
(479, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 0, 6, 0, 0, 0, 0, 13, 1),
(480, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 0, 6, 0, 0, 0, 0, 17, 1),
(481, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 100, 6, 0, 0, 0, 0, 21, 2),
(482, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 0, 6, 0, 0, 0, 0, 16, 1),
(483, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 0, 6, 0, 0, 0, 0, 13, 1),
(484, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 0, 6, 0, 0, 0, 0, 17, 1),
(485, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 0, 6, 0, 0, 0, 0, 13, 1),
(486, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 0, 6, 0, 0, 0, 0, 13, 1),
(487, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 0, 6, 0, 0, 0, 0, 17, 1),
(488, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 0, 6, 0, 0, 0, 0, 21, 1),
(489, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 0, 6, 0, 0, 0, 0, 16, 1),
(490, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 0, 6, 0, 0, 0, 0, 21, 1),
(491, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 0, 6, 0, 0, 0, 0, 16, 1),
(492, 0, 0, 0, 'Castle, Basement, Flat 01', 0, 6, 0, 0, 0, 0, 13, 1),
(493, 0, 0, 0, 'Castle, Basement, Flat 02', 0, 6, 0, 0, 0, 0, 13, 1),
(494, 0, 0, 0, 'Castle, Basement, Flat 03', 0, 6, 0, 0, 0, 0, 13, 1),
(495, 0, 0, 0, 'Castle, Basement, Flat 04', 0, 6, 0, 0, 0, 0, 13, 1),
(496, 0, 0, 0, 'Castle, Basement, Flat 05', 0, 6, 0, 0, 0, 0, 13, 1),
(497, 0, 0, 0, 'Castle, Basement, Flat 06', 0, 6, 0, 0, 0, 0, 13, 1),
(498, 0, 0, 0, 'Castle, Basement, Flat 07', 0, 6, 0, 0, 0, 0, 13, 1),
(499, 0, 0, 0, 'Castle, Basement, Flat 08', 0, 6, 0, 0, 0, 0, 13, 1),
(500, 0, 0, 0, 'Castle, Basement, Flat 09', 0, 6, 0, 0, 0, 0, 13, 1),
(501, 0, 0, 0, 'Castle Street 1', 200, 6, 0, 0, 0, 0, 61, 3),
(502, 0, 0, 0, 'Castle Street 2', 100, 6, 0, 0, 0, 0, 31, 2),
(503, 0, 0, 0, 'Castle Street 3', 100, 6, 0, 0, 0, 0, 37, 2),
(504, 0, 0, 0, 'Castle Street 4', 100, 6, 0, 0, 0, 0, 37, 2),
(505, 0, 0, 0, 'Castle Street 5', 100, 6, 0, 0, 0, 0, 37, 2),
(506, 0, 0, 0, 'Edron Flats, Flat 01', 0, 6, 0, 0, 0, 0, 10, 1),
(507, 0, 0, 0, 'Edron Flats, Flat 02', 100, 6, 0, 0, 0, 0, 19, 2),
(508, 0, 0, 0, 'Edron Flats, Flat 03', 0, 6, 0, 0, 0, 0, 10, 1),
(509, 0, 0, 0, 'Edron Flats, Flat 04', 0, 6, 0, 0, 0, 0, 10, 1),
(510, 0, 0, 0, 'Edron Flats, Flat 05', 0, 6, 0, 0, 0, 0, 10, 1),
(511, 0, 0, 0, 'Edron Flats, Flat 06', 0, 6, 0, 0, 0, 0, 10, 1),
(512, 0, 0, 0, 'Edron Flats, Flat 07', 0, 6, 0, 0, 0, 0, 10, 1),
(513, 0, 0, 0, 'Edron Flats, Flat 08', 0, 6, 0, 0, 0, 0, 10, 1),
(514, 0, 0, 0, 'Edron Flats, Flat 11', 0, 6, 0, 0, 0, 0, 10, 1),
(515, 0, 0, 0, 'Edron Flats, Flat 12', 0, 6, 0, 0, 0, 0, 10, 1),
(516, 0, 0, 0, 'Edron Flats, Flat 13', 0, 6, 0, 0, 0, 0, 10, 1),
(517, 0, 0, 0, 'Edron Flats, Flat 14', 0, 6, 0, 0, 0, 0, 10, 1),
(518, 0, 0, 0, 'Edron Flats, Flat 15', 0, 6, 0, 0, 0, 0, 10, 1),
(519, 0, 0, 0, 'Edron Flats, Flat 16', 0, 6, 0, 0, 0, 0, 10, 1),
(520, 0, 0, 0, 'Edron Flats, Flat 17', 0, 6, 0, 0, 0, 0, 10, 1),
(521, 0, 0, 0, 'Edron Flats, Flat 18', 0, 6, 0, 0, 0, 0, 10, 1),
(522, 0, 0, 0, 'Edron Flats, Flat 21', 100, 6, 0, 0, 0, 0, 19, 2),
(523, 0, 0, 0, 'Edron Flats, Flat 22', 0, 6, 0, 0, 0, 0, 10, 1),
(524, 0, 0, 0, 'Edron Flats, Flat 23', 0, 6, 0, 0, 0, 0, 10, 1),
(525, 0, 0, 0, 'Edron Flats, Flat 24', 0, 6, 0, 0, 0, 0, 10, 1),
(526, 0, 0, 0, 'Edron Flats, Flat 25', 0, 6, 0, 0, 0, 0, 10, 1),
(527, 0, 0, 0, 'Edron Flats, Flat 26', 0, 6, 0, 0, 0, 0, 10, 1),
(528, 0, 0, 0, 'Edron Flats, Flat 27', 0, 6, 0, 0, 0, 0, 10, 1),
(529, 0, 0, 0, 'Edron Flats, Flat 28', 0, 6, 0, 0, 0, 0, 10, 1),
(530, 0, 0, 0, 'Edron Flats, Basement Flat 1', 100, 6, 0, 0, 0, 0, 36, 2),
(531, 0, 0, 0, 'Edron Flats, Basement Flat 2', 100, 6, 0, 0, 0, 0, 36, 2),
(532, 0, 0, 0, 'Central Circle 1', 100, 6, 0, 0, 0, 0, 73, 2),
(533, 0, 0, 0, 'Central Circle 2', 100, 6, 0, 0, 0, 0, 80, 2),
(534, 0, 0, 0, 'Central Circle 3', 400, 6, 0, 0, 0, 0, 109, 5),
(535, 0, 0, 0, 'Central Circle 4', 400, 6, 0, 0, 0, 0, 109, 5),
(536, 0, 0, 0, 'Central Circle 5', 400, 6, 0, 0, 0, 0, 109, 5),
(537, 0, 0, 0, 'Central Circle 6 (Shop)', 100, 6, 0, 0, 0, 0, 109, 2),
(538, 0, 0, 0, 'Central Circle 7 (Shop)', 100, 6, 0, 0, 0, 0, 109, 2),
(539, 0, 0, 0, 'Central Circle 8 (Shop)', 100, 6, 0, 0, 0, 0, 109, 2),
(540, 0, 0, 0, 'Central Circle 9a', 100, 6, 0, 0, 0, 0, 21, 2),
(541, 0, 0, 0, 'Central Circle 9b', 100, 6, 0, 0, 0, 0, 21, 2),
(542, 0, 0, 0, 'Wood Avenue 1', 100, 6, 0, 0, 0, 0, 37, 2),
(543, 0, 0, 0, 'Wood Avenue 2', 100, 6, 0, 0, 0, 0, 37, 2),
(544, 0, 0, 0, 'Wood Avenue 3', 100, 6, 0, 0, 0, 0, 37, 2),
(545, 0, 0, 0, 'Wood Avenue 4', 100, 6, 0, 0, 0, 0, 37, 2),
(546, 0, 0, 0, 'Wood Avenue 5', 100, 6, 0, 0, 0, 0, 37, 2),
(547, 0, 0, 0, 'Wood Avenue 6a', 100, 6, 0, 0, 0, 0, 37, 2),
(548, 0, 0, 0, 'Wood Avenue 6b', 100, 6, 0, 0, 0, 0, 37, 2),
(549, 0, 0, 0, 'Wood Avenue 7', 200, 6, 0, 0, 0, 0, 140, 3),
(550, 0, 0, 0, 'Wood Avenue 8', 200, 6, 0, 0, 0, 0, 140, 3),
(551, 0, 0, 0, 'Wood Avenue 9a', 100, 6, 0, 0, 0, 0, 37, 2),
(552, 0, 0, 0, 'Wood Avenue 9b', 100, 6, 0, 0, 0, 0, 37, 2),
(553, 0, 0, 0, 'Wood Avenue 10a', 100, 6, 0, 0, 0, 0, 37, 2),
(554, 0, 0, 0, 'Wood Avenue 10b', 200, 6, 0, 0, 0, 0, 37, 3),
(555, 0, 0, 0, 'Wood Avenue 11', 500, 6, 0, 0, 0, 0, 173, 6),
(556, 0, 0, 0, 'Wood Avenue 4a', 100, 6, 0, 0, 0, 0, 31, 2),
(557, 0, 0, 0, 'Wood Avenue 4b', 100, 6, 0, 0, 0, 0, 31, 2),
(558, 0, 0, 0, 'Wood Avenue 4c', 100, 6, 0, 0, 0, 0, 37, 2),
(559, 0, 0, 0, 'Sky Lane, Guild 1', 2200, 6, 0, 0, 0, 0, 473, 23),
(560, 0, 0, 0, 'Sky Lane, Guild 2', 1300, 6, 0, 0, 0, 0, 465, 14),
(561, 0, 0, 0, 'Sky Lane, Guild 3', 1700, 6, 0, 0, 0, 0, 401, 18),
(562, 0, 0, 0, 'Sky Lane, Sea Tower', 500, 6, 0, 0, 0, 0, 101, 6),
(563, 0, 0, 0, 'Magic Academy, Guild', 1300, 6, 0, 0, 0, 0, 220, 14),
(564, 0, 0, 0, 'Magic Academy, Shop', 0, 6, 0, 0, 0, 0, 29, 1),
(565, 0, 0, 0, 'Magic Academy, Flat 1', 200, 6, 0, 0, 0, 0, 25, 3),
(566, 0, 0, 0, 'Magic Academy, Flat 2', 100, 6, 0, 0, 0, 0, 26, 2),
(567, 0, 0, 0, 'Magic Academy, Flat 3', 0, 6, 0, 0, 0, 0, 26, 1),
(568, 0, 0, 0, 'Magic Academy, Flat 4', 100, 6, 0, 0, 0, 0, 26, 2),
(569, 0, 0, 0, 'Magic Academy, Flat 5', 0, 6, 0, 0, 0, 0, 26, 1),
(570, 0, 0, 0, 'Stonehome Village 1', 100, 6, 0, 0, 0, 0, 42, 2),
(571, 0, 0, 0, 'Stonehome Village 2', 0, 6, 0, 0, 0, 0, 16, 1),
(572, 0, 0, 0, 'Stonehome Village 3', 0, 6, 0, 0, 0, 0, 17, 1),
(573, 0, 0, 0, 'Stonehome Village 4', 100, 6, 0, 0, 0, 0, 21, 2),
(574, 0, 0, 0, 'Stonehome Village 5', 100, 6, 0, 0, 0, 0, 26, 2),
(575, 0, 0, 0, 'Stonehome Village 6', 100, 6, 0, 0, 0, 0, 30, 2),
(576, 0, 0, 0, 'Stonehome Village 7', 100, 6, 0, 0, 0, 0, 26, 2),
(577, 0, 0, 0, 'Stonehome Village 8', 0, 6, 0, 0, 0, 0, 17, 1),
(578, 0, 0, 0, 'Stonehome Village 9', 0, 6, 0, 0, 0, 0, 17, 1),
(579, 0, 0, 0, 'Stonehome Flats, Flat 01', 0, 6, 0, 0, 0, 0, 10, 1),
(580, 0, 0, 0, 'Stonehome Flats, Flat 02', 100, 6, 0, 0, 0, 0, 16, 2),
(581, 0, 0, 0, 'Stonehome Flats, Flat 03', 0, 6, 0, 0, 0, 0, 10, 1),
(582, 0, 0, 0, 'Stonehome Flats, Flat 04', 0, 6, 0, 0, 0, 0, 10, 1),
(583, 0, 0, 0, 'Stonehome Flats, Flat 05', 0, 6, 0, 0, 0, 0, 10, 1),
(584, 0, 0, 0, 'Stonehome Flats, Flat 06', 0, 6, 0, 0, 0, 0, 10, 1),
(585, 0, 0, 0, 'Stonehome Flats, Flat 11', 100, 6, 0, 0, 0, 0, 16, 2),
(586, 0, 0, 0, 'Stonehome Flats, Flat 12', 100, 6, 0, 0, 0, 0, 16, 2),
(587, 0, 0, 0, 'Stonehome Flats, Flat 13', 0, 6, 0, 0, 0, 0, 10, 1),
(588, 0, 0, 0, 'Stonehome Flats, Flat 14', 0, 6, 0, 0, 0, 0, 10, 1),
(589, 0, 0, 0, 'Stonehome Flats, Flat 15', 0, 6, 0, 0, 0, 0, 10, 1),
(590, 0, 0, 0, 'Stonehome Flats, Flat 16', 0, 6, 0, 0, 0, 0, 10, 1),
(591, 0, 0, 0, 'Stonehome Clanhall', 900, 6, 0, 0, 0, 0, 245, 10),
(592, 0, 0, 0, 'Cormaya Flats, Flat 01', 0, 6, 0, 0, 0, 0, 10, 1),
(593, 0, 0, 0, 'Cormaya Flats, Flat 02', 0, 6, 0, 0, 0, 0, 10, 1),
(594, 0, 0, 0, 'Cormaya Flats, Flat 03', 100, 6, 0, 0, 0, 0, 16, 2),
(595, 0, 0, 0, 'Cormaya Flats, Flat 04', 100, 6, 0, 0, 0, 0, 16, 2),
(596, 0, 0, 0, 'Cormaya Flats, Flat 05', 0, 6, 0, 0, 0, 0, 10, 1),
(597, 0, 0, 0, 'Cormaya Flats, Flat 06', 0, 6, 0, 0, 0, 0, 10, 1),
(598, 0, 0, 0, 'Cormaya Flats, Flat 11', 0, 6, 0, 0, 0, 0, 10, 1),
(599, 0, 0, 0, 'Cormaya Flats, Flat 12', 0, 6, 0, 0, 0, 0, 10, 1),
(600, 0, 0, 0, 'Cormaya Flats, Flat 13', 100, 6, 0, 0, 0, 0, 16, 2),
(601, 0, 0, 0, 'Cormaya Flats, Flat 14', 100, 6, 0, 0, 0, 0, 16, 2),
(602, 0, 0, 0, 'Cormaya Flats, Flat 15', 0, 6, 0, 0, 0, 0, 10, 1),
(603, 0, 0, 0, 'Cormaya Flats, Flat 16', 0, 6, 0, 0, 0, 0, 10, 1),
(604, 0, 0, 0, 'Cormaya 1', 100, 6, 0, 0, 0, 0, 26, 2),
(605, 0, 0, 0, 'Cormaya 2', 200, 6, 0, 0, 0, 0, 85, 3),
(606, 0, 0, 0, 'Cormaya 3', 100, 6, 0, 0, 0, 0, 43, 2),
(607, 0, 0, 0, 'Cormaya 4', 100, 6, 0, 0, 0, 0, 36, 2),
(608, 0, 0, 0, 'Cormaya 5', 200, 6, 0, 0, 0, 0, 120, 3),
(609, 0, 0, 0, 'Cormaya 6', 100, 6, 0, 0, 0, 0, 51, 2),
(610, 0, 0, 0, 'Cormaya 7', 100, 6, 0, 0, 0, 0, 51, 2),
(611, 0, 0, 0, 'Cormaya 8', 100, 6, 0, 0, 0, 0, 58, 2),
(612, 0, 0, 0, 'Cormaya 9a', 100, 6, 0, 0, 0, 0, 25, 2),
(613, 0, 0, 0, 'Cormaya 9b', 100, 6, 0, 0, 0, 0, 61, 2),
(614, 0, 0, 0, 'Cormaya 9c', 100, 6, 0, 0, 0, 0, 25, 2),
(615, 0, 0, 0, 'Cormaya 9d', 100, 6, 0, 0, 0, 0, 61, 2),
(616, 0, 0, 0, 'Cormaya 10', 200, 6, 0, 0, 0, 0, 80, 3),
(617, 0, 0, 0, 'Cormaya 11', 100, 6, 0, 0, 0, 0, 43, 2),
(618, 0, 0, 0, 'Castle of the White Dragon', 1800, 6, 0, 0, 0, 0, 540, 19),
(619, 0, 0, 0, 'Chameken I', 0, 9, 0, 0, 0, 0, 17, 1),
(620, 0, 0, 0, 'Chameken II', 0, 9, 0, 0, 0, 0, 17, 1),
(621, 0, 0, 0, 'Thanah I a', 0, 9, 0, 0, 0, 0, 17, 1),
(622, 0, 0, 0, 'Thanah I b', 200, 9, 0, 0, 0, 0, 65, 3),
(623, 0, 0, 0, 'Thanah I c', 200, 9, 0, 0, 0, 0, 68, 3),
(624, 0, 0, 0, 'Thanah I d', 300, 9, 0, 0, 0, 0, 61, 4),
(625, 0, 0, 0, 'Thanah II a', 0, 9, 0, 0, 0, 0, 17, 1),
(626, 0, 0, 0, 'Thanah II b', 0, 9, 0, 0, 0, 0, 9, 1),
(627, 0, 0, 0, 'Thanah II c', 0, 9, 0, 0, 0, 0, 9, 1),
(628, 0, 0, 0, 'Thanah II d', 0, 9, 0, 0, 0, 0, 7, 1),
(629, 0, 0, 0, 'Thanah II e', 0, 9, 0, 0, 0, 0, 7, 1),
(630, 0, 0, 0, 'Thanah II f', 200, 9, 0, 0, 0, 0, 61, 2),
(631, 0, 0, 0, 'Thanah II g', 100, 9, 0, 0, 0, 0, 31, 2),
(632, 0, 0, 0, 'Thanah II h', 100, 9, 0, 0, 0, 0, 26, 2),
(633, 0, 0, 0, 'Thrarhor I a (Shop)', 0, 9, 0, 0, 0, 0, 21, 1),
(634, 0, 0, 0, 'Thrarhor I b (Shop)', 0, 9, 0, 0, 0, 0, 21, 1),
(635, 0, 0, 0, 'Thrarhor I c (Shop)', 0, 9, 0, 0, 0, 0, 21, 1),
(636, 0, 0, 0, 'Thrarhor I d (Shop)', 0, 9, 0, 0, 0, 0, 21, 1),
(637, 0, 0, 0, 'Botham I a', 0, 9, 0, 0, 0, 0, 19, 1),
(638, 0, 0, 0, 'Botham I b', 200, 9, 0, 0, 0, 0, 65, 3),
(639, 0, 0, 0, 'Botham I c', 100, 9, 0, 0, 0, 0, 37, 2),
(640, 0, 0, 0, 'Botham I d', 200, 9, 0, 0, 0, 0, 61, 3),
(641, 0, 0, 0, 'Botham I e', 0, 9, 0, 0, 0, 0, 31, 2),
(642, 0, 0, 0, 'Botham II a', 0, 9, 0, 0, 0, 0, 17, 1),
(643, 0, 0, 0, 'Botham II b', 100, 9, 0, 0, 0, 0, 33, 2),
(644, 0, 0, 0, 'Botham II c', 100, 9, 0, 0, 0, 0, 25, 2),
(645, 0, 0, 0, 'Botham II d', 100, 9, 0, 0, 0, 0, 37, 2),
(646, 0, 0, 0, 'Botham II e', 100, 9, 0, 0, 0, 0, 31, 2),
(647, 0, 0, 0, 'Botham II f', 100, 9, 0, 0, 0, 0, 31, 2),
(648, 0, 0, 0, 'Botham II g', 100, 9, 0, 0, 0, 0, 26, 2),
(649, 0, 0, 0, 'Botham III a', 100, 9, 0, 0, 0, 0, 26, 2),
(650, 0, 0, 0, 'Botham III b', 100, 9, 0, 0, 0, 0, 17, 2),
(651, 0, 0, 0, 'Botham III c', 0, 9, 0, 0, 0, 0, 17, 1),
(652, 0, 0, 0, 'Botham III d', 0, 9, 0, 0, 0, 0, 17, 1),
(653, 0, 0, 0, 'Botham III e', 0, 9, 0, 0, 0, 0, 17, 1),
(654, 0, 0, 0, 'Botham III f', 200, 9, 0, 0, 0, 0, 43, 2),
(655, 0, 0, 0, 'Botham III g', 100, 9, 0, 0, 0, 0, 31, 2),
(656, 0, 0, 0, 'Botham III h', 200, 9, 0, 0, 0, 0, 79, 3),
(657, 0, 0, 0, 'Botham IV a', 100, 9, 0, 0, 0, 0, 26, 2),
(658, 0, 0, 0, 'Botham IV b', 0, 9, 0, 0, 0, 0, 17, 1),
(659, 0, 0, 0, 'Botham IV c', 0, 9, 0, 0, 0, 0, 17, 1),
(660, 0, 0, 0, 'Botham IV d', 0, 9, 0, 0, 0, 0, 17, 1),
(661, 0, 0, 0, 'Botham IV e', 0, 9, 0, 0, 0, 0, 17, 1),
(662, 0, 0, 0, 'Botham IV f', 100, 9, 0, 0, 0, 0, 37, 2),
(663, 0, 0, 0, 'Botham IV g', 100, 9, 0, 0, 0, 0, 37, 2),
(664, 0, 0, 0, 'Botham IV h', 0, 9, 0, 0, 0, 0, 37, 1),
(665, 0, 0, 0, 'Botham IV i', 200, 9, 0, 0, 0, 0, 37, 3),
(666, 0, 0, 0, 'Ramen Tah', 1500, 9, 0, 0, 0, 0, 143, 16),
(667, 0, 0, 0, 'Charsirakh I a', 0, 9, 0, 0, 0, 0, 7, 1),
(668, 0, 0, 0, 'Charsirakh I b', 100, 9, 0, 0, 0, 0, 37, 2),
(669, 0, 0, 0, 'Charsirakh II', 100, 9, 0, 0, 0, 0, 26, 2),
(670, 0, 0, 0, 'Charsirakh III', 0, 9, 0, 0, 0, 0, 17, 1),
(671, 0, 0, 0, 'Othehothep I a', 0, 9, 0, 0, 0, 0, 7, 1),
(672, 0, 0, 0, 'Othehothep I b', 100, 9, 0, 0, 0, 0, 37, 2),
(673, 0, 0, 0, 'Othehothep I c', 200, 9, 0, 0, 0, 0, 41, 3),
(674, 0, 0, 0, 'Othehothep I d', 300, 9, 0, 0, 0, 0, 51, 4),
(675, 0, 0, 0, 'Othehothep II a', 0, 9, 0, 0, 0, 0, 10, 1),
(676, 0, 0, 0, 'Othehothep II b', 200, 9, 0, 0, 0, 0, 50, 3),
(677, 0, 0, 0, 'Othehothep II c', 0, 9, 0, 0, 0, 0, 21, 1),
(678, 0, 0, 0, 'Othehothep II d', 0, 9, 0, 0, 0, 0, 21, 1),
(679, 0, 0, 0, 'Othehothep II e', 100, 9, 0, 0, 0, 0, 31, 1),
(680, 0, 0, 0, 'Othehothep II f', 100, 9, 0, 0, 0, 0, 31, 2),
(681, 0, 0, 0, 'Othehothep III a', 0, 9, 0, 0, 0, 0, 7, 1),
(682, 0, 0, 0, 'Othehothep III b', 100, 9, 0, 0, 0, 0, 37, 2),
(683, 0, 0, 0, 'Othehothep III c', 100, 9, 0, 0, 0, 0, 21, 2),
(684, 0, 0, 0, 'Othehothep III d', 0, 9, 0, 0, 0, 0, 26, 1),
(685, 0, 0, 0, 'Othehothep III e', 0, 9, 0, 0, 0, 0, 21, 1),
(686, 0, 0, 0, 'Othehothep III f', 0, 9, 0, 0, 0, 0, 17, 1),
(687, 0, 0, 0, 'Harrah I', 900, 9, 0, 0, 0, 0, 145, 10),
(688, 0, 0, 0, 'Murkhol I a', 0, 9, 0, 0, 0, 0, 11, 1),
(689, 0, 0, 0, 'Murkhol I b', 0, 9, 0, 0, 0, 0, 11, 1),
(690, 0, 0, 0, 'Murkhol I c', 0, 9, 0, 0, 0, 0, 11, 1),
(691, 0, 0, 0, 'Murkhol I d', 0, 9, 0, 0, 0, 0, 11, 1),
(692, 0, 0, 0, 'Oskahl I a', 100, 9, 0, 0, 0, 0, 37, 2),
(693, 0, 0, 0, 'Oskahl I b', 0, 9, 0, 0, 0, 0, 21, 1),
(694, 0, 0, 0, 'Oskahl I c', 0, 9, 0, 0, 0, 0, 17, 1),
(695, 0, 0, 0, 'Oskahl I d', 100, 9, 0, 0, 0, 0, 26, 2),
(696, 0, 0, 0, 'Oskahl I e', 0, 9, 0, 0, 0, 0, 21, 1),
(697, 0, 0, 0, 'Oskahl I f', 0, 9, 0, 0, 0, 0, 21, 1),
(698, 0, 0, 0, 'Oskahl I g', 100, 9, 0, 0, 0, 0, 26, 2),
(699, 0, 0, 0, 'Oskahl I h', 200, 9, 0, 0, 0, 0, 43, 3),
(700, 0, 0, 0, 'Oskahl I i', 0, 9, 0, 0, 0, 0, 21, 1),
(701, 0, 0, 0, 'Oskahl I j', 0, 9, 0, 0, 0, 0, 17, 1),
(702, 0, 0, 0, 'Botham IV b', 1700, 8, 0, 0, 0, 0, 17, 1),
(703, 0, 0, 0, 'Mothrem I', 100, 9, 0, 0, 0, 0, 26, 2),
(704, 0, 0, 0, 'Arakmehn I', 200, 9, 0, 0, 0, 0, 28, 3),
(705, 0, 0, 0, 'Arakmehn II', 0, 9, 0, 0, 0, 0, 26, 1),
(706, 0, 0, 0, 'Arakmehn III', 100, 9, 0, 0, 0, 0, 26, 2),
(707, 0, 0, 0, 'Arakmehn IV', 100, 9, 0, 0, 0, 0, 28, 2),
(708, 0, 0, 0, 'Unklath I a', 100, 9, 0, 0, 0, 0, 26, 2),
(709, 0, 0, 0, 'Unklath I b', 100, 9, 0, 0, 0, 0, 37, 2),
(710, 0, 0, 0, 'Unklath I c', 100, 9, 0, 0, 0, 0, 37, 2),
(711, 0, 0, 0, 'Unklath I d', 200, 9, 0, 0, 0, 0, 37, 3),
(712, 0, 0, 0, 'Unklath I e', 100, 9, 0, 0, 0, 0, 37, 2),
(713, 0, 0, 0, 'Unklath I f', 100, 9, 0, 0, 0, 0, 37, 2),
(714, 0, 0, 0, 'Unklath I g', 0, 9, 0, 0, 0, 0, 37, 1),
(715, 0, 0, 0, 'Unklath II a', 0, 9, 0, 0, 0, 0, 26, 1),
(716, 0, 0, 0, 'Unklath II b', 0, 9, 0, 0, 0, 0, 17, 1),
(717, 0, 0, 0, 'Unklath II c', 0, 9, 0, 0, 0, 0, 17, 1),
(718, 0, 0, 0, 'Unklath II d', 100, 9, 0, 0, 0, 0, 37, 2),
(719, 0, 0, 0, 'Rathal I a', 100, 9, 0, 0, 0, 0, 26, 2),
(720, 0, 0, 0, 'Rathal I b', 0, 9, 0, 0, 0, 0, 17, 1),
(721, 0, 0, 0, 'Rathal I c', 0, 9, 0, 0, 0, 0, 17, 1),
(722, 0, 0, 0, 'Rathal I d', 100, 9, 0, 0, 0, 0, 17, 2),
(723, 0, 0, 0, 'Rathal I e', 100, 9, 0, 0, 0, 0, 17, 2),
(724, 0, 0, 0, 'Rathal II a', 0, 9, 0, 0, 0, 0, 26, 1),
(725, 0, 0, 0, 'Rathal II b', 0, 9, 0, 0, 0, 0, 17, 1),
(726, 0, 0, 0, 'Rathal II c', 0, 9, 0, 0, 0, 0, 17, 1),
(727, 0, 0, 0, 'Rathal II d', 100, 9, 0, 0, 0, 0, 37, 2),
(728, 0, 0, 0, 'Uthemath I a', 0, 9, 0, 0, 0, 0, 10, 1),
(729, 0, 0, 0, 'Uthemath I b', 0, 9, 0, 0, 0, 0, 22, 1),
(730, 0, 0, 0, 'Uthemath I c', 100, 9, 0, 0, 0, 0, 22, 2),
(731, 0, 0, 0, 'Uthemath I d', 0, 9, 0, 0, 0, 0, 21, 1),
(732, 0, 0, 0, 'Uthemath I e', 100, 9, 0, 0, 0, 0, 21, 2),
(733, 0, 0, 0, 'Uthemath I f', 200, 9, 0, 0, 0, 0, 67, 3),
(734, 0, 0, 0, 'Uthemath II', 700, 9, 0, 0, 0, 0, 107, 8),
(735, 0, 0, 0, 'Esuph I', 0, 9, 0, 0, 0, 0, 17, 1),
(736, 0, 0, 0, 'Esuph II a', 0, 9, 0, 0, 0, 0, 7, 1),
(737, 0, 0, 0, 'Esuph II b', 100, 9, 0, 0, 0, 0, 37, 2),
(738, 0, 0, 0, 'Esuph III a', 0, 9, 0, 0, 0, 0, 7, 1),
(739, 0, 0, 0, 'Esuph III b', 100, 9, 0, 0, 0, 0, 37, 2),
(740, 0, 0, 0, 'Esuph IV a', 0, 9, 0, 0, 0, 0, 10, 1),
(741, 0, 0, 0, 'Esuph IV b', 0, 9, 0, 0, 0, 0, 10, 1),
(742, 0, 0, 0, 'Esuph IV c', 0, 9, 0, 0, 0, 0, 10, 1),
(743, 0, 0, 0, 'Esuph IV d', 0, 9, 0, 0, 0, 0, 22, 1),
(744, 0, 0, 0, 'Horakhal', 1300, 9, 0, 0, 0, 0, 225, 14),
(745, 0, 0, 0, 'Darashia 1, Flat 01', 100, 7, 0, 0, 0, 0, 25, 2),
(746, 0, 0, 0, 'Darashia 1, Flat 02', 0, 7, 0, 0, 0, 0, 25, 1),
(747, 0, 0, 0, 'Darashia 1, Flat 03', 300, 7, 0, 0, 0, 0, 65, 4),
(748, 0, 0, 0, 'Darashia 1, Flat 04', 0, 7, 0, 0, 0, 0, 25, 1),
(749, 0, 0, 0, 'Darashia 1, Flat 05', 100, 7, 0, 0, 0, 0, 25, 2),
(750, 0, 0, 0, 'Darashia 1, Flat 11', 100, 7, 0, 0, 0, 0, 25, 2),
(751, 0, 0, 0, 'Darashia 1, Flat 12', 100, 7, 0, 0, 0, 0, 45, 2),
(752, 0, 0, 0, 'Darashia 1, Flat 13', 100, 7, 0, 0, 0, 0, 45, 2),
(753, 0, 0, 0, 'Darashia 1, Flat 14', 400, 7, 0, 0, 0, 0, 65, 5),
(754, 0, 0, 0, 'Darashia 2, Flat 01', 0, 7, 0, 0, 0, 0, 25, 1),
(755, 0, 0, 0, 'Darashia 2, Flat 02', 0, 7, 0, 0, 0, 0, 25, 1),
(756, 0, 0, 0, 'Darashia 2, Flat 03', 0, 7, 0, 0, 0, 0, 29, 1),
(757, 0, 0, 0, 'Darashia 2, Flat 04', 0, 7, 0, 0, 0, 0, 13, 1),
(758, 0, 0, 0, 'Darashia 2, Flat 05', 100, 7, 0, 0, 0, 0, 29, 2),
(759, 0, 0, 0, 'Darashia 2, Flat 06', 0, 7, 0, 0, 0, 0, 13, 1),
(760, 0, 0, 0, 'Darashia 2, Flat 07', 0, 7, 0, 0, 0, 0, 25, 1),
(761, 0, 0, 0, 'Darashia 2, Flat 11', 0, 7, 0, 0, 0, 0, 25, 1),
(762, 0, 0, 0, 'Darashia 2, Flat 12', 0, 7, 0, 0, 0, 0, 13, 1),
(763, 0, 0, 0, 'Darashia 2, Flat 13', 0, 7, 0, 0, 0, 0, 29, 1),
(764, 0, 0, 0, 'Darashia 2, Flat 14', 0, 7, 0, 0, 0, 0, 13, 1),
(765, 0, 0, 0, 'Darashia 2, Flat 15', 100, 7, 0, 0, 0, 0, 29, 2),
(766, 0, 0, 0, 'Darashia 2, Flat 16', 0, 7, 0, 0, 0, 0, 17, 1),
(767, 0, 0, 0, 'Darashia 2, Flat 17', 0, 7, 0, 0, 0, 0, 25, 1),
(768, 0, 0, 0, 'Darashia 2, Flat 18', 0, 7, 0, 0, 0, 0, 17, 1),
(769, 0, 0, 0, 'Darashia 3, Flat 01', 100, 7, 0, 0, 0, 0, 25, 2),
(770, 0, 0, 0, 'Darashia 3, Flat 02', 100, 7, 0, 0, 0, 0, 41, 2),
(771, 0, 0, 0, 'Darashia 3, Flat 03', 100, 7, 0, 0, 0, 0, 25, 2),
(772, 0, 0, 0, 'Darashia 3, Flat 04', 100, 7, 0, 0, 0, 0, 41, 2),
(773, 0, 0, 0, 'Darashia 3, Flat 05', 0, 7, 0, 0, 0, 0, 25, 1),
(774, 0, 0, 0, 'Darashia 3, Flat 11', 0, 7, 0, 0, 0, 0, 25, 1),
(775, 0, 0, 0, 'Darashia 3, Flat 12', 400, 7, 0, 0, 0, 0, 61, 5),
(776, 0, 0, 0, 'Darashia 3, Flat 13', 100, 7, 0, 0, 0, 0, 25, 2),
(777, 0, 0, 0, 'Darashia 3, Flat 14', 200, 7, 0, 0, 0, 0, 61, 3),
(778, 0, 0, 0, 'Darashia 4, Flat 01', 0, 7, 0, 0, 0, 0, 25, 1),
(779, 0, 0, 0, 'Darashia 4, Flat 02', 100, 7, 0, 0, 0, 0, 45, 2),
(780, 0, 0, 0, 'Darashia 4, Flat 03', 0, 7, 0, 0, 0, 0, 25, 1),
(781, 0, 0, 0, 'Darashia 4, Flat 04', 100, 7, 0, 0, 0, 0, 45, 2),
(782, 0, 0, 0, 'Darashia 4, Flat 05', 100, 7, 0, 0, 0, 0, 25, 2),
(783, 0, 0, 0, 'Darashia 4, Flat 11', 0, 7, 0, 0, 0, 0, 25, 1),
(784, 0, 0, 0, 'Darashia 4, Flat 12', 200, 7, 0, 0, 0, 0, 65, 3),
(785, 0, 0, 0, 'Darashia 4, Flat 13', 100, 7, 0, 0, 0, 0, 45, 2),
(786, 0, 0, 0, 'Darashia 4, Flat 14', 100, 7, 0, 0, 0, 0, 45, 2),
(787, 0, 0, 0, 'Darashia 5, Flat 01', 0, 7, 0, 0, 0, 0, 25, 1),
(788, 0, 0, 0, 'Darashia 5, Flat 02', 100, 7, 0, 0, 0, 0, 41, 2),
(789, 0, 0, 0, 'Darashia 5, Flat 03', 0, 7, 0, 0, 0, 0, 25, 1),
(790, 0, 0, 0, 'Darashia 5, Flat 04', 100, 7, 0, 0, 0, 0, 41, 2),
(791, 0, 0, 0, 'Darashia 5, Flat 05', 0, 7, 0, 0, 0, 0, 25, 1),
(792, 0, 0, 0, 'Darashia 5, Flat 11', 100, 7, 0, 0, 0, 0, 45, 2),
(793, 0, 0, 0, 'Darashia 5, Flat 12', 100, 7, 0, 0, 0, 0, 41, 2),
(794, 0, 0, 0, 'Darashia 5, Flat 13', 100, 7, 0, 0, 0, 0, 45, 2),
(795, 0, 0, 0, 'Darashia 5, Flat 14', 100, 7, 0, 0, 0, 0, 41, 2),
(796, 0, 0, 0, 'Darashia 6a', 100, 7, 0, 0, 0, 0, 70, 2),
(797, 0, 0, 0, 'Darashia 6b', 100, 7, 0, 0, 0, 0, 78, 2),
(798, 0, 0, 0, 'Darashia 7, Flat 01', 0, 7, 0, 0, 0, 0, 25, 1),
(799, 0, 0, 0, 'Darashia 7, Flat 02', 0, 7, 0, 0, 0, 0, 25, 1),
(800, 0, 0, 0, 'Darashia 7, Flat 03', 300, 7, 0, 0, 0, 0, 65, 4),
(801, 0, 0, 0, 'Darashia 7, Flat 04', 0, 7, 0, 0, 0, 0, 25, 1),
(802, 0, 0, 0, 'Darashia 7, Flat 05', 100, 7, 0, 0, 0, 0, 25, 2),
(803, 0, 0, 0, 'Darashia 7, Flat 11', 0, 7, 0, 0, 0, 0, 25, 1),
(804, 0, 0, 0, 'Darashia 7, Flat 12', 300, 7, 0, 0, 0, 0, 65, 4),
(805, 0, 0, 0, 'Darashia 7, Flat 13', 0, 7, 0, 0, 0, 0, 25, 1),
(806, 0, 0, 0, 'Darashia 7, Flat 14', 300, 7, 0, 0, 0, 0, 65, 4),
(807, 0, 0, 0, 'Darashia 8, Flat 01', 100, 7, 0, 0, 0, 0, 53, 2),
(808, 0, 0, 0, 'Darashia 8, Flat 02', 100, 7, 0, 0, 0, 0, 76, 2),
(809, 0, 0, 0, 'Darashia 8, Flat 03', 200, 7, 0, 0, 0, 0, 109, 3),
(810, 0, 0, 0, 'Darashia 8, Flat 04', 100, 7, 0, 0, 0, 0, 61, 2),
(811, 0, 0, 0, 'Darashia 8, Flat 05', 100, 7, 0, 0, 0, 0, 57, 2),
(812, 0, 0, 0, 'Darashia, Villa', 300, 7, 0, 0, 0, 0, 154, 4),
(813, 0, 0, 0, 'Darashia, Western Guildhall', 1300, 7, 0, 0, 0, 0, 273, 14),
(814, 0, 0, 0, 'Darashia, Eastern Guildhall', 1500, 7, 0, 0, 0, 0, 321, 16),
(815, 0, 0, 0, 'Darashia 8, Flat 11', 100, 7, 0, 0, 0, 0, 45, 2),
(816, 0, 0, 0, 'Darashia 8, Flat 12', 100, 7, 0, 0, 0, 0, 41, 2),
(817, 0, 0, 0, 'Darashia 8, Flat 13', 100, 7, 0, 0, 0, 0, 45, 2),
(818, 0, 0, 0, 'Darashia 8, Flat 14', 100, 7, 0, 0, 0, 0, 41, 2),
(819, 0, 0, 0, 'Darashia 3, Flat 13', 2100, 6, 0, 0, 0, 0, 25, 2),
(820, 0, 0, 0, 'Darashia 3, Flat 14', 4600, 6, 0, 0, 0, 0, 55, 3);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(821, 0, 0, 0, 'Darashia 4, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1),
(822, 0, 0, 0, 'Darashia 4, Flat 02', 3460, 6, 0, 0, 0, 0, 42, 2),
(823, 0, 0, 0, 'Darashia 4, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1),
(824, 0, 0, 0, 'Darashia 4, Flat 04', 3460, 6, 0, 0, 0, 0, 42, 2),
(825, 0, 0, 0, 'Darashia 4, Flat 05', 2100, 6, 0, 0, 0, 0, 25, 2),
(826, 0, 0, 0, 'Darashia 4, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1),
(827, 0, 0, 0, 'Darashia 4, Flat 12', 4920, 6, 0, 0, 0, 0, 59, 3),
(828, 0, 0, 0, 'Darashia 4, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2),
(829, 0, 0, 0, 'Darashia 4, Flat 14', 3460, 6, 0, 0, 0, 0, 42, 2),
(830, 0, 0, 0, 'Darashia 5, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1),
(831, 0, 0, 0, 'Darashia 5, Flat 02', 3140, 6, 0, 0, 0, 0, 38, 2),
(832, 0, 0, 0, 'Darashia 5, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1),
(833, 0, 0, 0, 'Darashia 5, Flat 04', 3140, 6, 0, 0, 0, 0, 38, 2),
(834, 0, 0, 0, 'Darashia 5, Flat 05', 2000, 6, 0, 0, 0, 0, 25, 1),
(835, 0, 0, 0, 'Darashia 5, Flat 11', 3460, 6, 0, 0, 0, 0, 42, 2),
(836, 0, 0, 0, 'Darashia 5, Flat 12', 3140, 6, 0, 0, 0, 0, 38, 2),
(837, 0, 0, 0, 'Darashia 5, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2),
(838, 0, 0, 0, 'Darashia 5, Flat 14', 3140, 6, 0, 0, 0, 0, 38, 2),
(839, 0, 0, 0, 'Darashia 6a', 6130, 6, 0, 0, 0, 0, 67, 2),
(840, 0, 0, 0, 'Darashia 6b', 6760, 6, 0, 0, 0, 0, 74, 2),
(841, 0, 0, 0, 'Darashia 7, Flat 01', 2250, 6, 0, 0, 0, 0, 25, 1),
(842, 0, 0, 0, 'Darashia 7, Flat 02', 2250, 6, 0, 0, 0, 0, 25, 1),
(843, 0, 0, 0, 'Darashia 7, Flat 03', 5610, 6, 0, 0, 0, 0, 59, 4),
(844, 0, 0, 0, 'Darashia 7, Flat 04', 2250, 6, 0, 0, 0, 0, 25, 1),
(845, 0, 0, 0, 'Darashia 7, Flat 05', 2350, 6, 0, 0, 0, 0, 25, 2),
(846, 0, 0, 0, 'Darashia 7, Flat 11', 2250, 6, 0, 0, 0, 0, 25, 1),
(847, 0, 0, 0, 'Darashia 7, Flat 12', 5610, 6, 0, 0, 0, 0, 59, 4),
(848, 0, 0, 0, 'Darashia 7, Flat 13', 2250, 6, 0, 0, 0, 0, 25, 1),
(849, 0, 0, 0, 'Darashia 7, Flat 14', 5610, 6, 0, 0, 0, 0, 59, 4),
(850, 0, 0, 0, 'Darashia 8, Flat 01', 4870, 6, 0, 0, 0, 0, 53, 2),
(851, 0, 0, 0, 'Darashia 8, Flat 02', 6670, 6, 0, 0, 0, 0, 73, 2),
(852, 0, 0, 0, 'Darashia 8, Flat 03', 9200, 6, 0, 0, 0, 0, 100, 3),
(853, 0, 0, 0, 'Darashia 8, Flat 04', 5590, 6, 0, 0, 0, 0, 61, 2),
(854, 0, 0, 0, 'Darashia 8, Flat 05', 5230, 6, 0, 0, 0, 0, 57, 2),
(855, 0, 0, 0, 'Darashia, Villa', 10470, 6, 0, 0, 0, 0, 113, 4),
(856, 0, 0, 0, 'Darashia, Western Guildhall', 19570, 6, 0, 0, 0, 0, 203, 14),
(857, 0, 0, 0, 'Darashia, Eastern Guildhall', 23820, 6, 0, 0, 0, 0, 248, 16),
(858, 0, 0, 0, 'Darashia 8, Flat 11', 3880, 6, 0, 0, 0, 0, 42, 2),
(859, 0, 0, 0, 'Darashia 8, Flat 12', 3520, 6, 0, 0, 0, 0, 38, 2),
(860, 0, 0, 0, 'Darashia 8, Flat 13', 3880, 6, 0, 0, 0, 0, 42, 2),
(861, 0, 0, 0, 'Darashia 8, Flat 14', 3520, 6, 0, 0, 0, 0, 38, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_history`
--

CREATE TABLE `market_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT '0',
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT '0',
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `monsters`
--

CREATE TABLE `monsters` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `daily` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `soul` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `onlinetime` int(11) NOT NULL DEFAULT '0',
  `deletion` bigint(15) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `deleted`) VALUES
(1, 'Gamemaster', 3, 1234567, 2, 0, 155, 155, 105, 106, 95, 78, 58, 75, 100, 5, 5, 0, 100, 1, 5976, 6045, 7, '', 405, 0, 1608995142, 16777343, 1, 0, 0, 1608995994, 0, 21032, 0, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0);

--
-- Acionadores `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `player_depotitems`
--

INSERT INTO `player_depotitems` (`player_id`, `sid`, `pid`, `itemtype`, `count`, `attributes`) VALUES
(1, 101, 1, 3497, 1, ''),
(1, 102, 2, 3497, 1, ''),
(1, 103, 3, 3497, 1, ''),
(1, 104, 4, 3497, 1, ''),
(1, 105, 5, 3497, 1, ''),
(1, 106, 6, 3497, 1, ''),
(1, 107, 7, 3497, 1, ''),
(1, 108, 8, 3497, 1, ''),
(1, 109, 9, 3497, 1, ''),
(1, 110, 10, 3497, 1, ''),
(1, 111, 11, 3497, 1, ''),
(1, 112, 101, 3502, 1, ''),
(1, 113, 102, 3502, 1, ''),
(1, 114, 103, 3502, 1, ''),
(1, 115, 104, 3502, 1, ''),
(1, 116, 105, 3502, 1, ''),
(1, 117, 106, 3502, 1, ''),
(1, 118, 107, 3502, 1, ''),
(1, 119, 108, 3502, 1, ''),
(1, 120, 109, 3502, 1, ''),
(1, 121, 110, 3502, 1, ''),
(1, 122, 111, 3502, 1, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL DEFAULT '0',
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(1, 3, 101, 2853, 1, ''),
(1, 4, 102, 3562, 1, ''),
(1, 5, 103, 2923, 1, 0x10c0da00001101),
(1, 6, 104, 3043, 1, 0x0f01),
(1, 10, 105, 3031, 94, 0x0f5e),
(1, 101, 106, 2874, 0, 0x0f00),
(1, 101, 107, 2874, 0, 0x0f00),
(1, 101, 108, 2874, 0, 0x0f00),
(1, 101, 109, 2854, 1, ''),
(1, 101, 110, 3198, 4, 0x0f04),
(1, 101, 111, 3270, 1, ''),
(1, 101, 112, 3035, 9, 0x0f09),
(1, 101, 113, 3379, 1, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_murders`
--

CREATE TABLE `player_murders` (
  `id` bigint(20) NOT NULL,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(1, 203, 1),
(1, 224, 1),
(1, 227, 1),
(1, 43434, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('motd_hash', 'bd746a8e830237f7a1380be98802a0483741cff8'),
('motd_num', '2'),
('players_record', '2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tibia_items`
--

CREATE TABLE `tibia_items` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tile_store`
--

INSERT INTO `tile_store` (`house_id`, `data`) VALUES
(1, 0x7c179c170701000000680600),
(1, 0x7f179f170701000000680600),
(2, 0x6d17a2170701000000680600),
(3, 0x6817a2170701000000680600),
(4, 0x6317a2170701000000680600),
(5, 0x5517a4170701000000680600),
(6, 0x5017a4170701000000680600),
(7, 0x5f1791170701000000680600),
(8, 0x611791170701000000680600),
(9, 0x5f1791170601000000680600),
(10, 0x611791170601000000680600),
(11, 0x5f1791170501000000680600),
(12, 0x611791170501000000680600),
(13, 0x5b1787170701000000680600),
(14, 0x631787170701000000680600),
(15, 0x6c1788170701000000200900),
(16, 0x761788170701000000680600),
(16, 0x73178c1707010000001e0900),
(17, 0x731786170601000000660600),
(18, 0x751788170601000000660600),
(19, 0x74178b170601000000680600),
(20, 0x731786170501000000660600),
(20, 0x761786170501000000660600),
(21, 0x771789170501000000680600),
(22, 0x7f1787170701000000680600),
(23, 0x831787170701000000680600),
(24, 0x80178b170701000000660600),
(25, 0x2e1785170601000000660600),
(25, 0x2e1785170701000000660600),
(25, 0x311781170601000000660600),
(25, 0x311781170701000000660600),
(25, 0x3b1781170601000000660600),
(25, 0x3b1781170701000000660600),
(25, 0x311786170701000000660600),
(25, 0x361784170701000000680600),
(25, 0x3b1786170701000000660600),
(25, 0x3e1785170601000000660600),
(25, 0x3e1785170701000000660600),
(25, 0x301789170601000000680600),
(25, 0x301789170701000000680600),
(25, 0x3d1789170601000000680600),
(25, 0x3d1789170701000000680600),
(26, 0x9d1792170701000000680600),
(26, 0x9b1795170701000000660600),
(26, 0x9e1795170701000000660600),
(26, 0x9b179a170701000000660600),
(26, 0x9e179a170701000000660600),
(26, 0x9b179f170701000000660600),
(26, 0x9e179f170701000000660600),
(26, 0x9b17a0170601000000660600),
(26, 0x9c17a3170501000000680600),
(26, 0x9e17a0170601000000660600),
(26, 0x9b17a4170701000000660600),
(26, 0x9e17a4170701000000660600),
(27, 0x9d17b2170601000000660600),
(28, 0x9c17b3170601000000680600),
(29, 0xa417b0170701000000660600),
(30, 0xa417b4170701000000660600),
(31, 0xa317b2170601000000680600),
(32, 0xa417b0170601000000660600),
(33, 0xa917cc1707010000007a0600),
(33, 0xa617d01706010000007a0600),
(33, 0xa617d21706010000007a0600),
(33, 0xa617d01707010000007a0600),
(33, 0xa617d21707010000007a0600),
(33, 0xac17d01706010000007a0600),
(33, 0xac17d21706010000007a0600),
(33, 0xac17d01707010000007a0600),
(33, 0xac17d21707010000007a0600),
(35, 0x7f17c6170701000000680600),
(36, 0x8517c9170701000000660600),
(37, 0x8017cd170701000000660600),
(38, 0x8717cd170701000000680600),
(39, 0xf917b4170601000000690600),
(39, 0xf817b7170701000000680600),
(39, 0xf917b7170701000000680600),
(40, 0xfc17b1170701000000b70900),
(40, 0xfc17b2170701000000b80900),
(40, 0xff17b1170701000000b70900),
(40, 0xff17b2170701000000b80900),
(40, 0x0018b4170701000000660600),
(41, 0xea17b6170601000000b70900),
(41, 0xea17b7170601000000b80900),
(41, 0xeb17b6170601000000b70900),
(41, 0xeb17b7170601000000b80900),
(41, 0xee17b5170601000000660600),
(41, 0xef17b4170701000000660600),
(41, 0xf017b8170701000000680600),
(42, 0xf317bb170701000000680600),
(42, 0xf117bf170601000000bd0900),
(42, 0xf217bf170601000000be0900),
(42, 0xf317bf170601000000bd0900),
(42, 0xf417bf170601000000be0900),
(43, 0xf817c0170601000000680600),
(43, 0xf717c4170701000000680600),
(44, 0xef17c1170701000000680600),
(45, 0xf117c7170701000000b70900),
(45, 0xf417c7170701000000b70900),
(45, 0xf817c6170701000000680600),
(45, 0xf117c8170701000000b80900),
(45, 0xf417c8170701000000b80900),
(45, 0xf517ca170701000000660600),
(46, 0xfc17c4170701000000660600),
(46, 0xff17c5170701000000bd0900),
(46, 0x0018c5170701000000be0900),
(47, 0x0718bb170701000000680600),
(47, 0x0518be170701000000b70900),
(47, 0x0518bf170701000000b80900),
(48, 0x0c18bb170701000000680600),
(48, 0x0d18be170701000000b70900),
(48, 0x0d18bf170701000000b80900),
(49, 0x0418b4170701000000b70900),
(49, 0x0418b5170701000000b80900),
(49, 0x0418b6170701000000b70900),
(49, 0x0418b7170701000000b80900),
(49, 0x0618b8170701000000680600),
(50, 0x0918b4170701000000b70900),
(50, 0x0918b5170701000000b80900),
(50, 0x0b18b8170701000000680600),
(51, 0x0418af170701000000bd0900),
(51, 0x0518af170701000000be0900),
(51, 0x0318b1170701000000660600),
(52, 0x0418af170601000000b70900),
(52, 0x0418b0170601000000b80900),
(52, 0x0818b0170601000000660600),
(53, 0x0418b6170601000000b70900),
(53, 0x0418b7170601000000b80900),
(53, 0x0518b6170601000000b70900),
(53, 0x0518b7170601000000b80900),
(53, 0x0818b7170601000000660600),
(53, 0x0d18b6170601000000660600);

-- --------------------------------------------------------

--
-- Estrutura da tabela `towns`
--

CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `towns`
--

INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES
(1, 'Rookgaard', 32097, 32219, 7),
(2, 'Thais', 32369, 32241, 7),
(3, 'Carlin', 32360, 31782, 7),
(4, 'Kazordoon', 32649, 31925, 11),
(5, 'Ab\'Dendriel', 32732, 31634, 7),
(6, 'Edron', 33217, 31814, 8),
(7, 'Darashia', 33213, 32454, 1),
(8, 'Venore', 32957, 32076, 7),
(9, 'Ankrahmun', 33194, 32853, 8),
(10, 'Isle of Solitude', 32316, 31942, 7),
(11, 'Fibula', 32176, 32437, 7),
(12, 'Senja', 32125, 31667, 7),
(13, 'Folda', 32046, 31582, 7),
(14, 'Vega', 32027, 31692, 7),
(15, 'Havoc', 32783, 32243, 6),
(16, 'Orc', 32901, 31771, 7),
(17, 'Minocity', 32404, 32124, 15),
(18, 'Minoroom', 32139, 32109, 11),
(19, 'Desert', 32653, 32117, 7),
(20, 'Swamp', 32724, 31976, 6),
(21, 'Home', 32316, 31942, 7),
(22, 'Mists', 32854, 32333, 6),
(23, 'FibulaDungeon', 32189, 32426, 9),
(24, 'DragonIsle', 32781, 31603, 7),
(25, 'HellsGate', 32675, 31648, 10),
(26, 'Necropolis', 32786, 31683, 14),
(27, 'Trollcaves', 32493, 32259, 8),
(28, 'Elvenbane', 32590, 31657, 7),
(29, 'Fieldofglory', 32430, 31671, 7),
(30, 'Hills', 32553, 31827, 6),
(31, 'Sternum', 32463, 32077, 7),
(32, 'Northport', 32486, 31610, 7),
(33, 'Greenshore', 32273, 32053, 7),
(34, 'Stonehome', 33319, 31766, 7),
(35, 'Camp', 32655, 32208, 7),
(36, 'Cormaya', 33302, 31970, 7),
(37, 'Drefia', 32996, 32417, 7),
(38, 'Ghostship', 33318, 32171, 6),
(39, 'VenoreDragons', 32793, 32155, 8),
(40, 'Shadowthorn', 33086, 32157, 7),
(41, 'Amazons', 32839, 31925, 7),
(42, 'KingsIsle', 32174, 31940, 7),
(43, 'Ghostlands', 32223, 31831, 7),
(44, 'Oasis', 33132, 32661, 7),
(45, 'Marid', 33103, 32539, 6),
(46, 'Efreet', 33053, 32622, 6),
(47, 'Eremo', 33323, 31883, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote`
--

CREATE TABLE `znote` (
  `id` int(10) NOT NULL,
  `version` varchar(30) NOT NULL COMMENT 'Znote AAC version',
  `installed` int(10) NOT NULL,
  `cached` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `znote`
--

INSERT INTO `znote` (`id`, `version`, `installed`, `cached`) VALUES
(1, '$version', 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_accounts`
--

CREATE TABLE `znote_accounts` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL,
  `created` int(10) NOT NULL,
  `points` int(10) DEFAULT '0',
  `cooldown` int(10) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `activekey` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(20) NOT NULL,
  `secret` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `znote_accounts`
--

INSERT INTO `znote_accounts` (`id`, `account_id`, `ip`, `created`, `points`, `cooldown`, `active`, `activekey`, `flag`, `secret`) VALUES
(1, 1, 0, 0, 0, 0, 0, 0, '', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_changelog`
--

CREATE TABLE `znote_changelog` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_deleted_characters`
--

CREATE TABLE `znote_deleted_characters` (
  `id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum`
--

CREATE TABLE `znote_forum` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `access` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `guild_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `znote_forum`
--

INSERT INTO `znote_forum` (`id`, `name`, `access`, `closed`, `hidden`, `guild_id`) VALUES
(1, 'Staff Board', 4, 0, 0, 0),
(2, 'Tutors Board', 2, 0, 0, 0),
(3, 'Discussion', 1, 0, 0, 0),
(4, 'Feedback', 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_posts`
--

CREATE TABLE `znote_forum_posts` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_threads`
--

CREATE TABLE `znote_forum_threads` (
  `id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `sticky` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_global_storage`
--

CREATE TABLE `znote_global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_guild_wars`
--

CREATE TABLE `znote_guild_wars` (
  `id` int(11) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_images`
--

CREATE TABLE `znote_images` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `desc` text NOT NULL,
  `date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` varchar(30) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_news`
--

CREATE TABLE `znote_news` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `date` int(11) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `znote_news`
--

INSERT INTO `znote_news` (`id`, `title`, `text`, `date`, `pid`) VALUES
(1, 'A new start', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus semper sem mauris, ac bibendum lorem lobortis id. Nulla pulvinar aliquet elementum. In hac habitasse platea dictumst. Aliquam egestas eros nec massa placerat, at sollicitudin quam molestie. Sed at imperdiet augue. Aliquam nibh eros, tincidunt facilisis dapibus a, molestie porttitor dui. Mauris lacinia quam ut est hendrerit, at lobortis ante tempus.\r\n<br>\r\nPraesent vulputate maximus mollis. Nulla elementum eros eu ullamcorper blandit. Ut nec lectus et elit fringilla commodo. Cras fringilla diam erat, ut posuere turpis tempor nec. Pellentesque eu nisl eu dolor blandit interdum. Etiam tincidunt pulvinar efficitur. Vivamus a enim finibus, imperdiet dolor eu, varius tellus. Aenean pellentesque imperdiet tristique. Proin dapibus tristique erat nec euismod. Phasellus et tempus urna. Etiam non velit dolor. Morbi sodales diam erat, ut lacinia nunc maximus ac. Donec euismod arcu eget nulla facilisis ullamcorper.\r\n<br>\r\nAenean lorem quam, eleifend in metus ullamcorper, ultrices ultrices ante. Sed sit amet massa ligula. Nullam volutpat nisl rhoncus sem facilisis fermentum. Nunc blandit posuere dolor non rhoncus. Integer vitae tempus urna. Sed dapibus tincidunt dui vel auctor. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi in tincidunt mi, dignissim pretium risus. Quisque tincidunt tristique dui, nec sagittis mauris cursus vel. Curabitur id interdum ipsum, ac vehicula orci. Proin sed neque porttitor, iaculis mauris vitae, vestibulum est. In sed hendrerit ante, quis sagittis ligula. Etiam eleifend quam sed neque malesuada, a commodo nulla dapibus. Praesent fringilla tempus odio id varius. Aenean in venenatis justo. Donec dapibus tincidunt dapibus.\r\n<br>\r\nSed pulvinar vulputate arcu at fermentum. Suspendisse quis enim nec elit placerat feugiat. Vestibulum sed congue nunc, vel pellentesque nibh. Etiam facilisis quis ipsum a varius. Nullam eleifend elementum congue. Donec velit nulla, ornare quis cursus tempus, viverra sed turpis. Ut dictum dui ipsum, ac vehicula arcu convallis a. Vestibulum nec magna semper tellus luctus laoreet a non felis. Etiam luctus urna vel ipsum porttitor, ac placerat mi aliquet.\r\n\r\nCras porta varius ante vitae efficitur. Cras quis condimentum metus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed porttitor ac lacus efficitur commodo. Duis iaculis ipsum id elit porttitor mollis. Aliquam id tincidunt ligula. Maecenas dictum lacinia felis vel luctus. Vestibulum ullamcorper, dolor eu consectetur laoreet, leo purus commodo velit, a tempor nisi ex quis quam. Donec hendrerit justo sapien, in tristique eros interdum quis. Aliquam ornare pharetra tortor, in lobortis tortor vulputate luctus. Nullam volutpat condimentum nunc, id rutrum nibh mollis eu.', 12, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paygol`
--

CREATE TABLE `znote_paygol` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paypal`
--

CREATE TABLE `znote_paypal` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accid` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_players`
--

CREATE TABLE `znote_players` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `hide_char` tinyint(4) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `znote_players`
--

INSERT INTO `znote_players` (`id`, `player_id`, `created`, `hide_char`, `comment`) VALUES
(1, 1, 0, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_player_reports`
--

CREATE TABLE `znote_player_reports` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `posx` int(6) NOT NULL,
  `posy` int(6) NOT NULL,
  `posz` int(6) NOT NULL,
  `report_description` varchar(255) NOT NULL,
  `date` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop`
--

CREATE TABLE `znote_shop` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_logs`
--

CREATE TABLE `znote_shop_logs` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_orders`
--

CREATE TABLE `znote_shop_orders` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets`
--

CREATE TABLE `znote_tickets` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 NOT NULL,
  `subject` text CHARACTER SET latin1 NOT NULL,
  `message` text CHARACTER SET latin1 NOT NULL,
  `ip` int(11) NOT NULL,
  `creation` int(11) NOT NULL,
  `status` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets_replies`
--

CREATE TABLE `znote_tickets_replies` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `username` varchar(32) CHARACTER SET latin1 NOT NULL,
  `message` text CHARACTER SET latin1 NOT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors`
--

CREATE TABLE `znote_visitors` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors_details`
--

CREATE TABLE `znote_visitors_details` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Indexes for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Indexes for table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Indexes for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Indexes for table `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Indexes for table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Indexes for table `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `monsters`
--
ALTER TABLE `monsters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Indexes for table `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Indexes for table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `player_murders`
--
ALTER TABLE `player_murders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Indexes for table `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Indexes for table `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Indexes for table `tibia_items`
--
ALTER TABLE `tibia_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Indexes for table `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `znote`
--
ALTER TABLE `znote`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_accounts`
--
ALTER TABLE `znote_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_changelog`
--
ALTER TABLE `znote_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_forum`
--
ALTER TABLE `znote_forum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_global_storage`
--
ALTER TABLE `znote_global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Indexes for table `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_images`
--
ALTER TABLE `znote_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_news`
--
ALTER TABLE `znote_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_paygol`
--
ALTER TABLE `znote_paygol`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_paypal`
--
ALTER TABLE `znote_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_players`
--
ALTER TABLE `znote_players`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_shop`
--
ALTER TABLE `znote_shop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_tickets`
--
ALTER TABLE `znote_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_visitors`
--
ALTER TABLE `znote_visitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=862;
--
-- AUTO_INCREMENT for table `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `monsters`
--
ALTER TABLE `monsters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `player_murders`
--
ALTER TABLE `player_murders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `tibia_items`
--
ALTER TABLE `tibia_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `towns`
--
ALTER TABLE `towns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `znote`
--
ALTER TABLE `znote`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `znote_accounts`
--
ALTER TABLE `znote_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `znote_changelog`
--
ALTER TABLE `znote_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_forum`
--
ALTER TABLE `znote_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_images`
--
ALTER TABLE `znote_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_news`
--
ALTER TABLE `znote_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `znote_paygol`
--
ALTER TABLE `znote_paygol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_paypal`
--
ALTER TABLE `znote_paypal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_players`
--
ALTER TABLE `znote_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_shop`
--
ALTER TABLE `znote_shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_tickets`
--
ALTER TABLE `znote_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_visitors`
--
ALTER TABLE `znote_visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD CONSTRAINT `znote_guild_wars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
