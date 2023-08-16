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

insert into usr
VALUES (USR_SEQ.NEXTVAL, 'c', '1', 'lee@test.com', '이지은', '', '010-1234-5678', 0);

update USR
set status = '0'
where id = 'user1'

delete from usr where num = 1

-----------------------------------------

INSERT INTO USR (num, id, pass, email, name, pic, tel)
VALUES (USR_SEQ.NEXTVAL, 'user1', '1', 'tarry12@gmail.com', '김태리', 'user6.jpg', '01045678901');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user2', '1', 'tuna98@naver.com', '강동원', 'user11.jpg', '01056789012', '0');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user3', '1', 'legaend@yahoo.com', '전지현', 'user7.jpg', '01067890123', '0');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user4', '1', 'impretty@gamil.com', '나얼짱', 'user13.jpg', '01078901234', '0');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user5', '1', 'sharp55@naver.com', '한예리', 'user9.jpg', '01089012345', '0');

INSERT INTO USR (num, id, pass, email, name, pic, tel, status)
VALUES (USR_SEQ.NEXTVAL, 'user6', '1', 'jiwon15@daum.net', '김지원', 'user12.jpg', '01001234567', '0');

