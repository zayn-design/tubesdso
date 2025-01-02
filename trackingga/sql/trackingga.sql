/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : trackingga

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 02/07/2024 09:23:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lara_menu_items
-- ----------------------------
DROP TABLE IF EXISTS `lara_menu_items`;
CREATE TABLE `lara_menu_items`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent_id` bigint UNSIGNED NULL DEFAULT NULL,
  `weight` int NOT NULL DEFAULT 0,
  `enabled` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `menu_items_menu_id_foreign`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `lara_menus` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_menu_items
-- ----------------------------
INSERT INTO `lara_menu_items` VALUES (1, 1, 'Dashboard', '/dashboard', NULL, NULL, 0, 1, '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_menu_items` VALUES (2, 1, 'Permissions', '/<admin>/permission', NULL, NULL, 1, 1, '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_menu_items` VALUES (3, 1, 'Roles', '/<admin>/role', NULL, NULL, 2, 1, '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_menu_items` VALUES (4, 1, 'Users', '/<admin>/user', NULL, NULL, 3, 1, '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_menu_items` VALUES (5, 1, 'Menus', '/<admin>/menu', NULL, NULL, 4, 1, '2023-03-29 06:39:34', '2023-03-29 07:02:12');
INSERT INTO `lara_menu_items` VALUES (6, 1, 'Submission', 'https://submission.digipufr.com', NULL, NULL, 5, 1, '2023-03-29 06:48:39', '2023-03-29 08:04:57');

-- ----------------------------
-- Table structure for lara_menus
-- ----------------------------
DROP TABLE IF EXISTS `lara_menus`;
CREATE TABLE `lara_menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `machine_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `menus_machine_name_unique`(`machine_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_menus
-- ----------------------------
INSERT INTO `lara_menus` VALUES (1, 'Admin', 'Admin Menu', 'admin', '2023-03-29 06:39:34', '2023-03-29 06:39:34');

-- ----------------------------
-- Table structure for lara_migrations
-- ----------------------------
DROP TABLE IF EXISTS `lara_migrations`;
CREATE TABLE `lara_migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_migrations
-- ----------------------------
INSERT INTO `lara_migrations` VALUES (1, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- ----------------------------
-- Table structure for lara_model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `lara_model_has_permissions`;
CREATE TABLE `lara_model_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `lara_permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for lara_model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `lara_model_has_roles`;
CREATE TABLE `lara_model_has_roles`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `lara_roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_model_has_roles
-- ----------------------------

-- ----------------------------
-- Table structure for lara_permissions
-- ----------------------------
DROP TABLE IF EXISTS `lara_permissions`;
CREATE TABLE `lara_permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_permissions
-- ----------------------------
INSERT INTO `lara_permissions` VALUES (1, 'permission list', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (2, 'permission create', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (3, 'permission edit', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (4, 'permission delete', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (5, 'role list', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (6, 'role create', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (7, 'role edit', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (8, 'role delete', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (9, 'user list', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (10, 'user create', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (11, 'user edit', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (12, 'user delete', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (13, 'menu list', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (14, 'menu create', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (15, 'menu edit', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (16, 'menu delete', 'web', '2023-03-29 06:39:33', '2023-03-29 06:39:33');
INSERT INTO `lara_permissions` VALUES (17, 'menu.item list', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_permissions` VALUES (18, 'menu.item create', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_permissions` VALUES (19, 'menu.item edit', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_permissions` VALUES (20, 'menu.item delete', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_permissions` VALUES (22, 'fst list', 'web', '2023-04-01 19:50:03', '2023-04-01 19:50:03');
INSERT INTO `lara_permissions` VALUES (23, 'fst create', 'web', '2023-04-01 19:50:14', '2023-04-01 19:50:14');
INSERT INTO `lara_permissions` VALUES (24, 'fst edit', 'web', '2023-04-01 19:50:24', '2023-04-01 19:50:24');
INSERT INTO `lara_permissions` VALUES (25, 'fst delete', 'web', '2023-04-01 19:50:35', '2023-04-01 19:50:35');
INSERT INTO `lara_permissions` VALUES (26, 'fp list', 'web', '2023-04-02 07:46:41', '2023-04-02 07:46:41');
INSERT INTO `lara_permissions` VALUES (27, 'fp create', 'web', '2023-04-02 07:46:51', '2023-04-02 07:46:51');
INSERT INTO `lara_permissions` VALUES (28, 'fp edit', 'web', '2023-04-02 07:47:03', '2023-04-02 07:47:03');
INSERT INTO `lara_permissions` VALUES (29, 'fp delete', 'web', '2023-04-02 07:47:10', '2023-04-02 07:47:10');
INSERT INTO `lara_permissions` VALUES (30, 'master_shift list', 'web', NULL, NULL);
INSERT INTO `lara_permissions` VALUES (31, 'master_shift create', 'web', NULL, NULL);
INSERT INTO `lara_permissions` VALUES (32, 'master_shift edit', 'web', NULL, NULL);
INSERT INTO `lara_permissions` VALUES (33, 'master_shift delete', 'web', NULL, NULL);
INSERT INTO `lara_permissions` VALUES (34, 'master_formation list', 'web', '2023-05-13 05:15:09', '2023-05-13 05:15:09');
INSERT INTO `lara_permissions` VALUES (35, 'master_formation create', 'web', '2023-05-13 05:15:22', '2023-05-13 05:15:22');
INSERT INTO `lara_permissions` VALUES (36, 'master_formation edit', 'web', '2023-05-13 05:15:31', '2023-05-13 05:15:31');
INSERT INTO `lara_permissions` VALUES (37, 'master_formation delete', 'web', '2023-05-13 05:15:41', '2023-05-13 05:15:41');
INSERT INTO `lara_permissions` VALUES (38, 'master_item_super_group list', 'web', '2023-05-14 23:27:54', '2023-05-14 23:27:54');
INSERT INTO `lara_permissions` VALUES (39, 'master_item_super_group create', 'web', '2023-05-14 23:28:06', '2023-05-14 23:28:06');
INSERT INTO `lara_permissions` VALUES (40, 'master_item_super_group edit', 'web', '2023-05-14 23:28:12', '2023-05-14 23:28:12');
INSERT INTO `lara_permissions` VALUES (41, 'master_item_super_group delete', 'web', '2023-05-14 23:28:18', '2023-05-14 23:28:18');
INSERT INTO `lara_permissions` VALUES (42, 'master_item_group list', 'web', '2023-05-14 23:28:39', '2023-05-14 23:28:39');
INSERT INTO `lara_permissions` VALUES (43, 'master_item_group create', 'web', '2023-05-14 23:28:45', '2023-05-14 23:28:45');
INSERT INTO `lara_permissions` VALUES (44, 'master_item_group edit', 'web', '2023-05-14 23:28:50', '2023-05-14 23:28:50');
INSERT INTO `lara_permissions` VALUES (45, 'master_item_group delete', 'web', '2023-05-14 23:28:55', '2023-05-14 23:28:55');
INSERT INTO `lara_permissions` VALUES (46, 'master_item_category list', 'web', '2023-05-16 02:55:11', '2023-05-16 02:55:11');
INSERT INTO `lara_permissions` VALUES (47, 'master_item_category create', 'web', '2023-05-16 02:55:42', '2023-05-16 02:55:42');
INSERT INTO `lara_permissions` VALUES (48, 'master_item_category edit', 'web', '2023-05-16 02:55:54', '2023-05-16 02:55:54');
INSERT INTO `lara_permissions` VALUES (49, 'master_item_category delete', 'web', '2023-05-16 02:56:06', '2023-05-16 02:56:06');
INSERT INTO `lara_permissions` VALUES (50, 'master_item_brand list', 'web', '2023-05-18 19:30:33', '2023-05-18 19:30:33');
INSERT INTO `lara_permissions` VALUES (51, 'master_item_brand create', 'web', '2023-05-18 19:30:43', '2023-05-18 19:30:43');
INSERT INTO `lara_permissions` VALUES (52, 'master_item_brand edit', 'web', '2023-05-18 19:30:57', '2023-05-18 19:30:57');
INSERT INTO `lara_permissions` VALUES (53, 'master_item_brand delete', 'web', '2023-05-18 19:31:16', '2023-05-18 19:31:16');
INSERT INTO `lara_permissions` VALUES (54, 'master_item_type list', 'web', '2023-05-18 20:27:01', '2023-05-18 20:27:01');
INSERT INTO `lara_permissions` VALUES (55, 'master_item_type create', 'web', '2023-05-18 20:27:24', '2023-05-18 20:27:24');
INSERT INTO `lara_permissions` VALUES (56, 'master_item_type edit', 'web', '2023-05-18 20:28:35', '2023-05-18 20:28:35');
INSERT INTO `lara_permissions` VALUES (57, 'master_item_type delete', 'web', '2023-05-18 20:28:49', '2023-05-18 20:28:49');
INSERT INTO `lara_permissions` VALUES (58, 'master_item_unit list', 'web', '2023-05-18 21:05:12', '2023-05-18 21:05:12');
INSERT INTO `lara_permissions` VALUES (59, 'master_item_unit create', 'web', '2023-05-18 21:05:17', '2023-05-18 21:05:17');
INSERT INTO `lara_permissions` VALUES (60, 'master_item_unit edit', 'web', '2023-05-18 21:05:23', '2023-05-18 21:05:23');
INSERT INTO `lara_permissions` VALUES (61, 'master_item_unit delete', 'web', '2023-05-18 21:05:29', '2023-05-18 21:05:29');
INSERT INTO `lara_permissions` VALUES (62, 'master_masa_item list', 'web', '2023-05-19 03:05:30', '2023-05-19 03:05:30');
INSERT INTO `lara_permissions` VALUES (63, 'master_masa_item create', 'web', '2023-05-19 03:05:35', '2023-05-19 03:05:35');
INSERT INTO `lara_permissions` VALUES (64, 'master_masa_item edit', 'web', '2023-05-19 03:05:39', '2023-05-19 03:05:39');
INSERT INTO `lara_permissions` VALUES (65, 'master_masa_item delete', 'web', '2023-05-19 03:05:44', '2023-05-19 03:05:44');
INSERT INTO `lara_permissions` VALUES (66, 'master_item list', 'web', '2023-05-20 23:26:05', '2023-05-20 23:26:05');
INSERT INTO `lara_permissions` VALUES (67, 'master_item create', 'web', '2023-05-20 23:26:10', '2023-05-20 23:26:10');
INSERT INTO `lara_permissions` VALUES (68, 'master_item edit', 'web', '2023-05-20 23:26:15', '2023-05-20 23:26:15');
INSERT INTO `lara_permissions` VALUES (69, 'master_item delete', 'web', '2023-05-20 23:26:20', '2023-05-20 23:26:20');
INSERT INTO `lara_permissions` VALUES (70, 'master_produk list', 'web', '2023-05-21 23:45:31', '2023-05-21 23:45:31');
INSERT INTO `lara_permissions` VALUES (71, 'master_produk create', 'web', '2023-05-21 23:45:38', '2023-05-21 23:45:38');
INSERT INTO `lara_permissions` VALUES (72, 'master_produk edit', 'web', '2023-05-21 23:45:47', '2023-05-21 23:45:47');
INSERT INTO `lara_permissions` VALUES (73, 'master_produk delete', 'web', '2023-05-21 23:45:54', '2023-05-21 23:45:54');
INSERT INTO `lara_permissions` VALUES (74, 'bom list', 'web', '2023-05-24 01:16:48', '2023-05-24 01:16:48');
INSERT INTO `lara_permissions` VALUES (75, 'bom create', 'web', '2023-05-24 01:16:53', '2023-05-24 01:16:53');
INSERT INTO `lara_permissions` VALUES (76, 'bom edit', 'web', '2023-05-24 01:17:00', '2023-05-24 01:17:00');
INSERT INTO `lara_permissions` VALUES (77, 'bom delete', 'web', '2023-05-24 01:17:05', '2023-05-24 01:17:05');
INSERT INTO `lara_permissions` VALUES (78, 'approval_rnd_atasan_bom list', 'web', '2023-06-10 08:55:32', '2023-06-10 08:55:32');
INSERT INTO `lara_permissions` VALUES (79, 'approval_rnd_atasan_bom create', 'web', '2023-06-10 09:32:16', '2023-06-10 09:32:16');
INSERT INTO `lara_permissions` VALUES (80, 'approval_rnd_atasan_bom edit', 'web', '2023-06-10 09:32:22', '2023-06-10 09:32:22');
INSERT INTO `lara_permissions` VALUES (81, 'approval_rnd_atasan_bom delete', 'web', '2023-06-10 09:32:27', '2023-06-10 09:32:27');
INSERT INTO `lara_permissions` VALUES (82, 'production_plan list', 'web', '2023-06-14 01:19:18', '2023-06-14 01:19:18');
INSERT INTO `lara_permissions` VALUES (83, 'production_plan create', 'web', '2023-06-14 01:25:21', '2023-06-14 01:25:21');
INSERT INTO `lara_permissions` VALUES (84, 'production_plan edit', 'web', '2023-06-14 01:25:25', '2023-06-14 01:25:25');
INSERT INTO `lara_permissions` VALUES (85, 'production_plan delete', 'web', '2023-06-14 01:25:32', '2023-06-14 01:25:32');
INSERT INTO `lara_permissions` VALUES (86, 'master_mesin list', 'web', '2023-06-15 01:35:44', '2023-06-15 01:35:44');
INSERT INTO `lara_permissions` VALUES (87, 'master_mesin create', 'web', '2023-06-15 01:35:50', '2023-06-15 01:35:50');
INSERT INTO `lara_permissions` VALUES (88, 'master_mesin edit', 'web', '2023-06-15 01:35:56', '2023-06-15 01:35:56');
INSERT INTO `lara_permissions` VALUES (89, 'master_mesin delete', 'web', '2023-06-15 01:36:01', '2023-06-15 01:36:01');
INSERT INTO `lara_permissions` VALUES (90, 'master_stork list', 'web', '2023-06-15 01:36:17', '2023-06-15 01:36:38');
INSERT INTO `lara_permissions` VALUES (91, 'master_stork create', 'web', '2023-06-15 01:36:22', '2023-06-15 01:36:43');
INSERT INTO `lara_permissions` VALUES (92, 'master_stork edit', 'web', '2023-06-15 01:36:31', '2023-06-15 01:36:48');
INSERT INTO `lara_permissions` VALUES (93, 'master_stork delete', 'web', '2023-06-15 01:36:55', '2023-06-15 01:36:55');
INSERT INTO `lara_permissions` VALUES (94, 'master_line list', 'web', '2023-06-15 01:37:04', '2023-06-15 01:37:04');
INSERT INTO `lara_permissions` VALUES (95, 'master_line create', 'web', '2023-06-15 01:37:11', '2023-06-15 01:37:11');
INSERT INTO `lara_permissions` VALUES (96, 'master_line edit', 'web', '2023-06-15 01:37:25', '2023-06-15 01:37:25');
INSERT INTO `lara_permissions` VALUES (97, 'master_line delete', 'web', '2023-06-15 01:37:31', '2023-06-15 01:37:31');
INSERT INTO `lara_permissions` VALUES (98, 'master_palet list', 'web', '2023-06-15 01:37:41', '2023-06-15 01:37:56');
INSERT INTO `lara_permissions` VALUES (99, 'master_palet create', 'web', '2023-06-15 01:37:48', '2023-06-15 01:38:00');
INSERT INTO `lara_permissions` VALUES (100, 'master_palet edit', 'web', '2023-06-15 01:38:06', '2023-06-15 01:38:06');
INSERT INTO `lara_permissions` VALUES (101, 'master_palet delete', 'web', '2023-06-15 01:38:12', '2023-06-15 01:38:12');
INSERT INTO `lara_permissions` VALUES (102, 'master_warehouse_view list', 'web', '2023-07-02 18:44:44', '2023-07-02 18:44:44');
INSERT INTO `lara_permissions` VALUES (103, 'master_warehouse_view create', 'web', '2023-07-02 18:44:54', '2023-07-02 18:44:54');
INSERT INTO `lara_permissions` VALUES (104, 'master_warehouse_view edit', 'web', '2023-07-02 18:45:00', '2023-07-02 18:45:00');
INSERT INTO `lara_permissions` VALUES (105, 'master_warehouse_view delete', 'web', '2023-07-02 18:45:06', '2023-07-02 18:45:06');
INSERT INTO `lara_permissions` VALUES (106, 'approval_ppic_atasan list', 'web', '2023-07-03 00:38:42', '2023-07-03 00:38:42');
INSERT INTO `lara_permissions` VALUES (107, 'approval_ppic_atasan create', 'web', '2023-07-03 00:38:48', '2023-07-03 00:38:48');
INSERT INTO `lara_permissions` VALUES (108, 'approval_ppic_atasan edit', 'web', '2023-07-03 00:38:53', '2023-07-03 00:38:53');
INSERT INTO `lara_permissions` VALUES (109, 'approval_ppic_atasan delete', 'web', '2023-07-03 00:39:03', '2023-07-03 00:39:03');
INSERT INTO `lara_permissions` VALUES (110, 'req_bom list', 'web', '2023-07-25 19:49:14', '2023-07-25 19:49:14');
INSERT INTO `lara_permissions` VALUES (111, 'req_bom create', 'web', '2023-07-25 19:49:22', '2023-07-25 19:49:22');
INSERT INTO `lara_permissions` VALUES (112, 'req_bom edit', 'web', '2023-07-25 19:49:29', '2023-07-25 19:49:29');
INSERT INTO `lara_permissions` VALUES (113, 'req_bom delete', 'web', '2023-07-25 19:49:39', '2023-07-25 19:49:39');
INSERT INTO `lara_permissions` VALUES (114, 'req_bom_rnd_atasan list', 'web', '2023-08-01 00:06:44', '2023-08-01 00:06:44');
INSERT INTO `lara_permissions` VALUES (115, 'req_bom_rnd_atasan create', 'web', '2023-08-01 00:06:49', '2023-08-01 00:06:49');
INSERT INTO `lara_permissions` VALUES (116, 'req_bom_rnd_atasan edit', 'web', '2023-08-01 00:06:56', '2023-08-01 00:06:56');
INSERT INTO `lara_permissions` VALUES (117, 'req_bom_rnd_atasan delete', 'web', '2023-08-01 00:07:01', '2023-08-01 00:07:01');
INSERT INTO `lara_permissions` VALUES (118, 'req_bom_produksi_atasan list', 'web', '2023-08-01 00:07:19', '2023-08-01 00:07:19');
INSERT INTO `lara_permissions` VALUES (119, 'req_bom_produksi_atasan create', 'web', '2023-08-01 00:07:24', '2023-08-01 00:07:24');
INSERT INTO `lara_permissions` VALUES (120, 'req_bom_produksi_atasan edit', 'web', '2023-08-01 00:07:29', '2023-08-01 00:07:29');
INSERT INTO `lara_permissions` VALUES (121, 'req_bom_produksi_atasan delete', 'web', '2023-08-01 00:07:34', '2023-08-01 00:07:34');
INSERT INTO `lara_permissions` VALUES (122, 'job_costing list', 'web', '2023-08-13 20:39:58', '2023-08-13 20:39:58');
INSERT INTO `lara_permissions` VALUES (123, 'job_costing create', 'web', '2023-08-13 20:40:04', '2023-08-13 20:40:04');
INSERT INTO `lara_permissions` VALUES (124, 'job_costing edit', 'web', '2023-08-13 20:40:11', '2023-08-13 20:40:11');
INSERT INTO `lara_permissions` VALUES (125, 'job_costing delete', 'web', '2023-08-13 20:40:18', '2023-08-13 20:40:18');
INSERT INTO `lara_permissions` VALUES (126, 'master_sequence list', 'web', '2023-08-29 01:59:09', '2023-08-29 01:59:09');
INSERT INTO `lara_permissions` VALUES (127, 'master_sequence create', 'web', '2023-08-29 01:59:15', '2023-08-29 01:59:15');
INSERT INTO `lara_permissions` VALUES (128, 'roll_over list', 'web', '2023-09-14 00:59:13', '2023-09-14 00:59:13');
INSERT INTO `lara_permissions` VALUES (129, 'roll_over create', 'web', '2023-09-14 00:59:21', '2023-09-14 00:59:21');
INSERT INTO `lara_permissions` VALUES (130, 'roll_over edit', 'web', '2023-09-14 00:59:27', '2023-09-14 00:59:27');
INSERT INTO `lara_permissions` VALUES (131, 'roll_over delete', 'web', '2023-09-14 00:59:34', '2023-09-14 00:59:34');
INSERT INTO `lara_permissions` VALUES (132, 'master_expense list', 'web', '2023-09-20 18:38:45', '2023-09-20 18:38:45');
INSERT INTO `lara_permissions` VALUES (133, 'master_expense create', 'web', '2023-09-20 18:39:00', '2023-09-20 18:39:00');
INSERT INTO `lara_permissions` VALUES (134, 'master_expense edit', 'web', '2023-09-20 18:39:08', '2023-09-20 18:39:08');
INSERT INTO `lara_permissions` VALUES (135, 'master_expense delete', 'web', '2023-09-20 18:39:14', '2023-09-20 18:39:14');
INSERT INTO `lara_permissions` VALUES (136, 'bom_map list', 'web', '2023-10-05 00:54:12', '2023-10-05 00:54:12');
INSERT INTO `lara_permissions` VALUES (137, 'bom_map create', 'web', '2023-10-05 00:54:25', '2023-10-05 00:54:25');
INSERT INTO `lara_permissions` VALUES (138, 'bom_map edit', 'web', '2023-10-05 00:55:04', '2023-10-05 00:55:04');
INSERT INTO `lara_permissions` VALUES (139, 'bom_map delete', 'web', '2023-10-05 00:55:13', '2023-10-05 00:55:13');
INSERT INTO `lara_permissions` VALUES (140, 'job_costing_product list', 'web', '2023-10-05 18:53:07', '2023-10-05 18:53:07');
INSERT INTO `lara_permissions` VALUES (141, 'job_costing_product create', 'web', '2023-10-05 18:53:13', '2023-10-05 18:53:13');
INSERT INTO `lara_permissions` VALUES (142, 'job_costing_product edit', 'web', '2023-10-05 18:53:19', '2023-10-05 18:53:24');
INSERT INTO `lara_permissions` VALUES (143, 'job_costing_product delete', 'web', '2023-10-05 18:53:30', '2023-10-05 18:53:30');
INSERT INTO `lara_permissions` VALUES (144, 'roll_over_produk list', 'web', '2023-10-09 18:17:09', '2023-10-09 18:17:09');
INSERT INTO `lara_permissions` VALUES (145, 'roll_over_produk create', 'web', '2023-10-09 18:17:15', '2023-10-09 18:17:15');
INSERT INTO `lara_permissions` VALUES (146, 'roll_over_produk edit', 'web', '2023-10-09 18:17:21', '2023-10-09 18:17:21');
INSERT INTO `lara_permissions` VALUES (147, 'roll_over_produk delete', 'web', '2023-10-09 18:17:27', '2023-10-09 18:17:27');
INSERT INTO `lara_permissions` VALUES (148, 'qc_dashboard list', 'web', '2023-10-20 02:31:58', '2023-10-20 02:31:58');
INSERT INTO `lara_permissions` VALUES (149, 'qc_dashboard create', 'web', '2023-10-20 02:32:04', '2023-10-20 02:32:04');
INSERT INTO `lara_permissions` VALUES (150, 'qc_dashboard edit', 'web', '2023-10-20 02:32:10', '2023-10-20 02:32:10');
INSERT INTO `lara_permissions` VALUES (151, 'qc_dashboard delete', 'web', '2023-10-20 02:32:16', '2023-10-20 02:32:16');
INSERT INTO `lara_permissions` VALUES (152, 'qc_tf list', 'web', '2023-10-25 21:45:29', '2023-10-25 21:45:29');
INSERT INTO `lara_permissions` VALUES (153, 'qc_tf create', 'web', '2023-10-25 21:45:37', '2023-10-25 21:45:37');
INSERT INTO `lara_permissions` VALUES (154, 'qc_tf edit', 'web', '2023-10-25 21:45:43', '2023-10-25 21:45:43');
INSERT INTO `lara_permissions` VALUES (155, 'qc_tf delete', 'web', '2023-10-25 21:45:49', '2023-10-25 21:45:49');
INSERT INTO `lara_permissions` VALUES (157, 'qc_dashboard transfer', 'web', '2023-11-06 01:15:54', '2023-11-06 01:15:54');
INSERT INTO `lara_permissions` VALUES (158, 'qc_dashboard manage', 'web', '2023-11-06 01:21:56', '2023-11-06 01:21:56');
INSERT INTO `lara_permissions` VALUES (159, 'invoice list', 'web', '2023-11-08 23:47:08', '2023-11-08 23:47:08');
INSERT INTO `lara_permissions` VALUES (160, 'invoice create', 'web', '2023-11-08 23:47:14', '2023-11-08 23:47:14');
INSERT INTO `lara_permissions` VALUES (161, 'invoice edit', 'web', '2023-11-08 23:47:19', '2023-11-08 23:47:19');
INSERT INTO `lara_permissions` VALUES (162, 'invoice delete', 'web', '2023-11-08 23:47:25', '2023-11-08 23:47:25');
INSERT INTO `lara_permissions` VALUES (163, 'qc_karantina list', 'web', '2023-11-22 02:58:13', '2023-11-22 02:58:13');
INSERT INTO `lara_permissions` VALUES (164, 'qc_karantina create', 'web', '2023-11-22 02:58:22', '2023-11-22 02:58:22');
INSERT INTO `lara_permissions` VALUES (165, 'qc_karantina edit', 'web', '2023-11-22 02:58:27', '2023-11-22 02:58:27');
INSERT INTO `lara_permissions` VALUES (166, 'qc_karantina delete', 'web', '2023-11-22 02:58:35', '2023-11-22 02:58:35');
INSERT INTO `lara_permissions` VALUES (167, 'qc_karantina_adjustment_approve', 'web', '2023-12-13 20:35:50', '2023-12-13 20:35:50');
INSERT INTO `lara_permissions` VALUES (168, 'qc_karantina_adjustment_close', 'web', '2023-12-13 20:35:59', '2023-12-13 20:35:59');
INSERT INTO `lara_permissions` VALUES (169, 'iptn_in list', 'web', '2023-12-18 20:30:39', '2023-12-18 20:30:39');
INSERT INTO `lara_permissions` VALUES (170, 'iptn_in create', 'web', '2023-12-19 20:55:47', '2023-12-19 20:55:47');
INSERT INTO `lara_permissions` VALUES (171, 'iptn_in edit', 'web', '2023-12-19 20:55:53', '2023-12-19 20:55:53');
INSERT INTO `lara_permissions` VALUES (172, 'iptn_in delete', 'web', '2023-12-19 20:55:58', '2023-12-19 20:55:58');
INSERT INTO `lara_permissions` VALUES (173, 'qr_scan list', 'web', '2024-01-08 01:17:21', '2024-01-08 01:17:21');
INSERT INTO `lara_permissions` VALUES (174, 'qr_scan create', 'web', '2024-01-08 01:17:26', '2024-01-08 01:17:26');
INSERT INTO `lara_permissions` VALUES (175, 'qr_scan edit', 'web', '2024-01-08 01:17:31', '2024-01-08 01:17:31');
INSERT INTO `lara_permissions` VALUES (176, 'qr_scan delete', 'web', '2024-01-08 01:17:36', '2024-01-08 01:17:36');
INSERT INTO `lara_permissions` VALUES (177, 'qr_scan_stuffing list', 'web', '2024-02-16 00:40:12', '2024-02-16 00:40:12');
INSERT INTO `lara_permissions` VALUES (178, 'qr_scan_stuffing create', 'web', '2024-02-16 00:40:19', '2024-02-16 00:40:19');
INSERT INTO `lara_permissions` VALUES (179, 'qr_scan_stuffing edit', 'web', '2024-02-16 00:40:24', '2024-02-16 00:40:24');
INSERT INTO `lara_permissions` VALUES (180, 'qr_scan_stuffing delete', 'web', '2024-02-16 00:40:30', '2024-02-16 00:40:30');
INSERT INTO `lara_permissions` VALUES (181, 'sirkuler_create list', 'web', '2024-03-04 00:04:10', '2024-03-04 00:04:10');
INSERT INTO `lara_permissions` VALUES (182, 'sirkuler_tracking list', 'web', '2024-03-04 00:04:18', '2024-03-04 00:04:18');
INSERT INTO `lara_permissions` VALUES (183, 'sirkuler_create create', 'web', '2024-03-07 18:55:05', '2024-03-07 18:55:20');
INSERT INTO `lara_permissions` VALUES (184, 'sirkuler_create edit', 'web', '2024-03-07 18:55:26', '2024-03-07 18:55:26');
INSERT INTO `lara_permissions` VALUES (185, 'sirkuler_create delete', 'web', '2024-03-07 18:55:31', '2024-03-07 18:55:31');
INSERT INTO `lara_permissions` VALUES (186, 'approval_sirkuler list', 'web', '2024-03-18 22:08:53', '2024-03-18 22:08:53');
INSERT INTO `lara_permissions` VALUES (187, 'approval_sirkuler create', 'web', '2024-03-18 22:08:59', '2024-03-18 22:08:59');
INSERT INTO `lara_permissions` VALUES (188, 'approval_sirkuler edit', 'web', '2024-03-18 22:09:03', '2024-03-18 22:09:03');
INSERT INTO `lara_permissions` VALUES (189, 'approval_sirkuler delete', 'web', '2024-03-19 21:53:32', '2024-03-19 21:53:32');
INSERT INTO `lara_permissions` VALUES (190, 'sirkuler_create_head_legal list', 'web', '2024-03-20 21:52:29', '2024-03-20 21:52:29');
INSERT INTO `lara_permissions` VALUES (191, 'sirkuler_create_head_legal create', 'web', '2024-03-20 21:52:34', '2024-03-20 21:52:34');
INSERT INTO `lara_permissions` VALUES (192, 'sirkuler_create_head_legal edit', 'web', '2024-03-20 21:52:39', '2024-03-20 21:52:39');
INSERT INTO `lara_permissions` VALUES (193, 'sirkuler_create_head_legal delete', 'web', '2024-03-20 21:52:45', '2024-03-20 21:52:45');
INSERT INTO `lara_permissions` VALUES (194, 'master_pihak_lain list', 'web', '2024-06-09 18:57:54', '2024-06-09 18:57:54');
INSERT INTO `lara_permissions` VALUES (195, 'master_pihak_lain create', 'web', '2024-06-09 18:58:00', '2024-06-09 18:58:00');
INSERT INTO `lara_permissions` VALUES (196, 'master_pihak_lain edit', 'web', '2024-06-09 18:58:06', '2024-06-09 18:58:06');
INSERT INTO `lara_permissions` VALUES (197, 'master_pihak_lain delete', 'web', '2024-06-09 18:58:12', '2024-06-09 18:58:12');
INSERT INTO `lara_permissions` VALUES (198, 'master_type_pihak_lain list', 'web', '2024-06-12 19:56:29', '2024-06-12 19:56:29');
INSERT INTO `lara_permissions` VALUES (199, 'master_type_pihak_lain create', 'web', '2024-06-12 19:56:33', '2024-06-12 19:56:33');
INSERT INTO `lara_permissions` VALUES (200, 'master_type_pihak_lain edit', 'web', '2024-06-12 19:56:39', '2024-06-12 19:56:39');
INSERT INTO `lara_permissions` VALUES (201, 'master_type_pihak_lain delete', 'web', '2024-06-12 19:56:45', '2024-06-12 19:56:45');

-- ----------------------------
-- Table structure for lara_roles
-- ----------------------------
DROP TABLE IF EXISTS `lara_roles`;
CREATE TABLE `lara_roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_roles
-- ----------------------------
INSERT INTO `lara_roles` VALUES (1, 'writer', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_roles` VALUES (2, 'admin', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_roles` VALUES (3, 'super-admin', 'web', '2023-03-29 06:39:34', '2023-03-29 06:39:34');
INSERT INTO `lara_roles` VALUES (4, 'account_payable', 'web', '2023-11-15 01:48:48', '2023-11-15 01:48:48');
INSERT INTO `lara_roles` VALUES (5, 'accounting', 'web', '2023-11-15 01:48:53', '2023-11-15 01:48:53');
INSERT INTO `lara_roles` VALUES (6, 'legal', 'web', '2024-03-20 00:55:42', '2024-03-20 00:55:42');
INSERT INTO `lara_roles` VALUES (7, 'atasan_legal', 'web', '2024-03-27 21:22:35', '2024-03-27 21:22:35');

-- ----------------------------
-- Table structure for lara_sirkuler_master_jenis_dokumen
-- ----------------------------
DROP TABLE IF EXISTS `lara_sirkuler_master_jenis_dokumen`;
CREATE TABLE `lara_sirkuler_master_jenis_dokumen`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_bin NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lara_sirkuler_master_jenis_dokumen
-- ----------------------------
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (1, 'PKS', 1, 1, '2024-05-27 07:10:47', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (2, 'PSM', 1, 1, '2024-05-27 07:10:53', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (3, 'MOU', 1, 1, '2024-05-27 07:11:01', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (4, 'POA', 1, 1, '2024-05-27 07:11:08', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (5, 'PPP', 1, 1, '2024-05-27 07:11:23', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (6, 'LO', 1, 1, '2024-05-27 07:11:32', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (7, 'RQL', 1, 1, '2024-05-27 07:11:52', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (8, 'RL', 1, 1, '2024-05-27 07:12:01', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (9, 'SL', 1, 1, '2024-05-27 07:12:14', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (10, 'AL', 1, 1, '2024-05-27 07:12:23', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (11, 'NL', 1, 1, '2024-05-27 07:12:32', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (12, 'SP', 1, 1, '2024-05-27 07:12:40', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (13, 'LOI', 1, 1, '2024-05-27 07:12:47', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (14, 'SK', 1, 1, '2024-05-27 07:12:54', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (15, 'IL', 1, 1, '2024-05-27 07:13:02', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (16, 'SOMASI', 1, 1, '2024-05-27 07:13:10', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (17, 'NDA', 1, 1, '2024-05-27 07:13:16', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (18, 'SPK', 1, 1, '2024-05-27 07:13:26', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (19, 'PJB', 1, 1, '2024-05-27 07:13:32', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (20, 'PPJB', 1, 1, '2024-05-27 07:13:41', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (21, 'GL', 1, 1, '2024-05-27 07:13:48', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (22, 'OL', 1, 1, '2024-05-27 07:13:55', NULL);
INSERT INTO `lara_sirkuler_master_jenis_dokumen` VALUES (23, 'BAST', 1, 1, '2024-05-27 07:14:03', NULL);

-- ----------------------------
-- Table structure for lara_users
-- ----------------------------
DROP TABLE IF EXISTS `lara_users`;
CREATE TABLE `lara_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nip` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_active` tinyint NULL DEFAULT NULL,
  `company_id` bigint NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of lara_users
-- ----------------------------
INSERT INTO `lara_users` VALUES (1, '101210005', 'Achmad Rizky S', 'achmad.rizky@pangansari.co.id', '2024-04-26 14:49:03', '$2y$12$FbJ.HUMdQD4nf0PDBjUeXensXPrfLR1VZtDzU/R/aEraFIVtIIz16', NULL, 1, 1, '2024-04-26 14:49:10', NULL, 1);
INSERT INTO `lara_users` VALUES (2, '101210006', 'Syahril Hidayat', 'syahril@example.com', NULL, '$2y$12$FbJ.HUMdQD4nf0PDBjUeXensXPrfLR1VZtDzU/R/aEraFIVtIIz16', NULL, 1, 1, '2024-05-03 01:53:08', '2024-05-03 01:53:08', 1);
INSERT INTO `lara_users` VALUES (3, '101210001', 'Rini Windyastuti', 'rini.windyastuti@pangansari.co.id', NULL, '$2y$12$FbJ.HUMdQD4nf0PDBjUeXensXPrfLR1VZtDzU/R/aEraFIVtIIz16', NULL, 1, 1, '2024-05-24 19:17:57', NULL, 1);
INSERT INTO `lara_users` VALUES (4, '101210002', 'Nurul Azizah', 'noerul.azizah@pangansari.co.id', NULL, '$2y$12$FbJ.HUMdQD4nf0PDBjUeXensXPrfLR1VZtDzU/R/aEraFIVtIIz16', NULL, 1, 1, NULL, NULL, 1);

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE = InnoDB CHARACTER SET = armscii8 COLLATE = armscii8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('ZxREKhXLDgBZWKoB675Cxe6hktSEQhKD8TmaXTzO', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXhCS05OSXhRd1czeDJFRzhkNzhmNXdWOGtkclczUnZFeVBibUROUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1719846873);
INSERT INTO `sessions` VALUES ('fLHMoMgmq1kitvgwByCQZTkykpMTtLQLqgMLIEg0', NULL, '192.168.43.30', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWhUVjhMYk9KempERTJYV1JWT2hQQTkydTlQOWpWcnRUWGt5TW9mWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjQzLjMwOjgwODMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1719846951);
INSERT INTO `sessions` VALUES ('GWjTnuGlu7Z0LMLwdsFv2UL1hqmzSmMBaJrXPauJ', 2, '192.168.117.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWlpiZlNaVlhkNkJ5dGNxc05MdFd5R1AwZVJ4a1hNUmRHakFONDZudiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly8xOTIuMTY4LjExNy41MDo4MDgzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1719884782);

SET FOREIGN_KEY_CHECKS = 1;
