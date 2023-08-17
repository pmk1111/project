drop table project cascade constraints purge;

CREATE TABLE PROJECT (
    p_num       NUMBER          PRIMARY KEY,
    p_name      VARCHAR2(100),
    p_status    VARCHAR2(50) 	DEFAULT '계획중', -- 디폴트 값 추가
    p_start     VARCHAR2(50),
    p_closing   VARCHAR2(50),
    p_created   DATE DEFAULT sysdate, -- 디폴트 값 추가
    p_file      VARCHAR2(50)
);


CREATE SEQUENCE PRO_SEQ;

DROP SEQUENCE PRO_SEQ;

SELECT * FROM PROJECT;


-- 첫 번째 프로젝트
INSERT INTO PROJECT
VALUES (pro_seq.nextval, '프로젝트A', '진행중', '2023-07-31', '2023-12-31', SYSTIMESTAMP, NULL);

-- 두 번째 프로젝트
INSERT INTO PROJECT
VALUES (pro_seq.nextval, '프로젝트B', '계획중','2023-08-01', '2024-03-31', SYSTIMESTAMP, NULL);

-- 세 번째 프로젝트
INSERT INTO PROJECT
VALUES (pro_seq.nextval, '프로젝트C', '완료', '2023-06-15', '2023-11-30', SYSTIMESTAMP, NULL);

DELETE FROM project WHERE p_num = 120

SELECT *
FROM (SELECT ROWNUM rnum, j.*
      FROM (SELECT p.* 
            FROM project p
            JOIN member m ON p.p_num = m.p_num
            WHERE m.num = 38
            ORDER BY p.p_num DESC) j
      WHERE ROWNUM <= 7)
WHERE rnum BETWEEN 1 AND 7;

update PROJECT
set P_FILE = 'AI.png'
where P_NUM = 12

