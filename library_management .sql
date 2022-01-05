-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 05, 2022 at 06:28 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblbook`
--

CREATE TABLE `tblbook` (
  `bookId` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `genres` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblbook`
--

INSERT INTO `tblbook` (`bookId`, `title`, `author`, `genres`, `description`) VALUES
(1, 'Clean code', 'J.Kansas', 'coding', NULL),
(2, 'Harry Potter', 'J.K Rowling', 'novel', NULL),
(3, 'Algebra', 'Nguyen Van A', 'studying', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblbookcopies`
--

CREATE TABLE `tblbookcopies` (
  `barcode` int(11) NOT NULL,
  `status` varchar(45) NOT NULL,
  `purchaseDate` date NOT NULL,
  `callCardId` int(11) DEFAULT NULL,
  `returningCallCardId` int(11) DEFAULT NULL,
  `bookId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblbookcopies`
--

INSERT INTO `tblbookcopies` (`barcode`, `status`, `purchaseDate`, `callCardId`, `returningCallCardId`, `bookId`) VALUES
(1, 'available', '2021-01-01', 11, 11, 1),
(2, 'available', '2021-01-10', NULL, NULL, 1),
(3, 'available', '2021-02-02', 10, 11, 2),
(4, 'available', '2021-03-03', 11, 11, 2),
(5, 'available', '2021-05-05', NULL, NULL, 2),
(6, 'available', '2021-05-05', NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tblcalllcard`
--

CREATE TABLE `tblcalllcard` (
  `callCardId` int(11) NOT NULL,
  `borrowingDate` date NOT NULL,
  `dueDate` date NOT NULL,
  `libCardId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblcalllcard`
--

INSERT INTO `tblcalllcard` (`callCardId`, `borrowingDate`, `dueDate`, `libCardId`, `userId`) VALUES
(6, '2022-01-04', '2022-02-04', 1, 2),
(10, '2022-01-04', '2022-01-04', 1, 2),
(11, '2022-01-05', '2022-02-05', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbllibcard`
--

CREATE TABLE `tbllibcard` (
  `cardId` int(11) NOT NULL,
  `expDate` date NOT NULL,
  `userId` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbllibcard`
--

INSERT INTO `tbllibcard` (`cardId`, `expDate`, `userId`) VALUES
(1, '2022-02-01', 1),
(2, '2022-02-02', 3),
(3, '2022-02-04', 4);

-- --------------------------------------------------------

--
-- Table structure for table `tblreturningcallcard`
--

CREATE TABLE `tblreturningcallcard` (
  `returningCallCardId` int(11) NOT NULL,
  `fine` float NOT NULL,
  `returningDate` date NOT NULL,
  `libCardId` int(11) NOT NULL,
  `userId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblreturningcallcard`
--

INSERT INTO `tblreturningcallcard` (`returningCallCardId`, `fine`, `returningDate`, `libCardId`, `userId`) VALUES
(1, 100000, '2022-01-05', 1, 2),
(2, 100000, '2022-01-05', 1, 2),
(5, 300000, '2022-01-05', 1, 2),
(7, 200000, '2022-01-05', 1, 2),
(8, 200000, '2022-01-05', 1, 2),
(9, 200000, '2022-01-05', 1, 2),
(10, 110000, '2022-01-05', 1, 2),
(11, 110000, '2022-01-05', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE `tbluser` (
  `id` int(10) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `fullname` varchar(45) NOT NULL,
  `DoB` date NOT NULL,
  `address` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  `description` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbluser`
--

INSERT INTO `tbluser` (`id`, `username`, `password`, `fullname`, `DoB`, `address`, `email`, `telephone`, `role`, `description`) VALUES
(1, 'binh', '123', 'Abraham Castro', '2007-03-21', 'Blanditiis est repe', 'ximysyt@mailinator.com', '+1 (366) 982-9795', 'reader', NULL),
(2, 'binh2', '123', 'Nguyen Thanh Binh', '2000-11-07', '70A Tran Xuan Soan', 'binh@email.com', '0913123121', 'librarian', NULL),
(3, 'loc', '123', 'Penelope Hayden', '2004-02-17', 'Eius sed eiusmod aut', 'webekedu@mailinator.com', '+1 (735) 361-4689', 'reader', NULL),
(4, 'loc2', '123', 'Yvonne Dunn', '1983-06-12', 'Elit consectetur e', 'rovasuc@mailinator.com', '+1 (352) 969-4508', 'reader', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblbook`
--
ALTER TABLE `tblbook`
  ADD PRIMARY KEY (`bookId`),
  ADD UNIQUE KEY `id_UNIQUE` (`bookId`);

--
-- Indexes for table `tblbookcopies`
--
ALTER TABLE `tblbookcopies`
  ADD PRIMARY KEY (`barcode`),
  ADD UNIQUE KEY `barcode_UNIQUE` (`barcode`),
  ADD KEY `fk_bookCopies_callCard_idx` (`callCardId`),
  ADD KEY `fk_bookCopies_returningCallCard_idx` (`returningCallCardId`),
  ADD KEY `fk_bookCopies_book_idx` (`bookId`);

--
-- Indexes for table `tblcalllcard`
--
ALTER TABLE `tblcalllcard`
  ADD PRIMARY KEY (`callCardId`),
  ADD UNIQUE KEY `id_UNIQUE` (`callCardId`),
  ADD UNIQUE KEY `callCard_UNIQUE` (`callCardId`),
  ADD KEY `fk_calllCard_libCard_idx` (`libCardId`),
  ADD KEY `fk_calllCard_user_idx` (`userId`);

--
-- Indexes for table `tbllibcard`
--
ALTER TABLE `tbllibcard`
  ADD PRIMARY KEY (`cardId`),
  ADD UNIQUE KEY `cardId_UNIQUE` (`cardId`),
  ADD KEY `fk_libcard-user_idx` (`userId`);

--
-- Indexes for table `tblreturningcallcard`
--
ALTER TABLE `tblreturningcallcard`
  ADD PRIMARY KEY (`returningCallCardId`),
  ADD KEY `fk_returningCallCard_libCard_idx` (`libCardId`),
  ADD KEY `fk_returingCallCard_user_idx` (`userId`);

--
-- Indexes for table `tbluser`
--
ALTER TABLE `tbluser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblbook`
--
ALTER TABLE `tblbook`
  MODIFY `bookId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblbookcopies`
--
ALTER TABLE `tblbookcopies`
  MODIFY `barcode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tblcalllcard`
--
ALTER TABLE `tblcalllcard`
  MODIFY `callCardId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbllibcard`
--
ALTER TABLE `tbllibcard`
  MODIFY `cardId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tblreturningcallcard`
--
ALTER TABLE `tblreturningcallcard`
  MODIFY `returningCallCardId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblbookcopies`
--
ALTER TABLE `tblbookcopies`
  ADD CONSTRAINT `fk_bookCopies_book` FOREIGN KEY (`bookId`) REFERENCES `tblbook` (`bookId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bookCopies_callCardId` FOREIGN KEY (`callCardId`) REFERENCES `tblcalllcard` (`callCardId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bookCopies_returningCallCard` FOREIGN KEY (`returningCallCardId`) REFERENCES `tblreturningcallcard` (`returningCallCardId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblcalllcard`
--
ALTER TABLE `tblcalllcard`
  ADD CONSTRAINT `fk_calllCard_libCard` FOREIGN KEY (`libCardId`) REFERENCES `tbllibcard` (`cardId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_calllCard_user` FOREIGN KEY (`userId`) REFERENCES `tbluser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbllibcard`
--
ALTER TABLE `tbllibcard`
  ADD CONSTRAINT `fk_libcard_user` FOREIGN KEY (`userId`) REFERENCES `tbluser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblreturningcallcard`
--
ALTER TABLE `tblreturningcallcard`
  ADD CONSTRAINT `fk_returingCallCard_user` FOREIGN KEY (`userId`) REFERENCES `tbluser` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_returningCallCard_libCard` FOREIGN KEY (`libCardId`) REFERENCES `tbllibcard` (`cardId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
