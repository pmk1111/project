DROP TABLE MEMBER CASCADE CONSTRAINTS PURGE;

CREATE TABLE MEMBER (
p_num				NUMBER 		  REFERENCES PROJECT(P_NUM) on delete cascade,	-- 프로젝트 식별번호
num					NUMBER		  REFERENCES USR(NUM),			-- 유저 식별번호
grade				varchar2(50)  REFERENCES role(grade),		-- 유저 권한
M_p_name      		VARCHAR2(100),
M_id				VARCHAR2(50),
M_name				VARCHAR2(50),
M_pic				VARCHAR2(50),
M_tel				VARCHAR2(50),
M_email				VARCHAR2(50),
PRIMARY KEY(p_num, num, grade)
);


SELECT *
FROM MEMBER;

INSERT INTO MEMBER (p_num, num, grade, M_p_name, M_id, M_name, M_pic, M_tel, M_email)
VALUES (71, 3, 'master', '프로젝트1', 'admin2', '홍길동', '', '010-1234-5678', 'hong@test.com');

INSERT INTO MEMBER (p_num, num, grade, M_p_name, M_id, M_name, M_pic, M_tel, M_email)
VALUES (71, 4, 'sub', '프로젝트1', 'admin3', '박서준', '', '010-1111-2222', '');

INSERT INTO MEMBER (p_num, num, grade, M_p_name, M_id, M_name, M_pic, M_tel, M_email)
VALUES (71, 5, 'normal', '프로젝트1', 'admin4', '이지은', '', '', 'lee@test.com');

SELECT P.*
FROM PROJECT P
JOIN MEMBER M ON P.p_num = M.p_num
WHERE M.num = 1;

-- 프로젝트 총 갯수
SELECT COUNT(*)
FROM MEMBER
WHERE NUM = 1;

-- 페이지에 맞게 select하는 쿼리
SELECT *
FROM (
SELECT ROWNUM rnum, p.*
FROM project p
JOIN member m ON p.p_num = m.p_num
WHERE m.num = 1
ORDER BY p.p_num DESC
)
WHERE rnum BETWEEN 1 AND 9

insert into member
values ()

-- memberlsit
SELECT COUNT(*)
FROM member
WHERE p_num = 2

-- 페이지에 맞게 멤버select
SELECT *
FROM (
SELECT ROWNUM rnum, m.*
FROM member m
JOIN project p ON m.p_num = p.p_num
WHERE p.p_num = 2
ORDER BY p.p_num DESC
)
WHERE rnum BETWEEN 1 AND 9
