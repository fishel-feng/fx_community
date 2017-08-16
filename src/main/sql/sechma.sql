CREATE DATABASE my_community;
USE my_community;
CREATE TABLE user (
  `uid`      INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255)     DEFAULT NULL,
  `password` VARCHAR(255)     DEFAULT NULL,
  `headimg`  VARCHAR(255)     DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `username` (`username`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 16
  DEFAULT CHARSET = utf8;

CREATE TABLE `article` (
  `aid`     INT(11) NOT NULL          AUTO_INCREMENT,
  `title`   VARCHAR(100)              DEFAULT NULL,
  `content` TEXT,
  `date`    DATETIME                  DEFAULT NULL,
  `uid`     INT(11) NOT NULL,
  `lable`   VARCHAR(100)              DEFAULT NULL,
  `status`  INT(10) UNSIGNED ZEROFILL DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `uid` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 75
  DEFAULT CHARSET = utf8;


CREATE TABLE `comment` (
  `cid`     INT(11) NOT NULL AUTO_INCREMENT,
  `content` TEXT,
  `aid`     INT(11) NOT NULL,
  `uid`     INT(11) NOT NULL,
  `date`    DATETIME         DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `aid` (`aid`),
  KEY `uid` (`uid`),
  CONSTRAINT `aid` FOREIGN KEY (`aid`) REFERENCES `article` (`aid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `comment_uid` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 32
  DEFAULT CHARSET = utf8;

CREATE TABLE `floor` (
  `fid`     INT(11) NOT NULL AUTO_INCREMENT,
  `cid`     INT(11) NOT NULL,
  `uid`     INT(11) NOT NULL,
  `content` VARCHAR(255)     DEFAULT NULL,
  PRIMARY KEY (`fid`),
  KEY `cid` (`cid`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `comment` (`cid`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 20
  DEFAULT CHARSET = utf8;

