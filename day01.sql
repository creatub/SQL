-- �ܹ� �ּ� ó��
/**
    ���� ���� �ּ� ó��
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

--�л����̺�
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
values(1, '��ö��', '010-2222-3333')
commit; -- commit�� �ؾ� �����Ϳ� ������ ����ȴ�.
-- ����Ŭ�� ���� commit, mysql�� auto commit
select * from student;
-- c: create ==> insert
-- r: read   ==> select
-- u: update ==> update
-- d: delete ==> delete


-- 2 �迵�� ����ó �ּ� '�鿣�尳���ڹ�' 201
insert into student(no, name, tel, addr, scalss, sroom)
values(3, '��浿', '010-0535-2347', '����� ������', '�鿣�尳���ڹ�', 201);
select * from student;
commit;
rollback;

delete from student where no=4;


--����Ʈ �����ڹ� �л� 2�� ������ insert �ϼ���
--202ȣ
--�÷����� �����ϰ� insert�� ���� ���̺��� create���� �� ���� �÷�������� �Է��ؾ���
insert into student(no, name, tel, scalss, sroom)
values(5, '�ձ���', '010-3861-9945', '����Ʈ���尳���ڹ�', 202);
select * from student;

commit;

--1�� �л��� �ּ�, �б�, ���ǹ�ȣ�� �����սô�
--update ���̺�� set �÷���1=��, �÷���2=��2 where ������
update student set addr='����� ������', scalss='�鿣�尳���ڹ�', sroom=201 where no=1;
rollback;

select * from student where scalss='�鿣�尳���ڹ�';
select * from student where sroom=201;

--�л� ���̺��� �����ϰ� �ٽ� ������
--drop table ���̺��
drop table student;
select * from student;

--�б� ���̺� ����
--���̺��: sclass
--�б޹�ȣ(snum) number(4) primary key
--�б޸�(sname) varchar2(30)
--���ǹ�ȣ(sroom) number(3)
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
values(10,'�鿣�� �����ڹ�', 201);

insert into sclass
values(20,'����Ʈ���� �����ڹ�', 202);

insert into sclass
values(30,'�����͹�',203);
select * from sclass;

insert into student(no,name,addr,tel,snum_fk)
values(1,'��ö��','���� ������','010-1111-2222',10);

insert into student(no,name,addr,tel,snum_fk)
values(2,'��ö��','���� ������','010-4551-2657',20);
select * from student;

--join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;
--10�� �б� �л����� 3�� ���
--20�� �б� �л����� 3�� ���
--30�� �б� �л����� 1�� ���
--
--insert, update, delete

insert into student(no,name,addr,tel,snum_fk)
values(8,'���Ը�','��� ���ֽ�','010-5555-5060',30);

select sclass.*, student.*
from sclass join student
on sclass.snum = student.snum_fk;

update student set addr='��� �����' where no=8;
select * from student;

delete from student where no=2;
select * from student;