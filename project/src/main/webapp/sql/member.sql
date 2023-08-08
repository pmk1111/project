DROP TABLE MEMBER CASCADE CONSTRAINTS PURGE;

CREATE TABLE MEMBER (
p_num				NUMBER 		  REFERENCES PROJECT(P_NUM),	-- 프로젝트 식별번호
num					NUMBER		  REFERENCES USR(NUM),			-- 유저 식별번호
grade				varchar2(50)  REFERENCES role(grade),		-- 유저 권한
PRIMARY KEY(p_num, num, grade)
)

SELECT *
FROM MEMBER;

insert into member 
values ( 1, 1, 'master');

insert into member 
values ( 2, 1, 'master');

insert into member 
values ( 3, 1, 'master');

insert into member 
values ( 4, 1, 'master');

insert into member 
values ( 5, 1, 'master');

insert into member 
values ( 7, 1, 'master');

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