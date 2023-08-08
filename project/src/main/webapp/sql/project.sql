drop table project cascade constraints purge;

CREATE TABLE PROJECT (
p_num      NUMBER         PRIMARY KEY,
p_name      VARCHAR2(100),               -- 프로젝트 명
p_status   VARCHAR2(50),                -- 진행 상태 
p_start      DATE,                     -- 시작 시간
p_closing   DATE,                     -- 종료 시간
p_priority   NUMBER(3),                  -- 우선 순위
p_created   TIMESTAMP                  -- 생성 시간
)

CREATE SEQUENCE PRO_SEQ;

SELECT *
FROM PROJECT;

-- 첫 번째 프로젝트
INSERT INTO PROJECT
VALUES (pro_seq.nextval, '프로젝트A', '진행중', TO_DATE('2023-07-31', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 1, SYSTIMESTAMP);

-- 두 번째 프로젝트
INSERT INTO PROJECT (p_num, p_name, p_status, p_start, p_closing, p_priority, p_created)
VALUES (pro_seq.nextval, '프로젝트B', '계획중', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 2, SYSTIMESTAMP);

-- 세 번째 프로젝트
INSERT INTO PROJECT (p_num, p_name, p_status, p_start, p_closing, p_priority, p_created)
VALUES (pro_seq.nextval, '프로젝트C', '완료', TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 3, SYSTIMESTAMP);


