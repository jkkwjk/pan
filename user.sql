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

 Date: 07/06/2019 16:47:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
