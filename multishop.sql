drop table memo;

create table memo(
	no number(8),
	name varchar2(30) not null,
	msg varchar2(100),
	wdate timestamp default systimestamp,
	primary key (no)

);

drop sequence memo_seq;

create sequence memo_seq nocache;


desc memo;

select * from memo;

insert into memo(no,name,msg,wdate)
		values(memo_seq.nextval,'123', '123', systimestamp);
        
        
alter user multishop quota UNLIMITED on users;4

select * from memo order by no desc;


select * from(
select row_number() over(order by no desc) rn,
memo.* from memo )
where rn >0 and rn<6;