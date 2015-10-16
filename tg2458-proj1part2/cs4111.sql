-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: cs4111.cwdl9enlsy5w.us-west-2.rds.amazonaws.com    Database: cs4111
-- ------------------------------------------------------
-- Server version	5.6.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BelongsTo`
--

DROP TABLE IF EXISTS `BelongsTo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BelongsTo` (
  `TID` int(11) NOT NULL DEFAULT '0',
  `SeasonYear` int(11) NOT NULL,
  `TeamName` char(40) NOT NULL,
  PRIMARY KEY (`TID`,`SeasonYear`),
  KEY `SeasonYear` (`SeasonYear`),
  CONSTRAINT `BelongsTo_ibfk_1` FOREIGN KEY (`TID`) REFERENCES `Teams` (`TID`),
  CONSTRAINT `BelongsTo_ibfk_2` FOREIGN KEY (`SeasonYear`) REFERENCES `Seasons` (`SeasonYear`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BelongsTo`
--

LOCK TABLES `BelongsTo` WRITE;
/*!40000 ALTER TABLE `BelongsTo` DISABLE KEYS */;
/*!40000 ALTER TABLE `BelongsTo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DidNotPlay`
--

DROP TABLE IF EXISTS `DidNotPlay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DidNotPlay` (
  `GameID` int(11) NOT NULL DEFAULT '0',
  `PID` int(11) NOT NULL DEFAULT '0',
  `Reason` char(40) DEFAULT NULL,
  PRIMARY KEY (`GameID`,`PID`),
  KEY `PID` (`PID`),
  CONSTRAINT `DidNotPlay_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `Players` (`PID`),
  CONSTRAINT `DidNotPlay_ibfk_2` FOREIGN KEY (`GameID`) REFERENCES `Games` (`GameID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DidNotPlay`
--

LOCK TABLES `DidNotPlay` WRITE;
/*!40000 ALTER TABLE `DidNotPlay` DISABLE KEYS */;
/*!40000 ALTER TABLE `DidNotPlay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FlagrantFouls`
--

DROP TABLE IF EXISTS `FlagrantFouls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FlagrantFouls` (
  `PID` int(11) NOT NULL DEFAULT '0',
  `SeasonYear` int(11) NOT NULL,
  `Count` int(11) DEFAULT NULL,
  PRIMARY KEY (`PID`,`SeasonYear`),
  KEY `SeasonYear` (`SeasonYear`),
  CONSTRAINT `FlagrantFouls_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `Players` (`PID`),
  CONSTRAINT `FlagrantFouls_ibfk_2` FOREIGN KEY (`SeasonYear`) REFERENCES `Seasons` (`SeasonYear`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FlagrantFouls`
--

LOCK TABLES `FlagrantFouls` WRITE;
/*!40000 ALTER TABLE `FlagrantFouls` DISABLE KEYS */;
/*!40000 ALTER TABLE `FlagrantFouls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Games`
--

DROP TABLE IF EXISTS `Games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Games` (
  `GameID` int(11) NOT NULL DEFAULT '0',
  `GameDate` date NOT NULL,
  `MatchupID` int(11) NOT NULL,
  `SeasonYear` int(11) NOT NULL,
  PRIMARY KEY (`GameID`),
  KEY `MatchupID` (`MatchupID`),
  KEY `SeasonYear` (`SeasonYear`),
  CONSTRAINT `Games_ibfk_1` FOREIGN KEY (`MatchupID`) REFERENCES `PlaysAt` (`MatchupID`),
  CONSTRAINT `Games_ibfk_2` FOREIGN KEY (`SeasonYear`) REFERENCES `Seasons` (`SeasonYear`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Games`
--

LOCK TABLES `Games` WRITE;
/*!40000 ALTER TABLE `Games` DISABLE KEYS */;
/*!40000 ALTER TABLE `Games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IndPerf`
--

DROP TABLE IF EXISTS `IndPerf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IndPerf` (
  `GameID` int(11) NOT NULL DEFAULT '0',
  `PID` int(11) NOT NULL DEFAULT '0',
  `FGM` int(11) DEFAULT NULL,
  `FGA` int(11) DEFAULT NULL,
  `FTM` int(11) DEFAULT NULL,
  `FTA` int(11) DEFAULT NULL,
  `Pts` int(11) DEFAULT NULL,
  `Reb` int(11) DEFAULT NULL,
  `Ast` int(11) DEFAULT NULL,
  `Stl` int(11) DEFAULT NULL,
  `Blk` int(11) DEFAULT NULL,
  `Turnovers` int(11) DEFAULT NULL,
  `PF` int(11) DEFAULT NULL,
  PRIMARY KEY (`GameID`,`PID`),
  KEY `PID` (`PID`),
  CONSTRAINT `IndPerf_ibfk_1` FOREIGN KEY (`GameID`) REFERENCES `Games` (`GameID`),
  CONSTRAINT `IndPerf_ibfk_2` FOREIGN KEY (`PID`) REFERENCES `Players` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IndPerf`
--

LOCK TABLES `IndPerf` WRITE;
/*!40000 ALTER TABLE `IndPerf` DISABLE KEYS */;
/*!40000 ALTER TABLE `IndPerf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Players`
--

DROP TABLE IF EXISTS `Players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Players` (
  `PID` int(11) NOT NULL DEFAULT '0',
  `PlayerName` char(30) NOT NULL,
  `DOB` date DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Players`
--

LOCK TABLES `Players` WRITE;
/*!40000 ALTER TABLE `Players` DISABLE KEYS */;
/*!40000 ALTER TABLE `Players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlaysAt`
--

DROP TABLE IF EXISTS `PlaysAt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PlaysAt` (
  `MatchupID` int(11) NOT NULL DEFAULT '0',
  `Home…TID` int(11) NOT NULL,
  `Away…TID` int(11) NOT NULL,
  PRIMARY KEY (`MatchupID`),
  KEY `Home…TID` (`Home…TID`),
  KEY `Away…TID` (`Away…TID`),
  CONSTRAINT `PlaysAt_ibfk_1` FOREIGN KEY (`Home…TID`) REFERENCES `Teams` (`TID`),
  CONSTRAINT `PlaysAt_ibfk_2` FOREIGN KEY (`Away…TID`) REFERENCES `Teams` (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlaysAt`
--

LOCK TABLES `PlaysAt` WRITE;
/*!40000 ALTER TABLE `PlaysAt` DISABLE KEYS */;
/*!40000 ALTER TABLE `PlaysAt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Seasons`
--

DROP TABLE IF EXISTS `Seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Seasons` (
  `SeasonYear` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SeasonYear`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seasons`
--

LOCK TABLES `Seasons` WRITE;
/*!40000 ALTER TABLE `Seasons` DISABLE KEYS */;
/*!40000 ALTER TABLE `Seasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Teams` (
  `TID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TechFouls`
--

DROP TABLE IF EXISTS `TechFouls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TechFouls` (
  `PID` int(11) NOT NULL DEFAULT '0',
  `SeasonYear` int(11) NOT NULL,
  `Count` int(11) DEFAULT NULL,
  PRIMARY KEY (`PID`,`SeasonYear`),
  KEY `SeasonYear` (`SeasonYear`),
  CONSTRAINT `TechFouls_ibfk_1` FOREIGN KEY (`PID`) REFERENCES `Players` (`PID`),
  CONSTRAINT `TechFouls_ibfk_2` FOREIGN KEY (`SeasonYear`) REFERENCES `Seasons` (`SeasonYear`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TechFouls`
--

LOCK TABLES `TechFouls` WRITE;
/*!40000 ALTER TABLE `TechFouls` DISABLE KEYS */;
/*!40000 ALTER TABLE `TechFouls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holla`
--

DROP TABLE IF EXISTS `holla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holla` (
  `welcome` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holla`
--

LOCK TABLES `holla` WRITE;
/*!40000 ALTER TABLE `holla` DISABLE KEYS */;
/*!40000 ALTER TABLE `holla` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-13 21:57:16
