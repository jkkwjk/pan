/*
 Navicat Premium Data Transfer

 Source Server         : mySQl
 Source Server Type    : MySQL
 Source Server Version : 50642
 Source Host           : localhost:3306
 Source Schema         : pan

 Target Server Type    : MySQL
 Target Server Version : 50642
 File Encoding         : 65001

 Date: 04/06/2019 20:02:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for share_file
-- ----------------------------
DROP TABLE IF EXISTS `share_file`;
CREATE TABLE `share_file`  (
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分享链接(可保证全局唯一)(UUID)',
  `link_id` int(11) NOT NULL COMMENT 'file_user 表中的rsid',
  `pwd` varchar(4) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '分享密码',
  `limit_time` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`url`) USING BTREE,
  INDEX `文件关联`(`link_id`) USING BTREE,
  CONSTRAINT `文件关联` FOREIGN KEY (`link_id`) REFERENCES `user_file` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
