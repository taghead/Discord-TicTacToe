-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2018 at 06:16 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `practice`
--

-- --------------------------------------------------------

--
-- Table structure for table `gameTicTacToe`
--

CREATE TABLE `gameTicTacToe` (
  `sessID` int(100) NOT NULL,
  `serverID` bigint(100) DEFAULT NULL,
  `gameName` varchar(100) DEFAULT NULL,
  `saveData` varchar(100) DEFAULT NULL,
  `saveData0` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gameTicTacToe`
--

INSERT INTO `gameTicTacToe` (`sessID`, `serverID`, `gameName`, `saveData`, `saveData0`) VALUES
(57, 441579929490948106, 'tictactoe', '---------', 'O');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `gameTicTacToe`
--
ALTER TABLE `gameTicTacToe`
  ADD PRIMARY KEY (`sessID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gameTicTacToe`
--
ALTER TABLE `gameTicTacToe`
  MODIFY `sessID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
