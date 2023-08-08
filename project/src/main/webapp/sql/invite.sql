DROP TABLE INVITE CASCADE CONSTRAINTS PURGE;

CREATE TABLE INVITE (
p_num            NUMBER         REFERENCES PROJECT(P_NUM),   -- 프로젝트 식별번호
num               NUMBER        REFERENCES USR(NUM),      -- 유저 식별번호
i_status         VARCHAR2(20),                        -- 초대 현황
PRIMARY KEY(p_num, num)
);

SELECT *
FROM INVITE;

insert into INVITE
VALUES (1, 1, '수락')

DROP TABLE ROLE CASCADE CONSTRAINTS PURGE;

CREATE TABLE ROLE (
GRADE         VARCHAR2(50) primary key,      -- 유저 등급
INV_ACCESS      NUMBER(2)         -- 초대 권한
)

SELECT *
FROM ROLE;

DELETE FROM ROLE WHERE GRADE = '관리자' ;

INSERT INTO ROLE
VALUES('admin', 1);

INSERT INTO ROLE
VALUES('sub', 1);

INSERT INTO ROLE
VALUES('normal', 0);
