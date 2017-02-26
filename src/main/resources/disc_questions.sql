-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2016 at 01:05 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `crowd_db`
--

--
-- Dumping data for table `discpersonality_questions`
--

INSERT INTO `discpersonality_questions` (`id`, `group_no`, `item_no`, `description`) VALUES
(1, 1, 1, 'People look up to me'),
(2, 1, 2, 'I tend to be a kind person'),
(3, 1, 3, 'I accept life as it comes'),
(4, 1, 4, 'People say I have a strong personality'),
(5, 2, 1, 'I find it difficult to relax'),
(6, 2, 2, 'I have a very wide circle of friends'),
(7, 2, 3, 'I am always ready to help others'),
(8, 2, 4, 'I like to behave correctly'),
(9, 3, 1, 'I tend to do what I am told'),
(10, 3, 2, 'I like things to be very neat and tidy'),
(11, 3, 3, 'People can''t put me down'),
(12, 3, 4, 'I enjoy having fun'),
(13, 4, 1, 'I respect my elders and those in authority'),
(14, 4, 2, 'I am always willing to do new things to take a risk'),
(15, 4, 3, 'I believe things will go well'),
(16, 4, 4, 'I am always willing to help'),
(17, 5, 1, 'I am a neat and orderly person'),
(18, 5, 2, 'I am very active, both at work and play'),
(19, 5, 3, 'I am a very calm and placid person'),
(20, 5, 4, 'I generally get my own way'),
(21, 6, 1, 'I am very contented with life'),
(22, 6, 2, 'I tend to trust people'),
(23, 6, 3, 'I like peace and quiet'),
(24, 6, 4, 'I have a very positive attitude'),
(25, 7, 1, 'I have a great deal of will power'),
(26, 7, 2, 'I always take notice of what other people say'),
(27, 7, 3, 'I try to be obliging'),
(28, 7, 4, 'I am always cheerful'),
(29, 8, 1, 'I am self-confident'),
(30, 8, 2, 'People say I am a sympathetic type'),
(31, 8, 3, 'I have a tolerant attitude towards life'),
(32, 8, 4, 'I am an assertive person'),
(33, 9, 1, 'I never lose my temper'),
(34, 9, 2, 'I like things to be precise and correct'),
(35, 9, 3, 'I am very sure of myself'),
(36, 9, 4, 'I enjoy having a laugh and a joke'),
(37, 10, 1, 'My behaviour is well disciplined'),
(38, 10, 2, 'People see me as being helpful'),
(39, 10, 3, 'I am always on the move'),
(40, 10, 4, 'I persevere until I get what I want'),
(41, 11, 1, 'I enjoy competition'),
(42, 11, 2, 'I do not treat life too seriously'),
(43, 11, 3, 'I always consider others'),
(44, 11, 4, 'I am an agreeable type'),
(45, 12, 1, 'I am very persuasive'),
(46, 12, 2, 'I see myself as a gentle person'),
(47, 12, 3, 'I am a very modest type'),
(48, 12, 4, 'I often come up with original ideas'),
(49, 13, 1, 'I am very helpful towards others'),
(50, 13, 2, 'I don''t like tempting fate'),
(51, 13, 3, 'I don''t give up easily'),
(52, 13, 4, 'People like my company'),
(53, 14, 1, 'I tend to be a cautious person'),
(54, 14, 2, 'I am a very determined person'),
(55, 14, 3, 'I am good at convincing people'),
(56, 14, 4, 'I tend to be a friendly person'),
(57, 15, 1, 'I don''t scare easily'),
(58, 15, 2, 'People find my company stimulating'),
(59, 15, 3, 'I am always willing to follow orders'),
(60, 15, 4, 'I am a rather shy person'),
(61, 16, 1, 'I am very willing to change my opinion'),
(62, 16, 2, 'I like a good argument'),
(63, 16, 3, 'I tend to be an easy going type'),
(64, 16, 4, 'I always look on the bright side of life'),
(65, 17, 1, 'I am a very social sort of person'),
(66, 17, 2, 'I am very patient'),
(67, 17, 3, 'I am a very self-sufficient sort of person'),
(68, 17, 4, 'I rarely raise my voice'),
(69, 18, 1, 'I am always ready and willing'),
(70, 18, 2, 'I am always keen to try new things'),
(71, 18, 3, 'I don''t like arguments'),
(72, 18, 4, 'People describe me as high spirited'),
(73, 19, 1, 'I enjoy taking a chance'),
(74, 19, 2, 'I tend to be very receptive to other people''s ideas'),
(75, 19, 3, 'I am always polite and courteous'),
(76, 19, 4, 'I am a moderate rather than an extreme person'),
(77, 20, 1, 'I tend to be a forgiving type'),
(78, 20, 2, 'I am a sensitive person'),
(79, 20, 3, 'I have a lot of energy and vigour'),
(80, 20, 4, 'I can mix with anybody'),
(81, 21, 1, 'I enjoy chatting with people'),
(82, 21, 2, 'I control my emotions'),
(83, 21, 3, 'I am very conventional in my outlook'),
(84, 21, 4, 'I make decisions quickly'),
(85, 22, 1, 'I tend to keep my feelings to myself'),
(86, 22, 2, 'Accuracy is very important to me'),
(87, 22, 3, 'I like to speak my mind'),
(88, 22, 4, 'I am very friendly'),
(89, 23, 1, 'I like to handle things with diplomacy'),
(90, 23, 2, 'I am very daring'),
(91, 23, 3, 'Most people find me acceptable'),
(92, 23, 4, 'I feel satisfied with life'),
(93, 24, 1, 'I am obedient'),
(94, 24, 2, 'I am always willing to have a go'),
(95, 24, 3, 'Loyalty is one of my strengths'),
(96, 24, 4, 'I have a good deal of charm'),
(97, 25, 1, 'I tend to be an aggressive type'),
(98, 25, 2, 'I am good fun and have a lot of personality'),
(99, 25, 3, 'People tend to see me as an easy touch'),
(100, 25, 4, 'I tend to be rather timid'),
(101, 26, 1, 'I am good at motivating people'),
(102, 26, 2, 'Patience is one of my major strengths'),
(103, 26, 3, 'I am careful to say the right thing'),
(104, 26, 4, 'I have a strong desire to win'),
(105, 27, 1, 'People find me easy to get on with'),
(106, 27, 2, 'I get a lot of satisfaction from helping others'),
(107, 27, 3, 'I always think things through'),
(108, 27, 4, 'I prefer to get things down now rather than later'),
(109, 28, 1, 'I am good at analysing situations'),
(110, 28, 2, 'I get restless quickly'),
(111, 28, 3, 'I think about how my decisions might affect others'),
(112, 28, 4, 'People see me as relaxed and easy going');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
