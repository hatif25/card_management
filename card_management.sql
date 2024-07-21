-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2024 at 06:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `card_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `card`
--

CREATE TABLE `card` (
  `card_number` varchar(30) NOT NULL,
  `expiry_date` year(4) NOT NULL,
  `bankName` varchar(20) NOT NULL,
  `card_holder_name` varchar(30) NOT NULL,
  `uname` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `card`
--

INSERT INTO `card` (`card_number`, `expiry_date`, `bankName`, `card_holder_name`, `uname`) VALUES
('1234  5654  3212  3456', '2022', 'SBI', 'sss', 'hatif25'),
('2589  6565  4656  4566', '2028', 'SBI', 'Hatif', 'hatif25'),
('3456  5432  3454  3234', '2022', 'sbi', 'sansk', 'sans2');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ctg_id` int(40) NOT NULL,
  `ctg_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `card_no` varchar(30) NOT NULL,
  `date_of_payment` varchar(30) NOT NULL,
  `amount` varchar(20) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `exp_id` int(20) NOT NULL,
  `payee` varchar(20) NOT NULL,
  `category` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`card_no`, `date_of_payment`, `amount`, `description`, `exp_id`, `payee`, `category`) VALUES
('2589  6565  4656  4566', '23/02/2024', '2500', NULL, 1, 'Himanshu Chauhan', 'Grocery');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `trsn_id` varchar(30) NOT NULL,
  `card_no` varchar(30) NOT NULL,
  `date_of_payment` date NOT NULL,
  `amount` int(20) NOT NULL,
  `payee` varchar(20) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`trsn_id`, `card_no`, `date_of_payment`, `amount`, `payee`, `category`) VALUES
('12345321', '2589  6565  4656  4566', '2020-08-08', 20, 'fff', 'Condiments'),
('123456', '1234  5654  3212  3456', '2021-04-03', 333, 'aa', 'Grocery'),
('123456789876', '2589  6565  4656  4566', '2022-05-04', 666, 'himanshu', 'Entertainment'),
('2345432345', '3456  5432  3454  3234', '2022-03-04', 2100, 'himansh', 'Entertainment'),
('23456', '2589  6565  4656  4566', '2021-02-03', 2222, 'him', 'Condiments'),
('3434565678', '3456  5432  3454  3234', '2022-11-11', 3000, 'jhhh', 'Grocery');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uname` varchar(20) NOT NULL,
  `fname` varchar(40) NOT NULL,
  `lname` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uname`, `fname`, `lname`, `email`, `phone`, `password`) VALUES
('hatif25', 'hatif', 'farooque', 'mthraza72@gmail.com', '7903430360', '123456789'),
('sans2', 'sanskrita', 'singh', 'sans22@gmail.com', '9998887771', '12121212'),
('shoaib20', 'shoaib', 'md', 'shoaib@gmail.com', '7795374099', '12345678');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`card_number`),
  ADD KEY `uname` (`uname`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ctg_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`exp_id`),
  ADD KEY `card_no` (`card_no`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`trsn_id`),
  ADD KEY `card_no` (`card_no`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ctg_id` int(40) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `exp_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`card_no`) REFERENCES `card` (`card_number`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`card_no`) REFERENCES `card` (`card_number`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
