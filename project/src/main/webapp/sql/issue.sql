DROP TABLE ISSUE CASCADE CONSTRAINTS PURGE;

CREATE TABLE ISSUE (
i_seq 		number			primary key,						
p_num		NUMBER			REFERENCES PROJECT (p_num) on delete cascade,
i_id		VARCHAR2(50), --게시글 작성자 아이디
i_name		VARCHAR2(50), -- 게시글 작성자 이름
i_title		VARCHAR2(100), -- 게시글 제목
i_content	VARCHAR2(4000), -- 게시글 내용
i_status	VARCHAR2(50), -- 게시글(이슈)의 진행 상태 
i_file		VARCHAR2(50), -- 업로드한 파일 
i_type		VARCHAR2(50), -- 게시글(이슈)의 타입
i_created	DATE DEFAULT sysdate,
i_modified	DATE,
i_reporter	VARCHAR2(50), -- 보고자
i_assign	VARCHAR2(50), -- 담당자(중복 값이 나올 수 있다)
i_related	VARCHAR2(50), -- 관련 이슈
i_readcount  number
);

select * from issue;

select max(i_seq) from issue;
select max(i_seq)-3 from issue;

select * from 
	(select * from issue 
	 where p_num=47 order by i_seq desc)
where rownum <= 4;
-- 프로젝트의 최신 글 4개 가져온다

select * from 
	(select * from issue 
	 where p_num=47 
	 and i_assign = (select name from usr
	 				 where id = 'pmk123')
	 and i_status = 'To Do'
	 order by i_seq desc)
	 left join (select * from issue)
	 			where 
where rownum <= 3;

delete from issue;

create sequence i_seq;

DROP SEQUENCE I_SEQ;

INSERT INTO ISSUE (i_num, p_num)
VALUES ((SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 1),1);

INSERT INTO ISSUE (i_num, p_num)
VALUES ((SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 2),2);

INSERT INTO ISSUE (i_seq, i_num, p_num)
VALUES (i_seq.nextval, (SELECT NVL(max(i_num)+1, 1) FROM issue WHERE p_num = 3),3);

INSERT INTO ISSUE (i_seq, p_num)
VALUES (i_seq.nextval, 21);

select * from issue where i_status = 'To Do';


SELECT * FROM ( 
				SELECT ROWNUM rnum, j.* FROM (
				    SELECT issue.*, NVL(cnt, 0) cnt 
				    FROM issue 
				    LEFT OUTER JOIN (
				        SELECT comment_i_num, COUNT(*) cnt  
				        FROM comm 
				        GROUP BY comment_i_num
				    ) ON i_seq = comment_i_num 
						 and p_num = 3
				    ORDER BY i_seq DESC
				) j WHERE ROWNUM <= 2
				) WHERE rnum >= 1 AND rnum <= 2
				and i_assign = '김길동'
				and i_id = 'pmk123'
		        and i_status = 'To Do';

		        
		        
		        
SELECT * 
	 FROM ( SELECT ROWNUM rnum, i.* 
			 FROM issue i 
	    	 join project p on i.p_num = p.p_num 
			 where p.p_num = ?
			 order by i.i_seq desc
			) 
 	WHERE rnum  >= (select max(i_seq)-3 from issue) 
	AND rnum <= (select max(i_seq) from issue);