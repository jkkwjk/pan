/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : pan

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 10/05/2022 15:06:40
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
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of file
-- ----------------------------

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
  CONSTRAINT `文件夹层级` FOREIGN KEY (`p_folder_id`) REFERENCES `folder` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `用户ID` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of folder
-- ----------------------------
INSERT INTO `folder` VALUES (1, '用于维持外键的关系!勿删!!!!', 0, '000000', 1);
INSERT INTO `folder` VALUES (71, '测试', 1012, '1652164248', 1);

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(1) NOT NULL COMMENT '权限ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (0, '用户');
INSERT INTO `permission` VALUES (1, '管理员');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of share_file
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1012 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1012, 'test', 'fb469d7ef430b0baf0cab6c436e70375', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_file
-- ----------------------------

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
  `last_login_time` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '最后登录时间',
  `img_path` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT 'default.jpg' COMMENT '用户图片数据',
  `confim_pwd` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '删除确认密码',
  PRIMARY KEY (`userid`) USING BTREE,
  CONSTRAINT `user主表` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1012, 'test', NULL, NULL, NULL, NULL, NULL, '10737418240', '1652165354', 'default.jpg', NULL);

-- ----------------------------
-- View structure for file_num_in_system
-- ----------------------------
DROP VIEW IF EXISTS `file_num_in_system`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `file_num_in_system` AS select `file`.`folder_path` AS `path`,count(`file`.`folder_path`) AS `num` from `file` group by `file`.`folder_path`;

SET FOREIGN_KEY_CHECKS = 1;
