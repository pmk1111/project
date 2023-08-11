drop table comm cascade constraints purge;

create table comm(
   c_num            number       primary key,
   num        		number    	 references usr(num),
   c_id		  		varchar2(50),	
   c_content      	varchar2(200),
   reg_date   		date,
   comment_i_num    number      references issue(i_seq) on delete cascade,   --comm테이블 참조
   comment_p_num    number      references project(p_num) on delete cascade,   --comm테이블 참조
   comment_re_lev   number(1)   check(comment_re_lev in (0,1,2)), --원문이면 0 답글이면 1
   comment_re_seq   number,      --원문이면 0, 1레벨이면 1레벨 시퀀스 +1
   comment_re_ref   number      --원문은 자신 글번호, 답글이면 원문 글번호
);

drop sequence com_seq;

create sequence com_seq;

delete comm;

select * from comm;

select * from usr;

update usr 
set id = 'admin13' 
where num = 13;


 select c_num, comm.num, comm.c_id, comm.c_content, reg_date, comment_i_num, comment_re_lev, 
					  comment_re_seq,
						  comment_re_ref, usr.pic
					from  comm join usr
					on    comm.c_id=usr.id 
				 where comment_i_num = 2
				 order by comment_re_ref asc,
					 	  comment_re_seq asc;
					 	  
					 	  
	select * from comm;				 	  


delete from comm;


