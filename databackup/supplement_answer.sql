/*
Navicat MySQL Data Transfer

Source Server         : xuedu
Source Server Version : 50614
Source Host           : 121.40.50.245:33063
Source Database       : xuedu

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2015-08-03 07:08:35
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `supplement_answer`
-- ----------------------------
DROP TABLE IF EXISTS `supplement_answer`;
CREATE TABLE `supplement_answer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `INSERT_DATETIME` datetime DEFAULT NULL,
  `UPDATE_DATETIME` datetime DEFAULT NULL,
  `ANSWER_ID` int(11) DEFAULT NULL,
  `FANS_NAME` varchar(100) DEFAULT NULL,
  `ANSWER` varchar(1000) DEFAULT NULL,
  `IS_ACTIVE` int(11) DEFAULT '1',
  `IS_APPROVED` int(11) DEFAULT '0',
  `TITLE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supplement_answer
-- ----------------------------
INSERT INTO `supplement_answer` VALUES ('1', '2015-08-02 10:58:13', '2015-08-02 10:58:13', '169', '二狗子', '好吧。。。', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('2', '2015-08-02 11:45:26', '2015-08-02 11:45:26', '203', '溜肝尖儿', '每次都看成红旗机床厂里，老薛的扮演者。', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('3', '2015-08-02 12:02:27', '2015-08-02 12:02:27', '50', '溜肝尖儿', '自己在家里宴请朋友的时候，嘿这松花蛋往桌子上一放，来宾都拍巴掌，切！的！漂！亮！Beautiful！人民大会堂的厨子～', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('4', '2015-08-02 12:39:14', '2015-08-02 12:39:14', '139', '五花肉', '记得有一期节目李老师是说：“胖子也当了那么多年了，好处也尝过坏处也尝过，所以现在想要换一种生活方式。”', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('5', '2015-08-02 12:51:23', '2015-08-02 12:51:23', '84', '土可土', '英文名Thunder Sucker', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('6', '2015-08-02 13:01:02', '2015-08-02 13:01:02', '42', '锤子', '江湖传闻是优斯迪吧电台的美工', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('7', '2015-08-02 13:04:20', '2015-08-02 13:04:20', '82', '热心听众', '薛老师曰，成了的还叫初恋吗？', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('8', '2015-08-02 13:09:33', '2015-08-02 13:09:33', '0', '锤子', '后母后', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('9', '2015-08-02 13:09:40', '2015-08-02 13:09:40', '170', 'Patrick小白', '而且是一种国家保护动物！', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('10', '2015-08-02 13:17:00', '2015-08-02 13:17:00', '139', '小李', '想在密云水库吃鱼的时候流眼泪', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('11', '2015-08-02 13:19:12', '2015-08-02 13:19:12', '139', 'Slim Pillow', '高血压。', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('12', '2015-08-02 13:20:53', '2015-08-02 13:20:53', '139', '薛李cp粉', '撕不起了', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('13', '2015-08-02 13:29:15', '2015-08-02 13:29:15', '261', '薛李cp粉', '香港岛还是算了吧 嘉诚在那呢', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('14', '2015-08-02 13:30:51', '2015-08-02 13:30:51', '139', '迪吧僵尸粉', '夏天来了要脱了，要有尊严', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('15', '2015-08-02 13:31:44', '2015-08-02 13:31:44', '291', '金帅安', '抽完漂亮', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('16', '2015-08-02 13:32:15', '2015-08-02 13:32:15', '231', '大珍妮', '甜味儿？辣味儿？蒜味儿？香味儿？', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('17', '2015-08-02 13:33:24', '2015-08-02 13:33:24', '46', '小李', '祛痘先锋', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('18', '2015-08-02 13:37:52', '2015-08-02 13:37:52', '46', '曼秀雷墩', '曼秀雷墩代言人，假以时日，你会看到。', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('19', '2015-08-02 13:37:54', '2015-08-02 13:37:54', '4', '小李', '在斯文描绘的世界中经常由薛科长或秦工扮演', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('20', '2015-08-02 13:41:34', '2015-08-02 13:41:34', '291', '小李', '学的过程中横眉冷对老北京大妈：“我就抽！”', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('21', '2015-08-02 13:43:06', '2015-08-02 13:43:06', '292', '小李', '羽，抢篮板切！\n上篮的时候裤子掉了', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('22', '2015-08-02 13:45:27', '2015-08-02 13:45:27', '186', '大珍妮', '完全就是维笑多啊〜', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('23', '2015-08-02 13:49:22', '2015-08-02 13:49:22', '0', '并不重要', '薛老师真的不是', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('24', '2015-08-02 13:50:33', '2015-08-02 13:50:33', '183', 'Vince', '彩盖儿的.', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('25', '2015-08-02 14:01:57', '2015-08-02 14:01:57', '84', '小李', '拍黄瓜部落的死对头', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('26', '2015-08-02 14:06:52', '2015-08-02 14:06:52', '62', '我是谁不重要 和谐社会最重要', '青春永驻不老童颜的帆儿哥', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('27', '2015-08-02 14:09:22', '2015-08-02 14:09:22', '291', 'pighd', '抽烟好想听音乐', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('28', '2015-08-02 14:09:53', '2015-08-02 14:09:53', '18', '看风景的人', '李斯文的夫人', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('29', '2015-08-02 14:10:14', '2015-08-02 14:10:14', '188', '白莲花', '号服，大胡子，220斤 MChammer样的bling', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('30', '2015-08-02 14:12:50', '2015-08-02 14:12:50', '231', 'pighd', '李斯文：你 你什么意思？？！', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('31', '2015-08-02 14:14:49', '2015-08-02 14:14:49', '245', '小李', '詹姆斯·盼盼，脖子上挂一金牌', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('32', '2015-08-02 14:19:34', '2015-08-02 14:19:34', '245', 'pighd', '梁！朝！盼！ （李斯文:。。。听着真农民）', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('33', '2015-08-02 14:25:35', '2015-08-02 14:25:35', '200', 'pighd', '卧槽你丫干嘛呢 太傻逼简直了 冒血了已经 呲血了呲血了 你丫怎么这么说话呢 卧槽你丫傻逼了吧你 滚蛋滚蛋蛋滚蛋', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('34', '2015-08-02 14:31:10', '2015-08-02 14:31:10', '231', '大珍妮', '薛：我、我我没什么意思', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('35', '2015-08-02 14:43:59', '2015-08-02 14:43:59', '300', '小李', '藤井莉娜？', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('36', '2015-08-02 14:49:34', '2015-08-02 14:49:34', '63', '汪汪', '最后完全就是两块肉在上面挂着', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('37', '2015-08-02 15:04:02', '2015-08-02 15:04:02', '25', '薛老师脑残粉', '必须的', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('38', '2015-08-02 15:13:35', '2015-08-02 15:13:35', '323', '盖饭', '世界观、人生观和价值观还不是很成熟……', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('39', '2015-08-02 15:16:09', '2015-08-02 15:16:09', '0', '一吃肉根本停不下来少女', '紫色牙床是最魅惑的人体器官', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('40', '2015-08-02 16:04:14', '2015-08-02 16:04:14', '27', '汪汪', '薛优雅的师弟 （此处播放和三之歌', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('41', '2015-08-02 16:09:32', '2015-08-02 16:09:32', '136', '马外外', '掉歌厅里了', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('42', '2015-08-02 16:12:35', '2015-08-02 16:12:35', '322', '马外外', '北京大爷：彪zei ！！！     \n胡建大爷：苏胖！胖望的盼！', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('43', '2015-08-02 16:41:23', '2015-08-02 16:41:23', '323', '奔跑的自行车', '知音看的少', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('44', '2015-08-02 16:44:25', '2015-08-02 16:44:25', '129', '阿亮', '东北的一种木头，可做家具。', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('45', '2015-08-02 17:03:49', '2015-08-02 17:03:49', '291', '阿亮', '抽烟抢劫小学生，抽烟胸口碎大石，抽烟少林铁档功', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('46', '2015-08-02 17:21:14', '2015-08-02 17:21:14', '18', 'JY姐姐', '朝鲜名媛', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('47', '2015-08-02 17:28:58', '2015-08-02 17:28:58', '29', '斯文后宫团三道杠儿', '组团生够格儿么！', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('48', '2015-08-02 17:30:29', '2015-08-02 17:30:29', '0', 'JY姐姐', '花儿哭着对薛哥说：童话里都是骗人的…', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('49', '2015-08-02 18:12:44', '2015-08-02 18:12:44', '211', '小萌萌', '无毒无害不可食用', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('50', '2015-08-02 18:23:24', '2015-08-02 18:23:24', '323', '阿亮', '被彪马跟警卫员的虐恋感动了。', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('51', '2015-08-02 18:35:06', '2015-08-02 18:35:06', '181', '小萌萌', '报纸剪字拼的，说我真要报警了！', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('52', '2015-08-02 18:49:22', '2015-08-02 18:49:22', '29', '樱絮雪舞', '同想生猴子', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('53', '2015-08-02 19:16:37', '2015-08-02 19:16:37', '275', '阿亮', '个人感觉身上是奶味是因为撸多了。', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('54', '2015-08-02 19:31:58', '2015-08-02 19:31:58', '14', '德彪~', '这是我大哥', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('55', '2015-08-02 20:06:05', '2015-08-02 20:06:05', '120', '阿亮', '不是韭菜馅的么', '0', '0', null);
INSERT INTO `supplement_answer` VALUES ('56', '2015-08-02 21:02:53', '2015-08-02 21:02:53', '286', '干吃冬虫夏草就皮蛋瘦肉粥', '与之齐名的是夏教授，江湖人称南胡北夏。', '1', '1', null);
INSERT INTO `supplement_answer` VALUES ('57', '2015-08-02 21:12:37', '2015-08-02 21:12:37', '293', '年年', '爱好：调戏小公子儿', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('58', '2015-08-02 21:13:32', '2015-08-02 21:13:32', '18', '年年', '高个萌妹儿', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('59', '2015-08-02 21:14:52', '2015-08-02 21:14:52', '245', '年年', '吃一个沙县 来一份青笋漏片', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('60', '2015-08-02 21:16:17', '2015-08-02 21:16:17', '168', '年年', '其实和李斯文私信讨论高血压问题的是一个东北的大哥，沈阳的。', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('61', '2015-08-02 21:16:44', '2015-08-02 21:16:44', '235', '年年', '一款鼠标！手感特别好！', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('62', '2015-08-02 21:27:37', '2015-08-02 21:27:37', '281', '汪汪', 'hia~hia~hia~·第一名是我！', '0', '0', '');
INSERT INTO `supplement_answer` VALUES ('63', '2015-08-02 21:39:44', '2015-08-02 21:39:44', '160', '溜肝尖儿', '每到春运的时候，看着大批的人流回家，帆儿哥也开始了对外星的思乡活动。', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('64', '2015-08-02 22:04:37', '2015-08-02 22:04:37', '344', '樱木大咖', '花。', '0', '0', '');
INSERT INTO `supplement_answer` VALUES ('65', '2015-08-02 22:34:48', '2015-08-02 22:34:48', '168', '阿亮', '其实是我', '0', '0', '');
INSERT INTO `supplement_answer` VALUES ('66', '2015-08-02 23:03:13', '2015-08-02 23:03:13', '37', '大珍妮', '人好的没话说!!!!!!!!', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('67', '2015-08-02 23:19:00', '2015-08-02 23:19:00', '382', '我就是想试试新功能', '“色”音同“筛”', '0', '0', '');
INSERT INTO `supplement_answer` VALUES ('68', '2015-08-02 23:50:56', '2015-08-02 23:50:56', '375', '大珍妮', '❤', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('69', '2015-08-02 23:52:11', '2015-08-02 23:52:11', '376', '大珍妮', '帆儿：英姿飒爽的飒 ', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('70', '2015-08-02 23:54:16', '2015-08-02 23:54:16', '383', '大珍妮', '毛子爱吃茴香！', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('71', '2015-08-03 02:19:11', '2015-08-03 02:19:11', '0', '薛老师的情人', '中华田园镖，是农运会的一种比赛项目，彪迪吧是其项目的常年冠军。', '0', '0', '中华田园镖');
INSERT INTO `supplement_answer` VALUES ('72', '2015-08-03 04:43:13', '2015-08-03 04:43:13', '18', '家住共慈园的热心听众', '紫牙龈', '0', '0', '');
INSERT INTO `supplement_answer` VALUES ('73', '2015-08-03 04:46:28', '2015-08-03 04:46:28', '27', '来自共慈园的热心听众', 'F4仔仔', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('74', '2015-08-03 04:48:19', '2015-08-03 04:48:19', '14', '来自共慈园的热心听众', '青春期高血压患者，珠儿都崩了', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('75', '2015-08-03 05:01:19', '2015-08-03 05:01:19', '346', '鸭尼玛', '彪马苏还有一根吹筒作为副武器', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('76', '2015-08-03 05:18:28', '2015-08-03 05:18:28', '291', '鸭尼玛', '一模没考好老李递了一根烟给小李', '1', '1', '');
INSERT INTO `supplement_answer` VALUES ('77', '2015-08-03 05:29:43', '2015-08-03 05:29:43', '261', '鸭尼玛', '新浪入一股', '1', '1', '');
