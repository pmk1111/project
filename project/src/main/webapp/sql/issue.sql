DROP TABLE ISSUE CASCADE CONSTRAINTS PURGE;

CREATE TABLE ISSUE (
i_seq 		number			primary key,						
p_num		NUMBER			REFERENCES PROJECT (p_num),
i_name		VARCHAR2(50),
i_title		VARCHAR2(100),
i_content	VARCHAR2(4000),
i_status	VARCHAR2(50),
i_file		VARCHAR2(50),
i_created	TIMESTAMP,
i_modified	TIMESTAMP,
i_reporter	VARCHAR2(50),
i_assign	VARCHAR2(50),
i_related	VARCHAR2(50),
i_readcount  number
);

select *
from issue;

create sequence i_seq;

INSERT INTO ISSUE (i_num, p_num)
VALUES ((SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 1),1);

INSERT INTO ISSUE (i_num, p_num)
VALUES ((SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 2),2);

INSERT INTO ISSUE (i_seq, i_num, p_num)
VALUES (i_seq.nextval, (SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 3),3);



SELECT * FROM ( 
				SELECT ROWNUM rnum, j.* FROM (
				    SELECT issue.*, NVL(cnt, 0) cnt 
				    FROM issue 
				    LEFT OUTER JOIN (
				        SELECT comment_i_num, COUNT(*) cnt  
				        FROM comm 
				        GROUP BY comment_i_num
				    ) ON i_num = comment_i_num 
						 and p_num = 3
				    ORDER BY i_seq DESC
				) j WHERE ROWNUM <= 2
				) WHERE rnum >= 1 AND rnum <= 2;
