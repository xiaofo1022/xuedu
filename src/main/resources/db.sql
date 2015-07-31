CREATE TABLE xuedu.question (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	QUESTION VARCHAR(100),
	IS_ACTIVE INT DEFAULT 1,
	IS_ANSWERED INT DEFAULT 0,
	FROM_WHO VARCHAR(100),
	CONSTRAINT question_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

CREATE TABLE xuedu.users (
	ID INT NOT NULL AUTO_INCREMENT,
	USERNAME VARCHAR(100),
	PASSWORD VARCHAR(100),
	IS_ACTIVE INT DEFAULT 1,
	CONSTRAINT users_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

INSERT INTO xuedu.users (ID,USERNAME,PASSWORD,IS_ACTIVE) VALUES (1,'usdb','usdb2015',1);

CREATE TABLE xuedu.answer (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	TITLE VARCHAR(100),
	ANSWER VARCHAR(1000),
	IS_ACTIVE INT DEFAULT 1,
	CONSTRAINT answer_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

/* 2015-7-30 */
ALTER TABLE xuedu.answer ADD SEARCH_COUNT INT;

CREATE TABLE xuedu.fans_answer (
	ID INT NOT NULL AUTO_INCREMENT,
	INSERT_DATETIME DATETIME,
	UPDATE_DATETIME DATETIME,
	FANS_NAME VARCHAR(100),
	TITLE VARCHAR(100),
	ANSWER VARCHAR(1000),
	IS_ACTIVE INT DEFAULT 1,
	IS_APPROVED INT DEFAULT 0,
	CONSTRAINT fans_answer_PK PRIMARY KEY (ID)
)
ENGINE=InnoDB;

/* 2015-7-31 */
ALTER TABLE xuedu.answer ADD IS_EASTER_EGG INT DEFAULT 0;
ALTER TABLE xuedu.answer ADD EASTER_CODE VARCHAR(100);
ALTER TABLE xuedu.answer ADD NEXT_EASTER_TIP VARCHAR(1000);
ALTER TABLE xuedu.answer ADD FANS_ID INT;