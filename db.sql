DROP DATABASE IF EXISTS jspCommunity;
CREATE DATABASE jspCommunity;
USE jspCommunity;

# 회원 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(50) NOT NULL,
    `nickname` CHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    loginId CHAR(50) NOT NULL UNIQUE,
    loginPw VARCHAR(200) NOT NULL,
    authLevel TINYINT(1) UNSIGNED NOT NULL DEFAULT 2 COMMENT '0=탈퇴/1=로그인정지/2=일반/3=인증된,4=관리자'
);

# cellphoneNo 추가 및 칼럼 순서 재정렬
ALTER TABLE `member` CHANGE `loginId` `loginId` CHAR(50) NOT NULL AFTER `updateDate`,
                     CHANGE `loginPw` `loginPw` VARCHAR(200) NOT NULL AFTER `loginId`,
                     ADD COLUMN `cellphoneNo` CHAR(20) NOT NULL AFTER `email`;

# 회원1 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
`name` = "김민수",
`nickname` = "강바람",
`email` = "test1@test.com",
loginId = "user1",
loginPw = "user1",
cellphoneNo = "01000000000";


# 회원2 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
`name` = "김미소",
`nickname` = "이또한지나가리라",
`email` = "test2@test.com",
loginId = "user2",
loginPw = "user2",
cellphoneNo = "01000000000";

# 기존회원들 비밀번호 암호화
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

# 게시판 테이블 생성
CREATE TABLE board (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(10) NOT NULL UNIQUE,
    `name` CHAR(10) NOT NULL UNIQUE
);

# 공지사항 게시판 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = '공지사항';

# 자유게시판 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
`name` = '자유게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'tip',
`name` = '정보게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'trade',
`name` = '교환해요';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'qna',
`name` = '묻고답하고';

# 게시물 테이블 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL,
    title CHAR(100) NOT NULL,
    `body` LONGTEXT NOT NULL,
    hitsCount INT(10) UNSIGNED NOT NULL DEFAULT 0
);

# 테스트 게시물 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 2,
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 2,
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
boardId = 2,
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
boardId = 2,
title = '제목4',
`body` = '내용4';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
boardId = 2,
title = '제목5',
`body` = '내용5';

SELECT * FROM article;

# 부가정보테이블
CREATE TABLE attr(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
relTypeCode CHAR(20) NOT NULL,
relId INT(10) UNSIGNED NOT NULL,
typeCode CHAR(30) NOT NULL,
type2Code CHAR(30) NOT NULL,
`value` TEXT NOT NULL
);

# attr 유니크인덱스 걸기
## 중복변수 생성 금지
## 변수찾는 속도 최적화
ALTER TABLE attr ADD UNIQUE INDEX (relTypeCode, relId, typeCode, type2Code);

## 특정 조건을 만족하는 회원 또는 게시물(기타데이터)를 빠르게 찾기위해
ALTER TABLE attr ADD INDEX (relTypeCode, typeCode, type2Code);

# attr에 만료날짜 추가
ALTER TABLE attr ADD COLUMN expireDate DATETIME NULL AFTER `value`;

#추천 테이블 
CREATE TABLE `like` (
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
relTypeCode CHAR(30) NOT NULL,
relId INT(10) UNSIGNED NOT NULL,
memberId INT(10) UNSIGNED NOT NULL,
`point` TINYINT(2) NOT NULL
);

ALTER TABLE article ADD COLUMN likesCount INT(10) UNSIGNED NOT NULL AFTER `hitsCount`;

ALTER TABLE `like` ADD UNIQUE INDEX (`relTypeCode` , `relId` , `memberId`); 

#댓글테이블
CREATE TABLE reply(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
relTypeCode CHAR(30) NOT NULL,
relId INT(10) UNSIGNED NOT NULL,
memberId INT(10) UNSIGNED NOT NULL,
`body` CHAR(300) NOT NULL
);