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

 Date: 28/05/2019 18:48:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件md5',
  `file_size` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件大小 单位B',
  `folder_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件在服务器上的位置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (29, '8e11d3d1e8149d6141a7d1043e07182c', '50', '0');
INSERT INTO `file` VALUES (30, 'c9aacfe0e187b789fb8fcea78f6eca98', '510', '0');
INSERT INTO `file` VALUES (31, '9cd722b4ab4b297e6c53f6d4b1009be3', '770048', '0');

-- ----------------------------
-- Table structure for folder
-- ----------------------------
DROP TABLE IF EXISTS `folder`;
CREATE TABLE `folder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件夹ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件夹名字',
  `user_id` int(11) NOT NULL COMMENT '所属用户ID',
  `folder_time` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '修改文件夹内容的时间',
  `p_folder_id` int(11) NOT NULL COMMENT '上级文件夹ID 顶部为0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `用户ID`(`user_id`) USING BTREE,
  INDEX `p_folder_id`(`p_folder_id`) USING BTREE,
  CONSTRAINT `用户ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `文件夹层级` FOREIGN KEY (`p_folder_id`) REFERENCES `folder` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of folder
-- ----------------------------
INSERT INTO `folder` VALUES (0, '用于维持外键的关系!勿删!!!!', 0, '000000', 0);
INSERT INTO `folder` VALUES (55, 'oko', 1006, '1559039758', 0);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(1) NOT NULL COMMENT '权限ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (0, '用户');
INSERT INTO `permission` VALUES (1, '管理员');

-- ----------------------------
-- Table structure for share_base
-- ----------------------------
DROP TABLE IF EXISTS `share_base`;
CREATE TABLE `share_base`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分享链接',
  `type` int(1) NOT NULL COMMENT 'folder为0 file为1',
  `link_id` int(11) NOT NULL COMMENT '链接到 share_file 或 share_folder 表的ID',
  `pwd` varchar(4) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '分享密码',
  `limit_time` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for share_file
-- ----------------------------
DROP TABLE IF EXISTS `share_file`;
CREATE TABLE `share_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享typeID',
  `user_file_id` int(11) NOT NULL COMMENT '关联表中的主ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for share_folder
-- ----------------------------
DROP TABLE IF EXISTS `share_folder`;
CREATE TABLE `share_folder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享typeID',
  `user_folder_id` int(11) NOT NULL COMMENT '关系表主ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户密码 两遍md5',
  `permission_id` int(1) NOT NULL DEFAULT 0 COMMENT '权限ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1008 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '0', '0', 0);
INSERT INTO `user` VALUES (1004, 'admin', '0c909a141f1f2c0a1cb602b0b2d7d050', 1);
INSERT INTO `user` VALUES (1006, 'test', 'a60bf8ccb8bb374d12aa50c977c9dc37', 0);

-- ----------------------------
-- Table structure for user_file
-- ----------------------------
DROP TABLE IF EXISTS `user_file`;
CREATE TABLE `user_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `file_id` int(11) NOT NULL COMMENT '文件ID',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件名,相同文件可能有不同文件名',
  `file_time` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '上传文件的时间',
  `folder_id` int(11) NOT NULL COMMENT '文件所处用户文件夹ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userID`(`user_id`) USING BTREE,
  INDEX `文件夹关系`(`folder_id`) USING BTREE,
  CONSTRAINT `userID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `文件夹关系` FOREIGN KEY (`folder_id`) REFERENCES `folder` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '显示的用户名',
  `sex` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '性别',
  `e_mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '手机号',
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '个人网站',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '所在地理位置',
  `max_filesize` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '10737418240' COMMENT '空间大小',
  PRIMARY KEY (`userid`) USING BTREE,
  CONSTRAINT `user主表` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1006, 'test', NULL, NULL, NULL, NULL, NULL, '10737418240');

-- ----------------------------
-- View structure for file_num_in_system
-- ----------------------------
DROP VIEW IF EXISTS `file_num_in_system`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `file_num_in_system` AS select `file`.`folder_path` AS `path`,count(`file`.`folder_path`) AS `num` from `file` group by `file`.`folder_path`;

SET FOREIGN_KEY_CHECKS = 1;
