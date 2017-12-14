SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema testdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `testdb` ;

-- -----------------------------------------------------
-- Schema testdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8mb4 ;
USE `testdb` ;

-- -----------------------------------------------------
-- Table `testdb`.`good`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`good` ;

CREATE TABLE IF NOT EXISTS `testdb`.`good` (
	`good_id` VARCHAR(32) NOT NULL COMMENT '商品id',
	`title` VARCHAR(64) NOT NULL COMMENT '商品名',
	`pic` VARCHAR(32) NULL COMMENT 'pic',
	`type` TINYINT NOT NULL DEFAULT 1 COMMENT '类型，1-普通，2-团购',
	`price` DOUBLE NOT NULL DEFAULT 0 COMMENT '默认价格',
	`extra_info` JSON NULL COMMENT '附加信息，member_days，几个人，拼团总价，拼团有效时长',
	`presentation_index` TINYINT NOT NULL DEFAULT 10 COMMENT '展示次序，越小越靠前展示',
	`state` TINYINT NOT NULL DEFAULT 1 COMMENT '状态，1-在售，2-下架',
	`create_time` INT NOT NULL DEFAULT 0,
 	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`good_id`),
	INDEX `title_IDX` (`title` ASC),
	INDEX `price_IDX` (`price` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`groupon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`groupon` ;

CREATE TABLE IF NOT EXISTS `testdb`.`groupon` (
	`groupon_id` VARCHAR(32) NOT NULL COMMENT '团购实例id',
	`good_id` VARCHAR(32) NOT NULL COMMENT '商品id',
	`total_price` DOUBLE NOT NULL DEFAULT 0 COMMENT '价格',
	`extra_info` JSON NULL COMMENT '附加信息，参与人员列表',	
	`state` TINYINT NOT NULL DEFAULT 1 COMMENT '状态，1-等待拼单完成，2-拼单成功，3-拼单失败',
	`invalid_time` INT NOT NULL DEFAULT 0 COMMENT '拼团截止时间',
	`start_time` INT NOT NULL DEFAULT 0,
	`complete_time` INT NOT NULL DEFAULT 0,
 	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`groupon_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`groupon_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`groupon_user` ;

CREATE TABLE IF NOT EXISTS `testdb`.`groupon_user` (
	`groupon_user_id` VARCHAR(32) NOT NULL COMMENT '团购人员记录id',
	`user_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`groupon_id` VARCHAR(32) NOT NULL COMMENT '团购实例id',
	`groupon_type` TINYINT NOT NULL DEFAULT 1 COMMENT '1-组员，2-组长',
	`good_id` VARCHAR(32) NOT NULL COMMENT '商品id',
	`extra_info` JSON NULL COMMENT '附加信息',
	`state` TINYINT NOT NULL DEFAULT 1 COMMENT '状态，1-等待拼单完成，2-拼单成功，3-拼单失败',
	`create_time` INT NOT NULL DEFAULT 0,
 	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`groupon_user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`deal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`deal` ;

CREATE TABLE IF NOT EXISTS `testdb`.`deal` (
  `deal_id` VARCHAR(32) NOT NULL COMMENT '订单id',
  `user_id` VARCHAR(32) NOT NULL COMMENT '用户id',
  `good_id` VARCHAR(32) NOT NULL COMMENT '商品id',
  `price` DOUBLE NOT NULL DEFAULT 0 COMMENT '价格',
  `info` JSON COMMENT '信息',
  `state` TINYINT NOT NULL DEFAULT 0 COMMENT '0-已下单，1-已付款，2-无效',
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`deal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`wxpay_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`wxpay_log` ;

CREATE TABLE IF NOT EXISTS `testdb`.`wxpay_log` (
  `id_wxpay_log` VARCHAR(32) NOT NULL,
  `user_id` VARCHAR(32) NULL COMMENT '发起用户id',
  `amount` DOUBLE NULL DEFAULT 0 COMMENT '金额',
  `target_id` VARCHAR(32) NULL DEFAULT '',
  `prepay_id` VARCHAR(64) NULL DEFAULT '',
  `status` TINYINT NULL DEFAULT 0 COMMENT '支付状态，1-下单待支付，2-支付成功，0-支付失败',
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_wxpay_log`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`alipay_log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`alipay_log` ;

CREATE TABLE IF NOT EXISTS `testdb`.`alipay_log` (
  `id_alipay_log` VARCHAR(32) NOT NULL,
  `user_id` VARCHAR(32) NULL COMMENT '发起用户id',
  `amount` DOUBLE NULL DEFAULT 0 COMMENT '金额',
  `target_id` VARCHAR(64) NULL DEFAULT '',
  `status` INT NULL DEFAULT 0 COMMENT '支付状态，1-下单待支付，2-支付成功，0-支付失败',
  `create_time`INT NOT NULL DEFAULT 0,
  `update_time`INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_alipay_log`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`system_set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`system_set` ;

CREATE TABLE IF NOT EXISTS `testdb`.`system_set` (
	`system_set_id` VARCHAR(32) NOT NULL COMMENT '系统设置id',
	`identifier` VARCHAR(45) NOT NULL COMMENT '变量标识符',
	`display_name` VARCHAR(45) NOT NULL COMMENT '设置显示名称，转链cookie，客服问答对，分佣比例',
	`description` VARCHAR(45) NULL COMMENT '变量说明',
	`value` JSON NOT NULL COMMENT '变量值',
	`start_time` INT NOT NULL COMMENT '设置生效时间',
	`create_time` INT NOT NULL DEFAULT 0,
	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`system_set_id`),
	INDEX `identifier_IDX` (`identifier` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`personal_set`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`personal_set` ;

CREATE TABLE IF NOT EXISTS `testdb`.`personal_set` (
	`personal_set_id` VARCHAR(32) NOT NULL COMMENT '用户设置id',
	`user_id` VARCHAR(32) NULL COMMENT '用户id',
	`identifier` VARCHAR(45) NOT NULL COMMENT '变量标识符',
	`display_name` VARCHAR(45) NOT NULL COMMENT '设置显示名称',
	`description` VARCHAR(45) NULL COMMENT '变量说明',
	`value` JSON NOT NULL COMMENT '变量值',
	`start_time` INT NOT NULL DEFAULT 0 COMMENT '设置生效时间',
	`create_time` INT NOT NULL DEFAULT 0,
	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`personal_set_id`),
	INDEX `user_id_IDX` (`user_id` ASC),
	INDEX `identifier_IDX` (`identifier` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`layout`
-- -----------------------------------------------------
-- DROP TABLE IF EXISTS `testdb`.`layout` ;

-- CREATE TABLE IF NOT EXISTS `testdb`.`layout` (
--   `id_layout` VARCHAR(32) NOT NULL,
--   `target_id` VARCHAR(32) NULL COMMENT '目标id，比如分类的id，若为index，表示为首页的布局',
--   `name` VARCHAR(45) NOT NULL COMMENT '布局名称',
--   `value` JSON NOT NULL COMMENT '布局内容',
--   `start_time` INT NOT NULL COMMENT '开始时间',
--   `create_time` INT NOT NULL DEFAULT 0,
--   `update_time` INT NOT NULL DEFAULT 0,
--   PRIMARY KEY (`id_layout`))
-- ENGINE = InnoDB
-- DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`popup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`popup` ;

CREATE TABLE IF NOT EXISTS `testdb`.`popup` (
  `popup_id` VARCHAR(32) NOT NULL,
  `value` VARCHAR(32) NOT NULL,
  `duration` TINYINT NOT NULL DEFAULT 3 COMMENT '显示时长',
  `start_time` INT NOT NULL DEFAULT 0 COMMENT '开始时间',
  `end_time` INT NOT NULL DEFAULT 0,
  `period` INT NOT NULL DEFAULT 6 COMMENT 'hours per popup',
  `target_type` TINYINT NULL COMMENT '1-pic，2-url',
  `target_value` VARCHAR(1024) NULL,
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`popup_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`slide`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`slide` ;

CREATE TABLE IF NOT EXISTS `testdb`.`slide` (
  `slide_id` VARCHAR(32) NOT NULL,
  `pic` VARCHAR(32) NULL COMMENT 'slide元素图片',
  `target_type` TINYINT NULL COMMENT '类型，1—pic，2—url，3—商品',
  `target_value` VARCHAR(1024) NOT NULL,
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`slide_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`staff` ;

CREATE TABLE IF NOT EXISTS `testdb`.`staff` (
	`staff_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`staff_name` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '名字',
	`staff_type` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '类型, good-商品管理员，finance-财务，service-客服，admin-总管',
	`password` VARCHAR(32) NOT NULL COMMENT '密码',
	`portrait` VARCHAR(32) NULL DEFAULT '' COMMENT '用户头像',
	`mobile` VARCHAR(32) NULL COMMENT '手机号码',
	`email` VARCHAR(32) NULL COMMENT '邮箱',
-- 	`extra_info` JSON NULL COMMENT '附加信息，包括',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	UNIQUE INDEX `staff_name_UNIQUE` (`staff_name` ASC),
	PRIMARY KEY (`staff_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`user` ;

CREATE TABLE IF NOT EXISTS `testdb`.`user` (
	`user_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`mobile` VARCHAR(32) NULL COMMENT '手机号码',
	`name` VARCHAR(32) NOT NULL COMMENT '姓名',
	`device` VARCHAR(64) NULL COMMENT '设备序列号，绑定后不可更改',
	`member_type` TINYINT NOT NULL DEFAULT 0 COMMENT '会员类型，0 非会员，1 普通会员，2 年度会员，3 永久会员',
	`member_deadline` INT NOT NULL DEFAULT 0 COMMENT '会员截止时间',
	`extra_info` JSON NULL COMMENT '附加信息',
	`active_time` INT NOT NULL DEFAULT 0 COMMENT '活跃时间',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	PRIMARY KEY (`user_id`),
	UNIQUE INDEX `mobile_IDX` (`mobile` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`weixin_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`weixin_user` ;

CREATE TABLE IF NOT EXISTS `testdb`.`weixin_user` (
	`weixin_user_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`unionid` VARCHAR(128) NOT NULL COMMENT 'UnionId',
	`user_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`nickname` VARCHAR(32) NOT NULL COMMENT '昵称',
	`sex` INT NOT NULL DEFAULT 1 COMMENT '性别',
	`country` VARCHAR(32) NULL DEFAULT '' COMMENT '国家',
	`province` VARCHAR(32) NULL DEFAULT '' COMMENT '省份',
	`city` VARCHAR(32) NULL DEFAULT '' COMMENT '城市',
	`headimgurl` VARCHAR(512) NULL DEFAULT '' COMMENT '头像',
	`extra_info` JSON NULL COMMENT '附加信息，包括',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	PRIMARY KEY (`weixin_user_id`),
	UNIQUE INDEX `unionid_IDX` (`unionid` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`weixin_ui`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`weixin_ui` ;

CREATE TABLE IF NOT EXISTS `testdb`.`weixin_ui` (
	`weixin_ui_id` VARCHAR(32) NOT NULL COMMENT '用户id',
	`version` VARCHAR(32) NOT NULL COMMENT '版本号',
	`ui` JSON NULL COMMENT '',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	PRIMARY KEY (`weixin_ui_id`),
	UNIQUE INDEX `version_IDX` (`version` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`activation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`activation` ;

CREATE TABLE IF NOT EXISTS `testdb`.`activation` (
	`activation_id` VARCHAR(32) NOT NULL COMMENT '激活码id',
	`code` VARCHAR(32) NOT NULL COMMENT '激活码',
	`batch` VARCHAR(32) NULL COMMENT '批次',
	`good_id` VARCHAR(32) NOT NULL COMMENT '商品id',
	`extra_info` JSON NULL COMMENT '附加信息，包括',
	`state` TINYINT NOT NULL DEFAULT 1 COMMENT '1-未使用，2-已使用',
	`user_id` VARCHAR(32) NULL COMMENT '用户id',
	`active_time` INT NOT NULL DEFAULT 0 COMMENT '激活时间',
	`expire_time` INT NOT NULL DEFAULT 0 COMMENT '失效时间',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	PRIMARY KEY (`activation_id`),
	UNIQUE INDEX `code_idx` (`code` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`message` ;

CREATE TABLE IF NOT EXISTS `testdb`.`message` (
	`message_id` VARCHAR(32) NOT NULL COMMENT 'message id',
	`user_id` VARCHAR(32) NOT NULL COMMENT 'user id',
	`message_type` VARCHAR(32) NOT NULL COMMENT '消息类型',
	`text` VARCHAR(512) NOT NULL COMMENT '消息内容',
	`message_extra` JSON NULL COMMENT '根据message_type而定',
	`read` INT NULL DEFAULT 1 COMMENT '是否已读，1-否，2-是',
	`create_time` INT NOT NULL DEFAULT 0 COMMENT '创建时间',
	`update_time` INT NOT NULL DEFAULT 0 COMMENT '更新时间',
	PRIMARY KEY (`message_id`),
	INDEX `user_id_UNIQUE` (`user_id` ASC),
	INDEX `message_type_UNIQUE` (`message_type` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`media` ;

CREATE TABLE IF NOT EXISTS `testdb`.`media` (
  `media_id` VARCHAR(32) NOT NULL COMMENT '资源ID',
  `owner_id` VARCHAR(32) NULL COMMENT '该资源的所属者id',
  `owner_type` TINYINT NULL COMMENT '该资源的所属者类型，1—商品展示图，2-商品详情，3',
  `type` TINYINT NOT NULL COMMENT '1-图片，2-视频，3-音频',
  `sequence` TINYINT NOT NULL DEFAULT 0 COMMENT '排序序号',
  `create_time` INT NULL DEFAULT 0,
  `update_time` INT NULL DEFAULT 0,
  PRIMARY KEY (`media_id`),
  INDEX `owner_id_IDX` (`owner_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`sms_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`sms_info` ;

CREATE TABLE IF NOT EXISTS `testdb`.`sms_info` (
  `id_sms_info` VARCHAR(32) NOT NULL COMMENT '用户验证id',
  `mobile` VARCHAR(32) NULL,
  `country_code` INT NULL COMMENT '电话国家码',
  `sign` VARCHAR(32) NULL COMMENT '签名',
  `TemplateCode` VARCHAR(16) NULL COMMENT '短信模版ID',
  `code` VARCHAR(16) NULL COMMENT '验证码',
  `checked` INT NULL DEFAULT 0 COMMENT '验证状态，0-未验证，10-验证成功，20-验证失败',
  `valid_time` INT NOT NULL DEFAULT 0 COMMENT '有效时间',
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_sms_info`),
  INDEX `mobile_IDX` (`mobile` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`captcha`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`captcha` ;

CREATE TABLE IF NOT EXISTS `testdb`.`captcha` (
	`captcha_id` VARCHAR(32) NOT NULL COMMENT '验证码id',
	`value` VARCHAR(16) NOT NULL COMMENT '验证码数值',
	`state` TINYINT NOT NULL COMMENT '验证状态，0-未验证，10-验证成功，20-验证失败',
	`valid_time` INT NOT NULL DEFAULT 0 COMMENT '有效时间',
	`create_time` INT NOT NULL DEFAULT 0,
	`update_time` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`captcha_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`feedback` ;

CREATE TABLE IF NOT EXISTS `testdb`.`feedback` (
  `id_feedback` VARCHAR(32) NOT NULL,
  `user_id` VARCHAR(32) NULL,
  `state` TINYINT NOT NULL DEFAULT 0 COMMENT '状态，0-未处理，1-已处理',
  `words` VARCHAR(256) NOT NULL COMMENT '用户留言',
  `memo` VARCHAR(256) NULL COMMENT '处理记录',
  `create_time` INT NOT NULL DEFAULT 0,
  `update_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_feedback`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `testdb`.`user_search`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `testdb`.`user_search` ;

CREATE TABLE IF NOT EXISTS `testdb`.`user_search` (
  `id_user_search` VARCHAR(32) NOT NULL,
  `user_id` VARCHAR(32) NULL,
  `word` VARCHAR(45) NOT NULL COMMENT '用户搜索词',
  `create_time` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_user_search`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;