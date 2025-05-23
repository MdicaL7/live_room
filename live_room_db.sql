/*
 Navicat Premium Dump SQL

 Source Server         : mdica
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : live_room_db

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 23/05/2025 22:45:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `room_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_room_id` (`room_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for live_rooms
-- ----------------------------
DROP TABLE IF EXISTS `live_rooms`;
CREATE TABLE `live_rooms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `status` tinyint DEFAULT '2',
  `replay_url` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cover` varchar(255) DEFAULT NULL,
  `anchor` varchar(255) DEFAULT NULL COMMENT '直播间主播',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of live_rooms
-- ----------------------------
BEGIN;
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (1, 'Python基础入门', '零基础入门Python，适合新手', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/python_base.jpg', '张老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (2, 'Go语言进阶', 'Go语言实战开发与性能优化', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/go_advanced.jpg', '李工');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (3, 'Web前端项目实战', '前端Vue、React主流框架对比', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/frontend.jpg', '王老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (4, 'AI基础与应用', '人工智能基础知识及应用场景', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/ai_base.jpg', '赵博士');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (5, '大数据入门', '大数据生态与Hadoop实战', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/bigdata.jpg', '刘老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (6, '算法刷题训练营', '数据结构与算法专项突破', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/algorithm.jpg', '陈老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (7, '产品经理成长课', '需求分析到产品迭代实战案例', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/pm.jpg', '吴老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (8, '云计算与容器', 'Docker、K8S核心原理与实战', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/cloud.jpg', '钱老师');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (9, '数据库设计实战', 'MySQL、MongoDB数据建模与优化', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/database.jpg', '孙工');
INSERT INTO `live_rooms` (`id`, `title`, `description`, `status`, `replay_url`, `created_at`, `updated_at`, `cover`, `anchor`) VALUES (10, '直播运营技巧', '直播间搭建、推广、复盘一条龙', 2, '/videos/1.mp4', '2025-05-22 10:53:33', '2025-05-23 14:34:22', '/covers/live_ops.jpg', '直播小助手');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
