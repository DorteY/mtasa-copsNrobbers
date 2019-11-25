-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Erstellungszeit: 29. Jul 2019 um 10:52
-- Server-Version: 5.7.27
-- PHP-Version: 7.1.30-2+0~20190710.21+debian8~1.gbp011d3c

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `LakeGaming`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ACHIEVMENTS`
--

CREATE TABLE `ACHIEVMENTS` (
  `UID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Ach1` tinyint(2) NOT NULL DEFAULT '0',
  `Ach2` tinyint(2) NOT NULL DEFAULT '0',
  `Ach3` tinyint(2) NOT NULL DEFAULT '0',
  `Ach4` tinyint(2) NOT NULL DEFAULT '0',
  `Ach5` tinyint(2) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `BANS`
--

CREATE TABLE `BANS` (
  `Username` varchar(20) NOT NULL,
  `Admin` varchar(20) NOT NULL,
  `Grund` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Time` int(18) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `BONUSCODES`
--

CREATE TABLE `BONUSCODES` (
  `Typ` varchar(20) NOT NULL,
  `Code` mediumint(6) NOT NULL,
  `Item` varchar(20) NOT NULL,
  `Amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `CHANGELOGS`
--

CREATE TABLE `CHANGELOGS` (
  `SortID` varchar(8) NOT NULL,
  `ID` varchar(12) NOT NULL,
  `Changes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `CHANGELOGS`
--

INSERT INTO `CHANGELOGS` (`SortID`, `ID`, `Changes`) VALUES
('999999', '0.0.0.0.1', 'CHANGES');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `DAILYREWARD`
--

CREATE TABLE `DAILYREWARD` (
  `Username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `INVENTORY`
--

CREATE TABLE `INVENTORY` (
  `UID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Weed` int(11) NOT NULL DEFAULT '0',
  `Burger` int(11) NOT NULL DEFAULT '0',
  `Crowbar` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `UIDcounter`
--

CREATE TABLE `UIDcounter` (
  `UID` int(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `UIDcounter`
--

INSERT INTO `UIDcounter` (`UID`) VALUES
(1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `USERDATA`
--

CREATE TABLE `USERDATA` (
  `UID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Passwort` text NOT NULL,
  `EMail` text NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `IP` varchar(15) NOT NULL DEFAULT '0.0.0.0',
  `Recruiter` varchar(20) NOT NULL,
  `RegisterDate` varchar(50) NOT NULL,
  `LastloginDate` varchar(50) NOT NULL,
  `Money` int(20) NOT NULL,
  `Bankmoney` int(25) NOT NULL,
  `AdminLVL` int(2) NOT NULL,
  `PremiumLVL` int(11) NOT NULL,
  `Playingtime` int(11) NOT NULL,
  `WeekPlayingtime` int(11) NOT NULL,
  `Jailtime` tinyint(4) NOT NULL,
  `Mutedtime` int(11) NOT NULL,
  `LEVELBallas` mediumint(10) NOT NULL,
  `LEVELGrove` mediumint(10) NOT NULL,
  `LEVELPolice` mediumint(10) NOT NULL,
  `EXPBallas` mediumint(10) NOT NULL,
  `EXPGrove` mediumint(10) NOT NULL,
  `EXPPolice` mediumint(10) NOT NULL,
  `Kills` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `Wanteds` tinyint(2) NOT NULL,
  `Vehicleslots` mediumint(4) NOT NULL,
  `Introtask` tinyint(2) NOT NULL,
  `SpawnX` varchar(20) NOT NULL DEFAULT '1481.2',
  `SpawnY` varchar(20) NOT NULL DEFAULT '-1770.6',
  `SpawnZ` varchar(20) NOT NULL DEFAULT '18.8',
  `SpawnROT` varchar(20) NOT NULL DEFAULT '0',
  `LoggedinDB` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `USERSETTINGS`
--

CREATE TABLE `USERSETTINGS` (
  `UID` int(11) NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Hitglocke` tinyint(1) NOT NULL,
  `Soundvolume` tinyint(3) NOT NULL,
  `FPSLIMIT` tinyint(3) NOT NULL,
  `Radar` tinyint(1) NOT NULL,
  `Nametag` tinyint(1) NOT NULL,
  `Autologin` tinyint(1) NOT NULL,
  `Hitglock` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `VEHICLES`
--

CREATE TABLE `VEHICLES` (
  `ID` int(11) NOT NULL,
  `owner` varchar(20) NOT NULL,
  `vehid` smallint(3) NOT NULL,
  `SpawnX` varchar(40) NOT NULL,
  `SpawnY` varchar(40) NOT NULL,
  `SpawnZ` varchar(40) NOT NULL,
  `Tunings` varchar(300) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0',
  `Color` varchar(50) NOT NULL DEFAULT '0|0|0',
  `speedo` tinyint(2) NOT NULL DEFAULT '1',
  `veharmor` tinyint(2) NOT NULL,
  `slot` int(11) NOT NULL,
  `Health` mediumint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `WHITELIST`
--

CREATE TABLE `WHITELIST` (
  `Name` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `WHITELIST`
--

INSERT INTO `WHITELIST` (`Name`, `Serial`) VALUES
('DorteY', 'CA3560670193B7902E9341DAB665A702');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `ACHIEVMENTS`
--
ALTER TABLE `ACHIEVMENTS`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `BANS`
--
ALTER TABLE `BANS`
  ADD PRIMARY KEY (`Serial`);

--
-- Indizes für die Tabelle `BONUSCODES`
--
ALTER TABLE `BONUSCODES`
  ADD PRIMARY KEY (`Code`);

--
-- Indizes für die Tabelle `CHANGELOGS`
--
ALTER TABLE `CHANGELOGS`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `DAILYREWARD`
--
ALTER TABLE `DAILYREWARD`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `INVENTORY`
--
ALTER TABLE `INVENTORY`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `UIDcounter`
--
ALTER TABLE `UIDcounter`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `USERDATA`
--
ALTER TABLE `USERDATA`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `USERSETTINGS`
--
ALTER TABLE `USERSETTINGS`
  ADD PRIMARY KEY (`UID`);

--
-- Indizes für die Tabelle `VEHICLES`
--
ALTER TABLE `VEHICLES`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `WHITELIST`
--
ALTER TABLE `WHITELIST`
  ADD PRIMARY KEY (`Serial`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `VEHICLES`
--
ALTER TABLE `VEHICLES`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
