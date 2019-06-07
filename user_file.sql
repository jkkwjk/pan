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

 Date: 07/06/2019 16:50:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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

SET FOREIGN_KEY_CHECKS = 1;
