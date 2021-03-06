-- 导出  视图 test.VIEW_ARTICLE 结构
-- 创建临时表以解决视图依赖性错误
CREATE TABLE `VIEW_ARTICLE` (
     `ARTICLE_ID` BIGINT(20) NOT NULL COMMENT '文章编号',
     `ARTICLE_TITLE` VARCHAR(1000) NULL COMMENT '标题' COLLATE 'utf8_general_ci',
     `FILE_ID` VARCHAR(200) NULL COMMENT '附件ID' COLLATE 'utf8_general_ci',
     `ARTICLE_CONTENT` TEXT NULL COMMENT '内容' COLLATE 'utf8_general_ci',
     `ARTICLE_DESCRIPTION` VARCHAR(500) NULL COMMENT '描述' COLLATE 'utf8_general_ci',
     `MODEL_ID` bigint(20) NOT NULL COMMENT '所属模块' COLLATE 'utf8_general_ci',
     `ARTICLE_HIT` int(11) DEFAULT '0' COMMENT '是否显示\r\n 0:显示\r\n  -1:隐藏\r\n ' COLLATE 'utf8_general_ci',
     `ACTIVE` int(1) DEFAULT NULL COMMENT '是否有效' COLLATE 'utf8_general_ci',
     `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间' COLLATE 'utf8_general_ci',
     `CREATE_OPR_ID` varchar(40) DEFAULT NULL COMMENT '创建人ID' COLLATE 'utf8_general_ci',
     `login_id` varchar(120) DEFAULT NULL COMMENT '登陆名称' COLLATE 'utf8_general_ci',
  	 `user_name` varchar(40) DEFAULT NULL COMMENT '用户名' COLLATE 'utf8_general_ci',
     `Img_url` varchar(120) DEFAULT NULL COMMENT '图片地址' COLLATE 'utf8_general_ci',
     `USER_SEX` int(1) DEFAULT '0' COMMENT 'O:未知，1男，2:女' COLLATE 'utf8_general_ci',
     `COMMENT_COUNT` BIGINT(21) DEFAULT '0' COMMENT '评论数' COLLATE 'utf8_general_ci',
     `STORE_COUNT` BIGINT(21) DEFAULT '0' COMMENT '收藏数' COLLATE 'utf8_general_ci',
     `TOP_COUNT` BIGINT(21) DEFAULT '0' COMMENT '点赞数' COLLATE 'utf8_general_ci'
) ENGINE=MyISAM;


-- 导出  视图 test.VIEW_ARTICLE 结构
-- 移除临时表并创建最终视图结构
DROP TABLE IF EXISTS `VIEW_ARTICLE`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `VIEW_ARTICLE` AS
select
`CART`.`ARTICLE_ID` AS `ARTICLE_ID`,
`CART`.`ARTICLE_TITLE` AS `ARTICLE_TITLE`,
`CART`.`FILE_ID` AS `FILE_ID`,
`CART`.`ARTICLE_CONTENT` AS `ARTICLE_CONTENT`,
`CART`.`ARTICLE_DESCRIPTION` AS `ARTICLE_DESCRIPTION`,
`CART`.`MODEL_ID` AS `MODEL_ID`,
`CART`.`ARTICLE_HIT` AS `ARTICLE_HIT`,
`CART`.`ACTIVE` AS `ACTIVE`,
`CART`.`CREATE_TIME` AS `CREATE_TIME`,
`CART`.`CREATE_OPR_ID` AS `CREATE_OPR_ID`,
`SL`.`USER_NAME` AS `USER_NAME`,
`SL`.`Img_url` AS `Img_url`,
`SL`.`login_id` AS `LOGIN_ID`,
`SL`.`SEX` AS `USER_SEX`,
(select count(`CMS_COMMENT`.`COMMENT_ID`) from `CMS_COMMENT` where (`CMS_COMMENT`.`ASSOCICATION_ID` = `CART`.`ARTICLE_ID`)) AS `COMMENT_COUNT`,(select count(`CMS_ATTENTION`.`ATTENTION_ID`) from `CMS_ATTENTION` where ((`CMS_ATTENTION`.`ASSOCICATION_ID` = `CART`.`ARTICLE_ID`) and (`CMS_ATTENTION`.`ATTENTION_TYPE` = 1))) AS `STORE_COUNT`,
(select count(`CMS_ATTENTION`.`ATTENTION_ID`) from `CMS_ATTENTION` where ((`CMS_ATTENTION`.`ASSOCICATION_ID` = `CART`.`ARTICLE_ID`) and (`CMS_ATTENTION`.`ATTENTION_TYPE` = 2))) AS `TOP_COUNT`
from `CMS_ARTICLE` `CART`
LEFT JOIN SYS_LOGIN SL ON CART.CREATE_OPR_ID = SL.ID;


