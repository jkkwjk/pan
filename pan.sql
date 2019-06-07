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

 Date: 07/06/2019 16:45:18
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
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of file
-- ----------------------------
INSERT INTO `file` VALUES (35, '8e22a5cde87de8673c90bb4592881790', '1177600', '0');
INSERT INTO `file` VALUES (36, '0c3745f5c550f2d9a3b3322f1b988868', '297984', '0');
INSERT INTO `file` VALUES (37, 'aa2e45c21935e3a2d2b7efee6fecb621', '1395742', '0');
INSERT INTO `file` VALUES (38, '084b2ad0a5cf4bdd863e92900cbe8359', '556776', '0');
INSERT INTO `file` VALUES (39, '14d37a3b07110b1737589c82f6f810d8', '152521', '0');
INSERT INTO `file` VALUES (40, '2d58387952695d446b99a4eafa78c7c2', '1735076', '0');
INSERT INTO `file` VALUES (41, 'd2b5e6d4a870889ca97e7e3228030c52', '2408', '0');
INSERT INTO `file` VALUES (42, 'bb4c012fe71e2bac7664ff9d976bdf94', '6359869', '0');
INSERT INTO `file` VALUES (43, '0b556705462df76f665df7cb325bdb04', '603', '0');

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
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of folder
-- ----------------------------
INSERT INTO `folder` VALUES (0, '用于维持外键的关系!勿删!!!!', 0, '000000', 0);
INSERT INTO `folder` VALUES (63, '1', 1006, '1559281671', 0);
INSERT INTO `folder` VALUES (64, '2', 1006, '1559281707', 63);
INSERT INTO `folder` VALUES (65, '22', 1006, '1559281712', 63);
INSERT INTO `folder` VALUES (66, '33333', 1006, '1559281782', 65);
INSERT INTO `folder` VALUES (67, '123', 1006, '1559319530', 0);
INSERT INTO `folder` VALUES (68, '123123', 1006, '1559319668', 67);
INSERT INTO `folder` VALUES (69, '来明杰狗', 1006, '1559372695', 0);
INSERT INTO `folder` VALUES (70, '213123', 1006, '1559573928', 0);

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

-- ----------------------------
-- Records of share_file
-- ----------------------------
INSERT INTO `share_file` VALUES ('ba4df9e9175749ee9bc7565afb73fdb3', 53, NULL, '1561047056');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1011 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '0', '0', 0);
INSERT INTO `user` VALUES (1000, 'admin', '0c909a141f1f2c0a1cb602b0b2d7d050', 1);
INSERT INTO `user` VALUES (1006, 'test', 'a60bf8ccb8bb374d12aa50c977c9dc37', 0);
INSERT INTO `user` VALUES (1009, 'test2', 'a60bf8ccb8bb374d12aa50c977c9dc37', 0);
INSERT INTO `user` VALUES (1010, 'test3', 'a60bf8ccb8bb374d12aa50c977c9dc37', 0);
INSERT INTO `user` VALUES (1011, 'ttt4', 'a60bf8ccb8bb374d12aa50c977c9dc37', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_file
-- ----------------------------
INSERT INTO `user_file` VALUES (41, 1006, 35, '95501532754731531.xls', '1559281661', 0);
INSERT INTO `user_file` VALUES (42, 1006, 36, '189050416金凯凯.doc', '1559281663', 0);
INSERT INTO `user_file` VALUES (43, 1006, 37, '2018-2019-2离散数学课程实践任务2.jpg', '1559281665', 0);
INSERT INTO `user_file` VALUES (44, 1006, 36, '189050416金凯凯.doc', '1559281676', 63);
INSERT INTO `user_file` VALUES (45, 1006, 35, '95501532754731531.xls', '1559281679', 63);
INSERT INTO `user_file` VALUES (46, 1006, 38, 'AfterFX.exe', '1559281727', 65);
INSERT INTO `user_file` VALUES (47, 1006, 37, '2018-2019-2离散数学课程实践任务2.docx', '1559281760', 65);
INSERT INTO `user_file` VALUES (48, 1006, 37, '2018-2019-2离散数学课程实践任务2.docx', '1559281775', 64);
INSERT INTO `user_file` VALUES (49, 1006, 36, '189050416金凯凯.doc', '1559281788', 66);
INSERT INTO `user_file` VALUES (50, 1006, 39, '2018-2019-2离散数学课程实践任务2.zip', '1559281791', 66);
INSERT INTO `user_file` VALUES (51, 1006, 40, '1.jpg', '1559372701', 69);
INSERT INTO `user_file` VALUES (52, 1006, 41, 'Main.java', '1559372709', 69);
INSERT INTO `user_file` VALUES (53, 1006, 40, '1.jpg', '1559488702', 0);
INSERT INTO `user_file` VALUES (54, 1006, 42, 'AirPlayer苹果投屏.zip', '1559488710', 0);
INSERT INTO `user_file` VALUES (55, 1006, 40, '1.jpg', '1559573934', 70);
INSERT INTO `user_file` VALUES (56, 1009, 43, 'headers.txt', '1559718736', 0);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1000, 'admin', NULL, NULL, NULL, NULL, NULL, '10737418240', NULL, 'default.jpg', NULL);
INSERT INTO `user_info` VALUES (1006, '金凯凯', '女', '465640448@qq.com', '13656786022', 'www.kzow.com', '我爱我家', '10737418240', '1559830063', 'default.jpg', 'a60bf8ccb8bb374d12aa50c977c9dc37');
INSERT INTO `user_info` VALUES (1009, 'test2', NULL, NULL, NULL, NULL, NULL, '10737418240', '1559736766', 'default.jpg', NULL);
INSERT INTO `user_info` VALUES (1010, 'test3', NULL, NULL, NULL, NULL, NULL, '10737418240', NULL, 'default.jpg', NULL);
INSERT INTO `user_info` VALUES (1011, 'ttt4', NULL, NULL, NULL, NULL, NULL, '10737418240', '1559576844', 'default.jpg', NULL);

-- ----------------------------
-- View structure for file_num_in_system
-- ----------------------------
DROP VIEW IF EXISTS `file_num_in_system`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `file_num_in_system` AS select `file`.`folder_path` AS `path`,count(`file`.`folder_path`) AS `num` from `file` group by `file`.`folder_path`;

SET FOREIGN_KEY_CHECKS = 1;
