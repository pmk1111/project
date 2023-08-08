drop table usr cascade constraints purge;

CREATE TABLE USR (
num            NUMBER         PRIMARY KEY,  --식별번호
id           VARCHAR2(50),  -- 아이디
pass         VARCHAR2(50),  -- 비밀번호
email        VARCHAR2(50),  -- 이메일
name         VARCHAR2(50),  -- 이름
pic          VARCHAR2(50),  -- 프로필사진
tel          VARCHAR2(50),  -- 전화번호
status       VARCHAR2(2)    -- 활성화 상태
);
insert into usr
(num, id,pass,email)
values(2, 'jess55', '1', 'g@gmail.com');

 select * from usr;
 
 CREATE SEQUENCE USR_SEQ;
 
 INSERT INTO USR
VALUES (USR_SEQ.NEXTVAL, 'admin', '1', 'admin@naver.com', 'admin', 'admin.png', '010-1111-2222', 0);

DROP TABLE MEMBER CASCADE CONSTRAINTS PURGE;

CREATE TABLE MEMBER (
p_num            NUMBER         REFERENCES PROJECT(P_NUM),   -- 프로젝트 식별번호
num               NUMBER        REFERENCES USR(NUM),         -- 유저 식별번호
grade            varchar2(50)  REFERENCES role(grade),      -- 유저 권한
PRIMARY KEY(p_num, num, grade)
)

SELECT *
FROM MEMBER;

insert into member
values (1,1,'admin')




