/*
Navicat MySQL Data Transfer

Source Server         : xuedu
Source Server Version : 50614
Source Host           : 121.40.50.245:33063
Source Database       : xuedu

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2016-02-29 09:39:35
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `download_count`
-- ----------------------------
DROP TABLE IF EXISTS `download_count`;
CREATE TABLE `download_count` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COUNT` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of download_count
-- ----------------------------
INSERT INTO `download_count` VALUES ('1', '2122');
