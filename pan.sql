/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : pan

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 23/05/2019 13:09:19
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (1, '5A105E8B9D40E1329780D62EA2265D8A', '5', '1');
INSERT INTO `file` VALUES (2, '7E9A5A68E62486CC1D9295C6C304F08C', '14', '1');

-- ----------------------------
-- Table structure for folder
-- ----------------------------
DROP TABLE IF EXISTS `folder`;
CREATE TABLE `folder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件夹ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件夹名字',
  `user_id` int(11) NOT NULL COMMENT '所属用户ID',
  `folder_time` timestamp(0) NOT NULL COMMENT '修改文件夹内容的时间',
  `p_folder_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '上级文件夹ID 顶部为0',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `用户ID`(`user_id`) USING BTREE,
  CONSTRAINT `用户ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of folder
-- ----------------------------
INSERT INTO `folder` VALUES (1, '一级文件夹', 1004, '2019-05-07 00:00:00', '0');
INSERT INTO `folder` VALUES (4, 'SDF', 1004, '2019-05-22 22:06:22', '0');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(1) NOT NULL COMMENT '权限ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

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
  `limit_time` timestamp(0) NOT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_file
-- ----------------------------
DROP TABLE IF EXISTS `share_file`;
CREATE TABLE `share_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享typeID',
  `user_file_id` int(11) NOT NULL COMMENT '关联表中的主ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for share_folder
-- ----------------------------
DROP TABLE IF EXISTS `share_folder`;
CREATE TABLE `share_folder`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分享typeID',
  `user_folder_id` int(11) NOT NULL COMMENT '关系表主ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1004 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1004, 'admin', '0c909a141f1f2c0a1cb602b0b2d7d050', 1);

-- ----------------------------
-- Table structure for user_file
-- ----------------------------
DROP TABLE IF EXISTS `user_file`;
CREATE TABLE `user_file`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `file_id` int(11) NOT NULL COMMENT '文件ID',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '文件名,相同文件可能有不同文件名',
  `file_time` timestamp(0) NOT NULL COMMENT '上传文件的时间',
  `folder_id` int(11) NOT NULL COMMENT '文件所处用户文件夹ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userID`(`user_id`) USING BTREE,
  CONSTRAINT `userID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (4, 1004, 1, 'adminname', '2019-04-07 22:04:16', 0);
INSERT INTO `user_file` VALUES (5, 1004, 1, 'flename2', '2019-05-22 21:52:45', 0);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
