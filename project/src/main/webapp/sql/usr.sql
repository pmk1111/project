drop table usr cascade constraints purge;

CREATE TABLE USR (
num				NUMBER			PRIMARY KEY,
id				VARCHAR2(50),
pass			VARCHAR2(50),
email			VARCHAR2(50),
name			VARCHAR2(50),
pic				VARCHAR2(50),
tel				VARCHAR2(50),
status			VARCHAR2(2)
);

CREATE SEQUENCE USR_SEQ;

drop sequence usr_seq;

select * from usr;

INSERT INTO USR
VALUES (USR_SEQ.NEXTVAL, 'admin', '1', 'admin@naver.com', 'admin', 'admin.png', '010-1111-2222', 0);

INSERT INTO USR
VALUES (USR_SEQ.NEXTVAL, 'admin27', '1', 'admin@naver.com', 'admin', 'admin.png', '010-1111-2222', 0);

