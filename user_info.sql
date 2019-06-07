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

 Date: 07/06/2019 16:50:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
