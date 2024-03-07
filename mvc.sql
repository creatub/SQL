create table mvc_board(
	num number(8) primary key, -- 글번호
	name varchar2(30) not null, -- 작성자
	passwd varchar2(20) not null, -- 글 비밀번호
	title varchar2(300) not null, -- 글제목
	content varchar2(2000), -- 글내용
	wdate date default sysdate, --작성일
	readnum number(8) default 0, -- 조회수
	fileName varchar2(500), -- 첨부파일명
	fileSize number(8) -- 첨부파일 크기
);

create sequence mvc_board_seq
start with 1
increment by 1
nocache;

desc mvc_board;

select * from mvc_board;

select * from ( 
select rownum rn, a.* from 
 (select * from mvc_board where
 title like '%123%' order by num desc) a) where rn between 1 and 5;
 
 (select * from mvc_board where
 title like '%123%' order by num desc);
 
 SELECT count(num) FROM mvc_board WHERE title like '%123%';
-------------------------------------------
rownum 을 활용한 페이징 처리

select rownum rn, a.* from mvc_board a order by num desc;

select * from (
select rownum rn, a.* from
(select * from mvc_board order by num desc) a
)
where rn between 16 and 20;

-------------------------
pageNum     oneRecordPage       start   end
1           5                   1       5
2           5                   6       10
3           5                   11      15
4           5                   16      20
-------------------------
end=pageNum*oneRecordPage;
start = end-(oneRecordPage-1);
-------------------------

select * from java_member;

select * from java_member order by name asc;


자바 멤버에 가나다순으로 1~5번까지만 가져오는 쿼리
select * from (
select row_number() over(order by name asc) rn, java_member.* from java_member
) where rn between 1 and 5;