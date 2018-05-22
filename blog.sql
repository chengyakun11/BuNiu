/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 22/05/2018 23:19:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, '慢生活', '2018-04-18 17:32:16');
INSERT INTO `category` VALUES (2, '碎言碎语', '2018-04-18 17:32:22');
INSERT INTO `category` VALUES (3, '技术分享', '2018-04-18 17:32:34');
COMMIT;

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `topic_id` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_topic` (`user_id`,`topic_id`),
  KEY `index_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of collect
-- ----------------------------
BEGIN;
INSERT INTO `collect` VALUES (1, 4, 35, '2018-04-18 07:57:37');
COMMIT;

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建者id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL,
  `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '创建者用户名',
  `like_num` int(11) NOT NULL DEFAULT '0' COMMENT '赞个数',
  `collect_num` int(11) NOT NULL DEFAULT '0' COMMENT '收藏数',
  `reply_num` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `follow` int(11) NOT NULL DEFAULT '0' COMMENT '关注数',
  `view_num` int(11) NOT NULL DEFAULT '0' COMMENT '阅读数',
  `last_reply_id` int(11) NOT NULL DEFAULT '0' COMMENT '最后回复者id',
  `last_reply_name` varchar(255) NOT NULL DEFAULT '' COMMENT '最后回复者用户名',
  `last_reply_time` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属类',
  `is_good` int(11) NOT NULL DEFAULT '0' COMMENT '1精华帖，0普通帖',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `title` (`title`,`content`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of topic
-- ----------------------------
BEGIN;
INSERT INTO `topic` VALUES (40, '我是分享的标题我是分享的标题', '我是分享的内容我是分享的内容我是分我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是我是分享的内容我是分享的内容我是享的内容我是分享的内容我是分享的内容 ![/4744178968136478712.png](/avatar/4744178968136478712.png) ', 4, '2018-04-18 00:02:48', '2018-04-18 12:52:40', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 3, 0);
INSERT INTO `topic` VALUES (41, '慢生活1', '慢生活1慢生活1慢生活1慢生活1慢生活1', 4, '2018-04-18 17:35:19', '2018-04-18 17:35:22', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
INSERT INTO `topic` VALUES (42, '慢生活2', '慢生活2慢生活2慢生活2慢生活2慢生活2慢生活2', 4, '2018-04-18 17:36:06', '2018-04-18 17:36:35', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
INSERT INTO `topic` VALUES (43, '慢生活3', '慢生活3慢生活3慢生活3慢生活3慢生活3慢生活3慢生活3', 4, '2018-04-18 17:36:46', '2018-04-18 17:37:09', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
INSERT INTO `topic` VALUES (44, '碎言碎语1', '碎言碎语1碎言碎语1碎言碎语1碎言碎语1碎言碎语1碎言碎语1', 4, '2018-04-18 17:37:25', '2018-04-18 17:38:36', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 2, 0);
INSERT INTO `topic` VALUES (45, '碎言碎语2', '碎言碎语2碎言碎语2碎言碎语2碎言碎语2碎言碎语2碎言碎语2', 4, '2018-04-18 17:37:29', '2018-04-18 17:38:38', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 2, 0);
INSERT INTO `topic` VALUES (46, '碎言碎语3333555', '碎言碎语3碎言碎语3碎言碎语3碎言碎语3碎言碎语3碎言碎语3', 4, '2018-04-18 17:37:47', '2018-04-18 17:38:41', 'chengyakun11', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 2, 0);
INSERT INTO `topic` VALUES (47, '技术分享2技术分享2', '技术分享2技术分享2技术分享2技术分享2技术分享2技术分享2技术分享2技术分享2', 0, '2018-04-19 13:59:55', '2018-04-19 06:00:32', '', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 2, 0);
INSERT INTO `topic` VALUES (48, '全栈的理解', '很多人不明白，其实全栈的真正意义并不在于多学了几门技术，而在于说，你拥有了将一个想法完整的转化为一个产品的能力。\n\n这种能力让你从一个不能脱离生产线的螺丝钉、不能离开公司独立生存的雇员，变成了一个对自己的工作，对自己的生活，对自己的事业拥有选择权的一个人。\n\n你当然可以到大厂里面去打工，因为挣钱快嘛，但是当你不开心的时候，不想要这种生活的时候，可以自己开公司，可以自己做软件卖；当你有一些非常好的想法的时候，你不用去说服投资人和找帮你补前端或者后端工作的小伙伴，只需要用自己空闲的时间，就可以慢慢的把它给做出来。\n\n当你创业的时候，你不用天天担心，技术部门里面某一个单点的程序员突然离职（创业公司里非常常见），因为你知道最差的情况下，你是可以自己去把这个地方的东西给做掉的。大不了边熬夜边招人呗。\n\n这种控制力非常棒。\n\n我也不是在忽悠说，你现在就要去学一个什么全栈的课程，而是说你可以在自己现有技术栈的基础之上，以很低的成本去补全自己的这种能力。\n\njs的把node和混合app搞搞，android的顺便用java搞定下后端，php的同学补下小程序开发。再多做几个产品练练手找找感觉，这种能力就慢慢出来了。', 0, '2018-04-19 18:01:08', NULL, '', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
INSERT INTO `topic` VALUES (49, '关于产品', '[cp]做产品是件挺难的事儿，所以改需求就不可避免了。\n\n但是，很多产品经理，在原型完成之后没有自己多去用，有一些显而易见的流程错误和逻辑错误明明是可以在这个阶段就被发现的，却因为产品经理的偷懒直接交给开发。等修改上线以后或者上线之前，再回来改。\n\n这样不仅浪费了公司的开发资源，使整个项目进度变得更加的缓慢，还不断的在向开发强化一个思想，就是“咱们公司的产品经理是傻叉”。\n\n正如有些同学所说，要求产品经理不改需求，就像要求程序员不写bug的一样，但是没有一个程序员是以写bug为荣的，而不少的产品经理却不以乱改需求为耻。还要跑去跟开发说这个需求，反正是改不完的，你不用太着急，做程序员嘛，最重要的是开心。这跟往地上扔纸，告诉环卫工人说如果不是我丢的东西，你都会没工作，有什么区别。\n\n我经常跟我产品团队的同学说开发是产品的下游，工作量是会放大的。司机一滴酒，行人两行泪，产品手一抖，开发忙一宿。\n\n每回当你们看见开发的同事加班加到半夜的时候，都应该想一想自己提的需求变更是不是真的不可避免的。当你真的问心无愧的时候，你不但是一个好同事，也成了一个好产品经理。[/cp]\n', 0, '2018-04-19 18:03:48', NULL, '', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
INSERT INTO `topic` VALUES (50, '来自资深UI设计师的建议', '【来自资深UI设计师的建议】事有轻重缓急，花里胡哨的没必要，也不要硬去颠覆那些约定俗成的设计习惯；设计要模版化，设计的一致性和高效是相辅相成的；设计没那么重要，关键是你的产品能提供什么价值；产品没上线都是空谈\n', 0, '2018-04-20 23:48:50', NULL, '', 0, 0, 0, 0, 0, 0, '', '2000-01-01 00:00:00', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(500) NOT NULL DEFAULT '' COMMENT '头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `city` varchar(11) NOT NULL DEFAULT '',
  `website` varchar(255) NOT NULL DEFAULT '',
  `company` varchar(100) NOT NULL DEFAULT '',
  `sign` varchar(255) NOT NULL DEFAULT '',
  `github` varchar(30) NOT NULL DEFAULT '',
  `github_name` varchar(30) NOT NULL DEFAULT '',
  `is_verify` int(2) DEFAULT '0',
  `github_id` int(11) DEFAULT NULL,
  `email` varchar(200) NOT NULL DEFAULT '',
  `email_public` int(11) NOT NULL DEFAULT '0' COMMENT '1公开，0私密',
  `is_admin` int(11) DEFAULT '0' COMMENT '1管理员，0普通用户',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`),
  UNIQUE KEY `unique_email` (`email`),
  UNIQUE KEY `unique_github_id` (`github_id`),
  FULLTEXT KEY `username` (`username`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (3, 'kent', '$2y$06$cFf2cFf2cFf2cFf2cFf2c.d8x8z1bziIBZaQju4BoJhj8531NIou.', '', '2018-04-17 06:59:28', '', '', '', '', '', '', 0, NULL, '', 0, 0);
INSERT INTO `user` VALUES (4, 'chengyakun11', '$2y$06$cFf2cFf2cFf2cFf2cFf2c.HRjwYPCaY6Tj8EQhggDY97h1WZye6yq', '4744178611647541586.jpg', '2018-04-17 08:25:45', '', '', '', '', '', 'chengyakun11', 0, 2689031, 'chengyakun11@163.com', 0, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
