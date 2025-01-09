/*
 Navicat Premium Data Transfer

 Source Server         : JavaWeb
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3406
 Source Schema         : hotel

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 09/01/2025 19:40:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_idcard` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`customer_id`) USING BTREE,
  UNIQUE INDEX `customer_idcard`(`customer_idcard`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '37048120040728531X', '巩祉显', '山东建筑大学', '13336374989');
INSERT INTO `customer` VALUES (2, '37132920031027', '张伞', '1', '123456');
INSERT INTO `customer` VALUES (13, 'ID198763', '小英', '山东建筑大学', '546234615712');
INSERT INTO `customer` VALUES (14, 'ID46234504', '小贾', '山东大学', '23756124743');
INSERT INTO `customer` VALUES (15, '370828200525252626', '王老五', 'ss', '15587337015');
INSERT INTO `customer` VALUES (20, '370858555656565152', '巩祉显', 'sdjzu', '14565232546');
INSERT INTO `customer` VALUES (21, '524565255232323252', '小明', '123', '12546552523');
INSERT INTO `customer` VALUES (22, '370828565454541213', '章五', 'jnd', '12325252546');
INSERT INTO `customer` VALUES (23, '370827566262525252', '富哥', 'sdjzu', '12545545555');
INSERT INTO `customer` VALUES (24, '370825455210212123', '阜南', '123', '12452545456');
INSERT INTO `customer` VALUES (25, '275465211212151516', '巩祉显', 'sdjzu', '15546223251');
INSERT INTO `customer` VALUES (26, 'ID123456', '张三丰', '单位C', '1122334455');
INSERT INTO `customer` VALUES (27, 'ID789012', '李四', '单位B', '0987654321');
INSERT INTO `customer` VALUES (28, 'ID345678', '王五', '单位D', '5566778899');
INSERT INTO `customer` VALUES (29, 'ID181726', '小艾', '单位C', '1234734563');
INSERT INTO `customer` VALUES (31, '123456789012345678', '林黛玉', '某公司', '13800138000');
INSERT INTO `customer` VALUES (32, '234567890123456789', '薛宝钗', '某单位', '13900139000');
INSERT INTO `customer` VALUES (33, '345678901234567890', '王熙凤', '某企业', '13700137000');
INSERT INTO `customer` VALUES (34, '456789012345678901', '贾元春', '某公司', '13600136000');
INSERT INTO `customer` VALUES (35, '567890123456789012', '贾迎春', '某单位', '13500135000');
INSERT INTO `customer` VALUES (36, '678901234567890123', '贾探春', '某企业', '13400134000');
INSERT INTO `customer` VALUES (37, '789012345678901234', '贾惜春', '某公司', '13300133000');
INSERT INTO `customer` VALUES (38, '890123456789012345', '秦可卿', '某单位', '13200132000');
INSERT INTO `customer` VALUES (39, '901234567890123456', '薛宝琴', '某企业', '13100131000');
INSERT INTO `customer` VALUES (43, 'ID193845', '小晴', '单位D', '4253462346');
INSERT INTO `customer` VALUES (1011, '3713', '李斯', '1', '123456');
INSERT INTO `customer` VALUES (1012, '371329', '王武', '1', '123456');
INSERT INTO `customer` VALUES (1013, '3713292003', '赵柳', '1', '123456');

-- ----------------------------
-- Table structure for meal_packages
-- ----------------------------
DROP TABLE IF EXISTS `meal_packages`;
CREATE TABLE `meal_packages`  (
  `package_id` int(0) NOT NULL AUTO_INCREMENT,
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `price` decimal(10, 2) NOT NULL,
  `picture_src` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_packages
-- ----------------------------
INSERT INTO `meal_packages` VALUES (1, '标准套餐', '包含主食、配菜和饮料', 50.00, NULL);
INSERT INTO `meal_packages` VALUES (2, '豪华套餐', '包含主食、配菜、饮料和甜点', 100.00, NULL);
INSERT INTO `meal_packages` VALUES (3, '儿童套餐', '适合儿童的营养套餐', 30.00, NULL);
INSERT INTO `meal_packages` VALUES (4, '标准早餐', '含美式炒蛋、培根、新鲜面包、水果拼盘及咖啡或茶', 68.00, '\'https://ai-public.mastergo.com/ai/img_res/a7399150458548bd566e87b0017796d5.jpg\'');
INSERT INTO `meal_packages` VALUES (5, '豪华晚餐', '含和牛牛排、龙虾、精选红酒及精致甜点', 388.00, ' \'https://ai-public.mastergo.com/ai/img_res/a3215c7f3bd505906b7caa8cc86caa27.jpg\'');
INSERT INTO `meal_packages` VALUES (6, '健康素食', '含藜麦沙拉、烤时蔬、坚果及鲜榨果汁', 88.00, '\'https://ai-public.mastergo.com/ai/img_res/4448d6a1f1e8d1db21f0f03b1f1abbce.jpg\'');
INSERT INTO `meal_packages` VALUES (7, '圣诞节特供', '含烤火鸡、圣诞布丁、红酒及节日小食', 298.00, '\'https://ai-public.mastergo.com/ai/img_res/94eb6f5b5fd71ae1afc31e92b14210e0.jpg\'');

-- ----------------------------
-- Table structure for meal_service
-- ----------------------------
DROP TABLE IF EXISTS `meal_service`;
CREATE TABLE `meal_service`  (
  `service_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_id` int(0) NOT NULL,
  `package_id` int(0) NOT NULL,
  `delivery_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `delivery_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待配送',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`service_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  INDEX `package_id`(`package_id`) USING BTREE,
  CONSTRAINT `meal_service_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `meal_service_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `meal_packages` (`package_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_service
-- ----------------------------
INSERT INTO `meal_service` VALUES (13, 1011, 1, '08:19', '101', '待配送', NULL);
INSERT INTO `meal_service` VALUES (14, 1011, 1, '08:19', '101', '待配送', NULL);
INSERT INTO `meal_service` VALUES (15, 1011, 1, '2025-1-7 08:24', '101', '待配送', '2025-1-7 07:10');
INSERT INTO `meal_service` VALUES (20, 1011, 2, '2025-01-07T18:04', '101', '待配送', NULL);
INSERT INTO `meal_service` VALUES (22, 1011, 4, '2025-01-07T19:39', '101', '待配送', NULL);
INSERT INTO `meal_service` VALUES (24, 2, 5, '2025-01-07T19:22', '101', '待配送', '2025-01-0715:19:57.218084100');
INSERT INTO `meal_service` VALUES (34, 1011, 7, '2025-01-08T14:46', '101', '待配送', '2025-01-0808:47');
INSERT INTO `meal_service` VALUES (44, 2, 3, '2025-01-08T12:25', '101', '待配送', '2025-01-0811:25');
INSERT INTO `meal_service` VALUES (48, 1011, 2, '2025-01-08T20:10', '101', '待配送', '2025-01-0816:10');
INSERT INTO `meal_service` VALUES (50, 1, 5, '2025-01-08T20:10', '101', '待配送', '2025-01-0816:10');

-- ----------------------------
-- Table structure for pick_room
-- ----------------------------
DROP TABLE IF EXISTS `pick_room`;
CREATE TABLE `pick_room`  (
  `pick_id` int(0) NOT NULL AUTO_INCREMENT,
  `room_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pick_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `plan_rent` int(0) NOT NULL,
  `sub_id` int(0) NOT NULL,
  `pick_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deposit` int(0) NOT NULL,
  PRIMARY KEY (`pick_id`) USING BTREE,
  INDEX `Room_ID`(`room_id`) USING BTREE,
  INDEX `Sub_id`(`sub_id`) USING BTREE,
  CONSTRAINT `pick_room_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pick_room_ibfk_2` FOREIGN KEY (`sub_id`) REFERENCES `room_reservation` (`sub_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pick_room
-- ----------------------------
INSERT INTO `pick_room` VALUES (4, '3001', '370825455210212123', '阜南', '2025-01-08', '2025-01-09', '双人房', 2, 8, '入住', 0);
INSERT INTO `pick_room` VALUES (5, '3001', '370825455210212123', '阜南', '2025-01-09', '2025-01-10', '双人房', 1, 8, '入住', 0);
INSERT INTO `pick_room` VALUES (15, '3002', 'ID193845', '小晴', '2025-01-09', '2025-01-10', '双人房', 1, 10, '入住', 200);
INSERT INTO `pick_room` VALUES (16, '4001', '37048120040728531X', '巩祉显', '2025-01-10', '2025-01-31', '海景房', 21, 11, '入住', 500);

-- ----------------------------
-- Table structure for rent_case
-- ----------------------------
DROP TABLE IF EXISTS `rent_case`;
CREATE TABLE `rent_case`  (
  `case_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_id` int(0) NOT NULL,
  `customer_idcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pick_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deposit` int(0) NULL DEFAULT NULL,
  `food_services` tinyint(1) NULL DEFAULT NULL,
  `mobility_services` tinyint(1) NULL DEFAULT NULL,
  `amount_spent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`case_id`) USING BTREE,
  INDEX `Customer_id`(`customer_id`) USING BTREE,
  CONSTRAINT `rent_case_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent_case
-- ----------------------------
INSERT INTO `rent_case` VALUES (1, 1, '37048120040728531X', '巩祉显', '山东建筑大学', '13336374989', '入住', 500, 1, NULL, '63976');
INSERT INTO `rent_case` VALUES (2, 31, '123456789012345678', '林黛玉', '某公司', '13800138000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (3, 32, '234567890123456789', '薛宝钗', '某单位', '13900139000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (4, 33, '345678901234567890', '王熙凤', '某企业', '13700137000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (5, 34, '456789012345678901', '贾元春', '某公司', '13600136000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (6, 35, '567890123456789012', '贾迎春', '某单位', '13500135000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (7, 36, '678901234567890123', '贾探春', '某企业', '13400134000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (8, 37, '789012345678901234', '贾惜春', '某公司', '13300133000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (9, 38, '890123456789012345', '秦可卿', '某单位', '13200132000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (10, 39, '901234567890123456', '薛宝琴', '某企业', '13100131000', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (12, 43, 'ID193845', '小晴', '单位D', '4253462346', '入住', 200, 1, 1, '450');
INSERT INTO `rent_case` VALUES (13, 13, 'ID198763', '小英', '山东建筑大学', '546234615712', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (14, 14, 'ID46234504', '小贾', '山东大学', '23756124743', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (15, 2, '37132920031027', '张伞', '1', '123456', NULL, NULL, 1, 1, '518');
INSERT INTO `rent_case` VALUES (16, 1011, '3713', '李斯', '1', '123456', NULL, NULL, 1, 1, '846');
INSERT INTO `rent_case` VALUES (17, 1012, '371329', '王武', '1', '123456', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `rent_case` VALUES (18, 1013, '3713292003', '赵柳', '1', '123456', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for return_room
-- ----------------------------
DROP TABLE IF EXISTS `return_room`;
CREATE TABLE `return_room`  (
  `return_id` int(0) NOT NULL,
  `room_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `return_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pick_id` int(0) NOT NULL,
  PRIMARY KEY (`return_id`) USING BTREE,
  INDEX `Room_ID`(`room_id`) USING BTREE,
  INDEX `Pick_id`(`pick_id`) USING BTREE,
  CONSTRAINT `return_room_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `return_room_ibfk_2` FOREIGN KEY (`pick_id`) REFERENCES `pick_room` (`pick_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of return_room
-- ----------------------------

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `room_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Room_total_number` int(0) NOT NULL,
  `Room_s_number` int(0) NOT NULL,
  `room_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `current_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  INDEX `room_model`(`room_model`) USING BTREE,
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_model`) REFERENCES `room_type` (`room_model`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES ('1001', 2, 2, '总统房', '空闲', '/upload/922997a0-416b-429b-9399-c1af5a33a49f.jpg');
INSERT INTO `room` VALUES ('1002', 2, 2, '总统房', '空闲', '/upload/922997a0-416b-429b-9399-c1af5a33a49f.jpg');
INSERT INTO `room` VALUES ('3001', 5, 4, '双人房', '入住', '');
INSERT INTO `room` VALUES ('3002', 5, 5, '双人房', '已预约', '');
INSERT INTO `room` VALUES ('3003', 5, 4, '双人房', '空闲', '/upload/0f3ec596-cede-4b86-819d-aedaec09fa95.jpg');
INSERT INTO `room` VALUES ('3004', 5, 4, '双人房', '空闲', '/upload/0f3ec596-cede-4b86-819d-aedaec09fa95.jpg');
INSERT INTO `room` VALUES ('3005', 5, 4, '双人房', '空闲', '/upload/0f3ec596-cede-4b86-819d-aedaec09fa95.jpg');
INSERT INTO `room` VALUES ('4001', 3, 2, '海景房', '已预约', '/upload/3f4af531-fc12-407b-b2c6-7723eed3de52.jpg');
INSERT INTO `room` VALUES ('4002', 3, 1, '海景房', '在租', '/upload/3f4af531-fc12-407b-b2c6-7723eed3de52.jpg');
INSERT INTO `room` VALUES ('4003', 3, 1, '海景房', '空闲', '/upload/3f4af531-fc12-407b-b2c6-7723eed3de52.jpg');
INSERT INTO `room` VALUES ('5001', 1, 1, '行政房', '空闲', '/upload/471bbdc7-e0e6-4275-bafd-ca66b3745bac.jpg');
INSERT INTO `room` VALUES ('6001', 2, 1, '单人房', '空闲', '/upload/54da29b1-ec98-41e7-a573-b953b9ffda34.jpg');
INSERT INTO `room` VALUES ('6002', 2, 1, '单人房', '在租', '/upload/54da29b1-ec98-41e7-a573-b953b9ffda34.jpg');

-- ----------------------------
-- Table structure for room_reservation
-- ----------------------------
DROP TABLE IF EXISTS `room_reservation`;
CREATE TABLE `room_reservation`  (
  `sub_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sub_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sub_get_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sub_return_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sub_status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room_id` int(0) NOT NULL,
  PRIMARY KEY (`sub_id`) USING BTREE,
  INDEX `room_model`(`room_model`) USING BTREE,
  CONSTRAINT `room_reservation_ibfk_1` FOREIGN KEY (`room_model`) REFERENCES `room_type` (`room_model`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_reservation
-- ----------------------------
INSERT INTO `room_reservation` VALUES (8, '370825455210212123', '阜南', '双人房', '2025-01-08T06:04:08.299Z', '2025-01-27T00:00:00.000Z', '2025-01-28T00:00:00.000Z', '已入住', 3001);
INSERT INTO `room_reservation` VALUES (9, '275465211212151516', '巩祉显', '双人房', '2025-01-08T06:44:21.516Z', '2025-01-09T00:00:00.000Z', '2025-01-10T00:00:00.000Z', '已入住', 3002);
INSERT INTO `room_reservation` VALUES (10, 'ID193845', '小晴', '双人房', '2025-01-09', '2025-01-10', '2025-01-10', '已入住', 3002);
INSERT INTO `room_reservation` VALUES (11, '37048120040728531X', '巩祉显', '海景房', '2025-01-10', '2025-01-31', '2025-01-31', '已入住', 4001);

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `room_model` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `one_night_rent` float NOT NULL,
  `one_month_rent` float NOT NULL,
  PRIMARY KEY (`room_model`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES ('单人房', 100, 35000);
INSERT INTO `room_type` VALUES ('双人房', 150, 3500);
INSERT INTO `room_type` VALUES ('大床房', 100, 2500);
INSERT INTO `room_type` VALUES ('总统房', 500, 15000);
INSERT INTO `room_type` VALUES ('海景房', 3000, 50000);
INSERT INTO `room_type` VALUES ('海洋房', 400, 120000);
INSERT INTO `room_type` VALUES ('电竞房', 500, 150000);
INSERT INTO `room_type` VALUES ('行政房', 300, 90000);
INSERT INTO `room_type` VALUES ('露天房', 600, 3000000000);

-- ----------------------------
-- Table structure for travel_services
-- ----------------------------
DROP TABLE IF EXISTS `travel_services`;
CREATE TABLE `travel_services`  (
  `service_id` int(0) NOT NULL AUTO_INCREMENT,
  `customer_id` int(0) NOT NULL,
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `destination` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transport_type` enum('火车','飞机','大巴') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passenger_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passenger_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `service_status` enum('预订','完成','取消') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '预订',
  PRIMARY KEY (`service_id`) USING BTREE,
  INDEX `customer_id`(`customer_id`) USING BTREE,
  CONSTRAINT `travel_services_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of travel_services
-- ----------------------------
INSERT INTO `travel_services` VALUES (4, 26, '北京市', '上海市', '火车', '张三', '13800138000', '预订');
INSERT INTO `travel_services` VALUES (5, 27, '济南市', '青岛市', '飞机', '李四', '0987654321', '预订');
INSERT INTO `travel_services` VALUES (6, 1011, '山东省', '济南市', '飞机', '南波', '18954515847', '预订');
INSERT INTO `travel_services` VALUES (7, 43, '曲阜市', '北京市', '飞机', '小晴', '4253462346', '预订');
INSERT INTO `travel_services` VALUES (8, 1011, '山东省', '济南市', '火车', '南波万', '18954515847', '预订');
INSERT INTO `travel_services` VALUES (9, 1011, '山东省', '济南市', '大巴', '南波万', '18954515847', '预订');
INSERT INTO `travel_services` VALUES (10, 2, '山东省', '济南市', '飞机', '南波万', '18954515847', '预订');
INSERT INTO `travel_services` VALUES (11, 2, '山东省', '济南市', '大巴', '南波', '18954515847', '预订');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `User_id` int(0) NOT NULL AUTO_INCREMENT,
  `User_idcard` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Gender` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `User_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Flag_state` tinyint(1) NOT NULL,
  PRIMARY KEY (`User_id`) USING BTREE,
  UNIQUE INDEX `User_idcard`(`User_idcard`) USING BTREE,
  UNIQUE INDEX `User_account`(`User_account`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '123', '张三', '男', '张三', '123', '普通业务员', 1);
INSERT INTO `user` VALUES (2, '12', '李四', '男', '李四', '123', '普通业务员', 1);
INSERT INTO `user` VALUES (3, '2', '王隆森', '男', '王隆森', '123456', '普通业务员', 1);
INSERT INTO `user` VALUES (4, '1234', 'lisi', '男', 'lisi', '123456', '管理员', 1);
INSERT INTO `user` VALUES (5, '12345', '刘子涵', '男', '刘子涵', '123456', '管理员', 1);
INSERT INTO `user` VALUES (6, '123456', '巩祉显', '男', 'gongzhixian', '123456', '经理', 1);
INSERT INTO `user` VALUES (7, '1234567', '邵文柯', '女', '邵文柯', '123456', '普通业务员', 1);
INSERT INTO `user` VALUES (11, '12345678', '啥也不会', '男', '巩祉显', '123456', '经理', 1);

-- ----------------------------
-- View structure for activeusers
-- ----------------------------
DROP VIEW IF EXISTS `activeusers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `activeusers` AS select `user`.`User_id` AS `User_id`,`user`.`User_idcard` AS `User_idcard`,`user`.`Username` AS `Username`,`user`.`Gender` AS `Gender`,`user`.`User_account` AS `User_account`,`user`.`Password` AS `Password`,`user`.`Role` AS `Role` from `user` where (`user`.`Flag_state` = true);

-- ----------------------------
-- View structure for customer_meal_service
-- ----------------------------
DROP VIEW IF EXISTS `customer_meal_service`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `customer_meal_service` AS select `c`.`customer_id` AS `customer_id`,`c`.`customer_name` AS `customer_name`,`mp`.`package_name` AS `meal_package`,`ms`.`delivery_time` AS `meal_delivery_time`,`ms`.`status` AS `meal_status` from ((`customer` `c` left join `meal_service` `ms` on((`c`.`customer_id` = `ms`.`customer_id`))) left join `meal_packages` `mp` on((`ms`.`package_id` = `mp`.`package_id`)));

-- ----------------------------
-- View structure for customer_travel_service
-- ----------------------------
DROP VIEW IF EXISTS `customer_travel_service`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `customer_travel_service` AS select `c`.`customer_id` AS `customer_id`,`c`.`customer_name` AS `customer_name`,`ts`.`transport_type` AS `travel_mode`,`ts`.`destination` AS `travel_destination`,`ts`.`passenger_name` AS `travel_passenger`,`ts`.`passenger_phone` AS `travel_phone`,`ts`.`service_status` AS `travel_status` from (`customer` `c` left join `travel_services` `ts` on((`c`.`customer_id` = `ts`.`customer_id`)));

-- ----------------------------
-- View structure for inactiveusers
-- ----------------------------
DROP VIEW IF EXISTS `inactiveusers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `inactiveusers` AS select `user`.`User_id` AS `User_id`,`user`.`User_idcard` AS `User_idcard`,`user`.`Username` AS `Username`,`user`.`Gender` AS `Gender`,`user`.`User_account` AS `User_account`,`user`.`Password` AS `Password`,`user`.`Role` AS `Role` from `user` where (`user`.`Flag_state` = false);

-- ----------------------------
-- Procedure structure for AddEmployeeWithDefaultFlag
-- ----------------------------
DROP PROCEDURE IF EXISTS `AddEmployeeWithDefaultFlag`;
delimiter ;;
CREATE PROCEDURE `AddEmployeeWithDefaultFlag`(IN p_User_idcard VARCHAR(20),
    IN p_Username VARCHAR(255),
    IN p_Gender VARCHAR(20),
    IN p_User_account VARCHAR(20),
    IN p_Password VARCHAR(20),
    IN p_Role VARCHAR(255))
BEGIN
    -- 插入新员工记录，并将 Flag_state 设置为 TRUE
    INSERT INTO `user` (User_idcard, Username, Gender, User_account, Password, Role, Flag_state)
    VALUES (p_User_idcard, p_Username, p_Gender, p_User_account, p_Password, p_Role, TRUE);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for AddEmployeeWithDefaultPassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `AddEmployeeWithDefaultPassword`;
delimiter ;;
CREATE PROCEDURE `AddEmployeeWithDefaultPassword`(IN p_User_idcard VARCHAR(20),
    IN p_Username VARCHAR(255),
    IN p_Gender VARCHAR(20),
    IN p_User_account VARCHAR(20),
    IN p_Password VARCHAR(20),
    IN p_Role VARCHAR(255))
BEGIN
    -- 检查是否提供了密码，如果没有提供，则使用默认密码 '123456'
    IF p_Password IS NULL OR p_Password = '' THEN
        SET p_Password = '123456';
    END IF;

    -- 插入新员工记录，假定 Flag_state 已有默认值
    INSERT INTO `user` (User_idcard, Username, Gender, User_account, Password, Role, Flag_state)
    VALUES (p_User_idcard, p_Username, p_Gender, p_User_account, p_Password, p_Role, TRUE);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for AddReturnRoom
-- ----------------------------
DROP PROCEDURE IF EXISTS `AddReturnRoom`;
delimiter ;;
CREATE PROCEDURE `AddReturnRoom`(IN p_customer_idcard VARCHAR(20),
    IN p_room_id VARCHAR(20),
    IN p_room_model VARCHAR(50),
    IN p_return_date VARCHAR(20),
    IN p_pick_id INT)
BEGIN
    -- 插入return_room表
    INSERT INTO return_room (customer_idcard, room_id, room_model, return_date, pick_id)
    VALUES (p_customer_idcard, p_room_id, p_room_model, p_return_date, p_pick_id);

    -- 更新room表
    UPDATE room
    SET current_status = '空闲'
    WHERE room_id = p_room_id;

    -- 更新room_reservation表
    UPDATE room_reservation
    SET sub_status = '已退房'
    WHERE room_id = p_room_id AND customer_idcard = p_customer_idcard;

    -- 更新pick_room表
    UPDATE pick_room
    SET pick_status = '已退房'
    WHERE pick_id = p_pick_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sync_rent_case
-- ----------------------------
DROP PROCEDURE IF EXISTS `sync_rent_case`;
delimiter ;;
CREATE PROCEDURE `sync_rent_case`(IN p_customer_id INT,
    IN p_customer_idcard VARCHAR(255),
    IN p_customer_name VARCHAR(255),
    IN p_customer_unit VARCHAR(255),
    IN p_customer_phone VARCHAR(255))
BEGIN
    DECLARE v_exists INT;

    -- 检查 rent_case 表中是否已经存在该客户
    SELECT COUNT(*) INTO v_exists
    FROM rent_case
    WHERE Customer_id = p_customer_id;

    IF v_exists > 0 THEN
        -- 如果存在，更新 rent_case 表中的相关字段
        UPDATE rent_case
        SET Customer_idcard = p_customer_idcard,
            Customer_name = p_customer_name,
            customer_unit = p_customer_unit,
            Customer_phone = p_customer_phone
        WHERE Customer_id = p_customer_id;
    ELSE
        -- 如果不存在，插入新的记录到 rent_case 表
        INSERT INTO rent_case (Customer_id, Customer_idcard, Customer_name, customer_unit, Customer_phone)
        VALUES (p_customer_id, p_customer_idcard, p_customer_name, p_customer_unit, p_customer_phone);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_rent_amount_spent
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_rent_amount_spent`;
delimiter ;;
CREATE PROCEDURE `update_rent_amount_spent`(IN p_customer_id INT)
BEGIN
    DECLARE v_plan_rent INT;
    DECLARE v_deposit INT;
    DECLARE v_one_night_rent FLOAT;
    DECLARE v_one_month_rent FLOAT;
    DECLARE v_amount_spent FLOAT;
    DECLARE v_total_rent FLOAT;

    -- 获取租房信息
    SELECT plan_rent, deposit, rt.one_night_rent, rt.one_month_rent
    INTO v_plan_rent, v_deposit, v_one_night_rent, v_one_month_rent
    FROM pick_room pr
    JOIN room r ON pr.room_id = r.room_id
    JOIN room_type rt ON r.room_model = rt.room_model
    WHERE pr.customer_idcard = (SELECT customer_idcard FROM customer WHERE customer_id = p_customer_id)
    ORDER BY pr.pick_id DESC
    LIMIT 1;

    -- 计算租金消费总额
    SET v_total_rent = (FLOOR(v_plan_rent / 30) * v_one_month_rent) + ((v_plan_rent % 30) * v_one_night_rent);
    SET v_amount_spent = v_total_rent + v_deposit;

    -- 更新 rent_case 表中的 amount_spent 字段
    UPDATE rent_case
    SET amount_spent = IFNULL(amount_spent, 0) + v_amount_spent
    WHERE customer_id = p_customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table customer
-- ----------------------------
DROP TRIGGER IF EXISTS `after_customer_insert`;
delimiter ;;
CREATE TRIGGER `after_customer_insert` AFTER INSERT ON `customer` FOR EACH ROW BEGIN
    CALL sync_rent_case(NEW.customer_id, NEW.customer_idcard, NEW.customer_name, NEW.customer_unit, NEW.customer_phone);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table customer
-- ----------------------------
DROP TRIGGER IF EXISTS `after_customer_update`;
delimiter ;;
CREATE TRIGGER `after_customer_update` AFTER UPDATE ON `customer` FOR EACH ROW BEGIN
    CALL sync_rent_case(NEW.customer_id, NEW.customer_idcard, NEW.customer_name, NEW.customer_unit, NEW.customer_phone);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table meal_service
-- ----------------------------
DROP TRIGGER IF EXISTS `after_meal_service_insert_update`;
delimiter ;;
CREATE TRIGGER `after_meal_service_insert_update` AFTER INSERT ON `meal_service` FOR EACH ROW BEGIN
    DECLARE v_meal_price FLOAT;

    -- 获取餐饮消费金额
    SELECT price INTO v_meal_price
    FROM meal_packages
    WHERE package_id = NEW.package_id;

    -- 更新 rent_case 表中的 amount_spent 字段
    UPDATE rent_case
    SET amount_spent = IFNULL(amount_spent, 0) + v_meal_price
    WHERE customer_id = NEW.customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table meal_service
-- ----------------------------
DROP TRIGGER IF EXISTS `after_meal_service_update`;
delimiter ;;
CREATE TRIGGER `after_meal_service_update` AFTER UPDATE ON `meal_service` FOR EACH ROW BEGIN
    DECLARE v_meal_price FLOAT;

    -- 获取餐饮消费金额
    SELECT price INTO v_meal_price
    FROM meal_packages
    WHERE package_id = NEW.package_id;

    -- 更新 rent_case 表中的 amount_spent 字段
    UPDATE rent_case
    SET amount_spent = IFNULL(amount_spent, 0) + v_meal_price
    WHERE customer_id = NEW.customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table meal_service
-- ----------------------------
DROP TRIGGER IF EXISTS `after_meal_service_insert`;
delimiter ;;
CREATE TRIGGER `after_meal_service_insert` AFTER INSERT ON `meal_service` FOR EACH ROW BEGIN
    UPDATE rent_case
    SET Food_Services = TRUE
    WHERE Customer_id = NEW.customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table meal_service
-- ----------------------------
DROP TRIGGER IF EXISTS `update_meal_service`;
delimiter ;;
CREATE TRIGGER `update_meal_service` BEFORE INSERT ON `meal_service` FOR EACH ROW BEGIN
	SET new.status = '待配送';
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pick_room
-- ----------------------------
DROP TRIGGER IF EXISTS `AfterCustomerCheckIn`;
delimiter ;;
CREATE TRIGGER `AfterCustomerCheckIn` AFTER INSERT ON `pick_room` FOR EACH ROW BEGIN
    UPDATE room_reservation
    SET sub_status = '已入住'
    WHERE room_id = NEW.room_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pick_room
-- ----------------------------
DROP TRIGGER IF EXISTS `AfterPickRoomInsert`;
delimiter ;;
CREATE TRIGGER `AfterPickRoomInsert` AFTER INSERT ON `pick_room` FOR EACH ROW BEGIN
  UPDATE rent_case
  SET 
    Pick_status = NEW.pick_status,
    deposit = NEW.deposit
  WHERE Customer_id = (SELECT customer_id FROM customer WHERE customer_idcard = NEW.customer_idcard);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pick_room
-- ----------------------------
DROP TRIGGER IF EXISTS `AfterPickRoomUpdate`;
delimiter ;;
CREATE TRIGGER `AfterPickRoomUpdate` AFTER UPDATE ON `pick_room` FOR EACH ROW BEGIN
  UPDATE rent_case
  SET 
    Pick_status = NEW.pick_status,
    deposit = NEW.deposit
  WHERE Customer_id = (SELECT customer_id FROM customer WHERE customer_idcard = NEW.customer_idcard);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pick_room
-- ----------------------------
DROP TRIGGER IF EXISTS `after_pick_room_insert_update`;
delimiter ;;
CREATE TRIGGER `after_pick_room_insert_update` AFTER INSERT ON `pick_room` FOR EACH ROW BEGIN
    CALL update_rent_amount_spent((SELECT customer_id FROM customer WHERE customer_idcard = NEW.customer_idcard));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table pick_room
-- ----------------------------
DROP TRIGGER IF EXISTS `after_pick_room_update`;
delimiter ;;
CREATE TRIGGER `after_pick_room_update` AFTER UPDATE ON `pick_room` FOR EACH ROW BEGIN
    CALL update_rent_amount_spent((SELECT customer_id FROM customer WHERE customer_idcard = NEW.customer_idcard));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table return_room
-- ----------------------------
DROP TRIGGER IF EXISTS `AfterCustomerCheckOut`;
delimiter ;;
CREATE TRIGGER `AfterCustomerCheckOut` AFTER INSERT ON `return_room` FOR EACH ROW BEGIN
    UPDATE room
    SET current_status = '空闲'
    WHERE room_id = NEW.Room_ID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table room_reservation
-- ----------------------------
DROP TRIGGER IF EXISTS `after_room_reservation_insert`;
delimiter ;;
CREATE TRIGGER `after_room_reservation_insert` AFTER INSERT ON `room_reservation` FOR EACH ROW BEGIN
    UPDATE room
    SET current_status = '已预约'
    WHERE room_id = NEW.room_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table room_reservation
-- ----------------------------
DROP TRIGGER IF EXISTS `AfterReservationDelete`;
delimiter ;;
CREATE TRIGGER `AfterReservationDelete` AFTER DELETE ON `room_reservation` FOR EACH ROW BEGIN
    UPDATE room
    SET current_status = '空闲'
    WHERE room_id = OLD.room_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table travel_services
-- ----------------------------
DROP TRIGGER IF EXISTS `after_travel_services_insert`;
delimiter ;;
CREATE TRIGGER `after_travel_services_insert` AFTER INSERT ON `travel_services` FOR EACH ROW BEGIN
    UPDATE rent_case
    SET Mobility_services = TRUE
    WHERE Customer_id = NEW.customer_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table travel_services
-- ----------------------------
DROP TRIGGER IF EXISTS `update_travel_service`;
delimiter ;;
CREATE TRIGGER `update_travel_service` BEFORE INSERT ON `travel_services` FOR EACH ROW BEGIN
    SET new.service_status = '预订';
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
