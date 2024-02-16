-- 단문 주석 처리
/**
    여러 라인 주석 처리
*/

select count(*) from tab;
select * from tab;
select * from dept;
select * from emp;
select * from salgrade;
select * from category;
select * from products;
select * from member;
select * from supply_comp;

-- day01.sql

--학생테이블
create table student(
    no number(4) primary key, -- unique + not null
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    sclass varchar2(30),
    sroom number(3)
);

desc student;
insert into student (no, name, tel)
values(1, '이철수', '010-2222-3333')
commit; -- commit을 해야 데이터에 영구히 저장된다.
-- 오라클은 수동 commit, mysql은 auto commit
select * from student;
-- c: create ==> insert
-- r: read   ==> select
-- u: update ==> update
-- d: delete ==> delete


-- 2 김영희 연락처 주소 '백엔드개발자반' 201
insert into student(no, name, tel, addr, scalss, sroom)
values(3, '김길동', '010-0535-2347', '서울시 강동구', '백엔드개발자반', 201);
select * from student;
commit;
rollback;

delete from student where no=4;


--프런트 개발자반 학생 2명 정보를 insert 하세요
--202호
--컬럼명을 생략하고 insert할 때는 테이블을 create했을 때 만든 컬럼순서대로 입력해야함
insert into student(no, name, tel, scalss, sroom)
values(5, '손광희', '010-3861-9945', '프론트엔드개발자반', 202);
select * from student;

commit;

--1번 학생의 주소, 학급, 교실번호를 수정합시다
--update 테이블명 set 컬럼명1=값, 컬럼명2=값2 where 조건절
update student set addr='서울시 강남구', scalss='백엔드개발자반', sroom=201 where no=1;
rollback;

select * from student where scalss='백엔드개발자반';
select * from student where sroom=201;

--학생 테이블을 삭제하고 다시 만들어보자
--drop table 테이블명
drop table student;
select * from student;

--학급 테이블 생성
--테이블명: sclass
--학급번호(snum) number(4) primary key
--학급명(sname) varchar2(30)
--교실번호(sroom) number(3)
create table sclass(
    snum number(4) primary key,
    sname varchar2(30) not null,
    sroom number(3)
);

create table student(
    no number(4) primary key,
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    snum_fk number(4) references sclass(snum)
    
);
select * from student;

insert into sclass(snum,sname,sroom)
values(10,'백엔드 개발자반', 201);

insert into sclass
values(20,'프런트엔드 개발자반', 202);

insert into sclass
values(30,'빅데이터반',203);
select * from sclass;

insert into student(no,name,addr,tel,snum_fk)
values(1,'이철수','서울 마포구','010-1111-2222',10);

insert into student(no,name,addr,tel,snum_fk)
values(2,'김철수','서울 강서구','010-4551-2657',20);
select * from student;

--join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;
--10번 학급 학생정보 3명 등록
--20번 학급 학생정보 3명 등록
--30번 학급 학생정보 1명 등록
--
--insert, update, delete

insert into student(no,name,addr,tel,snum_fk)
values(8,'오함마','경기 광주시','010-5555-5060',30);

select sclass.*, student.*
from sclass join student
on sclass.snum = student.snum_fk;

update student set addr='경기 오산시' where no=8;
select * from student;

delete from student where no=2;
select * from student;