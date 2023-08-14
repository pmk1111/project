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

insert into usr
VALUES (USR_SEQ.NEXTVAL, 'admin2', '1', 'hong@test.com', '홍길동', '', '010-1234-5678', 0);

insert into usr
VALUES (USR_SEQ.NEXTVAL, 'admin3', '1', 'hong@test.com', '박서준', '', '010-1111-2222', 0);

insert into usr
VALUES (USR_SEQ.NEXTVAL, 'admin4', '1', 'lee@test.com', '이지은', '', '010-1234-5678', 0);


-- 다섯 개의 레코드 추가
INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user1', '1', 'user1@example.com', 'User One', 'pic1.jpg', '123-456-7890', 'A');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user2', '1', 'user2@example.com', 'User Two', 'pic2.jpg', '987-654-3210', 'A');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user3', '1', 'user3@example.com', 'User Three', 'pic3.jpg', '555-555-5555', 'I');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user4', '1', 'user4@example.com', 'User Four', 'pic4.jpg', '111-222-3333', 'A');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user5', '1', 'user5@example.com', 'User Five', 'pic5.jpg', '444-444-4444', 'I');