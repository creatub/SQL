--day06_DDL.sql

-- CREATE TABLE [schema.]table_name => schema�� scott. system. �� ����� �̸� (���̺� ������)

DDL (DATA DEFINITION LANGUAGE)
- CREATE, ALTER, DROP, RENAME, TRUNCATE

# CREATE��
[1] PRIMARY KEY ���� ����
<1> �÷� ����
    CREATE TABLE TEST_TAB1(
        ID NUMBER(2) CONSTRAINT TEST_TAB1_ID_PK PRIMARY KEY, -- �÷������� ����
        NAME VARCHAR2(10)        
    );
    
    DESC TEST_TAB1;
    
    ������ �������� ��ȸ
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB1';

<2> ���̺� ����
    CREATE TABLE TEST_TAB2(
        ID NUMBER(2),
        NAME VARCHAR2(10),
        --���̺� ������ ����
        CONSTRAINT TEST_TAB2_ID_PK PRIMARY KEY (ID)
    );
    
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB2';
--    
--# �������� ����
--    ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�
--    
--# �������� �߰�
--    ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ������������ (�÷���)
--    
--# �������Ǹ� ����
--    ALTER TABLE ���̺�� RENAME CONSTRAINT OLD_�������Ǹ� TO NEW_�������Ǹ�
    
--- TEST_TAB2�� TEST_TAB2_ID_PK ���������� �����ϼ���
ALTER TABLE TEST_TAB2 DROP CONSTRAINT TEST_TAB2_ID_PK;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB2';
--- TEST_TAB2�� NAME �÷��� PRIMARY ���������� �߰��ϼ���
ALTER TABLE TEST_TAB2 ADD CONSTRAINT TEST_TAB2_NAME_PK PRIMARY KEY (NAME);
--- TEST_TAB2�� NAME �÷��� �� �������Ǹ��� �����ϼ���
ALTER TABLE TEST_TAB2 RENAME CONSTRAINT TEST_TAB2_NAME_PK TO TEST_TAB2_NAME_PK_NEW;

INSERT INTO TEST_TAB1(ID, NAME)
VALUES(2, '��ö��');
COMMIT;
SELECT * FROM TEST_TAB1;

--PK==> UNIQUE + NOT NULL
-------------------------------------------------------------
[2] FOREIGN KEY (�ܷ�Ű)

�θ� ���̺� - MASTER TABLE
DEPT_TAB
CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(50),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

SELECT * FROM DEPT_TAB;

�ڽ� ���̺� - DETAIL TABLE
EMP_TAB
CREATE TABLE EMP_TAB(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(10),
  
    MGR NUMBER(4) CONSTRAINT EMP_TAB_MGR_FK /*FOREIGN KEY*/ REFERENCES EMP_TAB(EMPNO),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2),

    CONSTRAINT EMP_TAB_DEPTNO_FK FOREIGN KEY(DEPTNO)
    REFERENCES DEPT_TAB(DEPTNO),
    CONSTRAINT EMP_TAB_EMPNO_PK PRIMARY KEY(EMPNO)
);

--�����ͻ������� ��ȸ
select * from user_constraints where table_name='EMP_TAB';
dept_tab�� ������ ����
10 '�λ��' '����'
20 '��ȹ��' '����'
insert into dept_tab values(10, '�λ��', '����');
insert into dept_tab values(20, '��ȹ��', '����');
select * from dept_tab;
commit;
emp_tab�� ������ �ֱ�
10���μ��� 2��
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1000,'ȫ�浿','manager',null,sysdate, 5000,10);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1001,'��ö��','clerk',1000,sysdate, 4000,10);
select * from emp_tab;
commit;
20���μ��� 1��
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1002,'�����','analyst',1000,sysdate, 4000,10);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1003,'�ֿ�ȣ','analyst',1001,sysdate, 4000,20);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1004,'ȣġ��','operator',1001,sysdate, 3000,20);
commit;
select * from emp_tab;
dept_tab 20�� �μ� ����
delete from dept_tab where deptno=20;--�̷� ������
--�ڽ� ���ڵ尡 �ϳ��� ������ ���� ������
-- �ڽ� ���ڵ带 �����ϴ��� �����ϴ��� �� �� �������
==> child record found
�ܷ�Ű�� �����Ǵ� �ڽ� ���ڵ尡 ���� ��� �θ� ���ڵ�� ���� �Ұ�
emp_tab���� 20�� �μ� �������� �μ���ȣ�� 10������ �����ϼ���
update emp_tab set deptno=10 where deptno=20;
select * from emp_tab;
commit;
delete from dept_tab where deptno=20;
select * from dept_tab;


SELECT * FROM EMP_TAB;

/*
�Խ��� ���̺�
bbs
no number(4) pk
title varchar2(200) not null
writer ===> java_member���̺��� id�� �����ϵ��� �ϵ� on delete cascade �ɼ��� �־� fk�� ����
content varchar2(2000),
wdate date default sysdate
*/
CREATE TABLE BBS(
     NO NUMBER(4) CONSTRAINT BBS_NO_PK PRIMARY KEY,
     TITLE VARCHAR2(200) NOT NULL,
     WRITER VARCHAR2(200) CONSTRAINT BBS_WRITER_FK REFERENCES java_member(id) on delete cascade,
     CONTENT VARCHAR2(200),
     WDATE DATE DEFAULT SYSDATE
);
delete * from bbs;
drop table bbs;
commit;
select * from bbs;
SELECT * FROM java_member;
commit;
--�Խñ� 2�� �����ϼ���

insert into bbs(no, title, writer, content)
values(1,'ó�� ���� ��','hong','���� ó�� ���� ���');

insert into bbs(no, title, writer, content)
values(2,'�ι�° ���� ��','haha','���� ȣȣ ����');

insert into bbs(no, title, writer, content)
values(3,'���õ� �ݰ�����','hong','���� ��̰�');

--hong ���̵� ȸ���� �����ϼ���
delete from java_member where id='hong';

select * from java_member; -- 'hong' ����
select * from bbs;
rollback;


[3] UNIQUE ��������
- ������ ���� ������ ����
- NULL�� ���ȴ�

CREATE TABLE UNI_TAB(
    DEPTNO NUMBER(2) CONSTRAINT UNI_TAB_DEPTNO_UK UNIQUE,
    DNAME CHAR(14),
    LOC CHAR(10)
);

INSERT INTO UNI_TAB
VALUES(10,'�빫��','����');

INSERT INTO UNI_TAB
VALUES(NULL, '�ѹ���', '����');


SELECT * FROM UNI_TAB2;
COMMIT;

CREATE TABLE UNI_TAB2(
    DEPTNO NUMBER(2),
    DNAME CHAR(14),
    LOC CHAR(10),
    CONSTRAINT UNI_TAB2_DEPTNO_UK UNIQUE(DEPTNO)
);

������ �������� ��ȸ
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='UNI_TAB2';
--------------------------------------------------------
[4] NOT NULL
- NULL���� ������� ����
- �÷� ���ؿ����� ���� ����

CREATE TABLE NN_TAB(
    DEPTNO NUMBER(2) CONSTRAINT NN_TAB_DEPTNO_NN NOT NULL,
    DNAME CHAR(14)
);
INSERT INTO NN_TAB VALUES(1,'�λ��');
INSERT INTO NN_TAB VALUES(NULL, '�λ��'); -- ����

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='NN_TAB';

[5] CHECK ���� ����
- ���� �����ؾ��� ������ ���

CREATE TABLE CK_TAB(
    DEPTNO NUMBER(2) CONSTRAINT CK_TAB_DEPTNO_CK CHECK (DEPTNO>10 AND DEPTNO <=20),
    DNAME CHAR(16)
);
INSERT INTO CK_TAB VALUES(20, '��ȹ��');
INSERT INTO CK_TAB VALUES(23, '��ȹ��'); -- ����
SELECT * FROM CK_TAB;
--------------------------------------------------------------------
CREATE TABLE ZIPCODE(
    POST1 CHAR(3),
    POST2 CHAR(3),
    ADDR VARCHAR2(60) CONSTRAINT ZIPCODE_ADDR_NN NOT NULL,
    CONSTRAINT ZIPCODE_POST_PK PRIMARY KEY(POST1, POST2)
);

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'ZIPCODE';

CREATE TABLE MEMBER_TAB(
    ID NUMBER(4,0) CONSTRAINT MEMBER_TAB_ID_PK PRIMARY KEY,
    NAME VARCHAR2(10),
    GENDER CHAR(1) CONSTRAINT MEMBER_TAB_GENDER_CK CHECK (GENDER IN ('F','M')),
    JUMIN1 CHAR(6),
    JUMIN2 CHAR(7),
    TEL VARCHAR2(15),
    POST1 CHAR(3),
    POST2 CHAR(3),
    ADDR VARCHAR2(60),
    CONSTRAINT MEMBER_TAB_JUMIN_UK UNIQUE (JUMIN1, JUMIN2),
    CONSTRAINT MEMBER_TAB_POST_FK FOREIGN KEY(POST1, POST2) 
    REFERENCES ZIPCODE(POST1,POST2)
);


INSERT INTO ZIPCODE(POST1, POST2, ADDR)
VALUES(123,345,'����� ���ϱ�');
SELECT * FROM ZIPCODE;

INSERT INTO MEMBER_TAB
VALUES(1, 'ȫ�浿', 'M', '960506', '1284505', '010-4958-2492', 123, 456, '����� ������');

# SUBQUERY�� �̿��� ���̺� ����
--
--CREATE TABLE ���̺��(�÷���1...)
--AS 
--SUBQUERY

--EMP���� 30�� �μ��� �ٹ��ϴ� ��������� �����ͼ�
--EMP_30 ���̺��� �����ϼ���

CREATE TABLE EMP_30
AS 
SELECT * FROM EMP WHERE DEPTNO=30;

CREATE TABLE EMP_30(ENO, ENAME, JOB, HDATE, SAL, COMM, DNO) 
AS 
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO 
FROM EMP WHERE DEPTNO=30;

SELECT * FROM EMP_30;
DESC EMP_30;

--[����1]
--		EMP���̺��� �μ����� �ο���,��� �޿�, �޿��� ��, �ּ� �޿�,
--		�ִ� �޿��� �����ϴ� EMP_DEPTNO ���̺��� �����϶�.
SELECT * FROM EMP;
CREATE TABLE EMP_DEPTNO(DEPTNO, NUM_PEOPLE, SAL_AVG, SAL_SUM, SAL_MIN, SAL_MAX)
AS
SELECT DEPTNO, COUNT(EMPNO), ROUND(AVG(SAL)), SUM(SAL), MIN(SAL), MAX(SAL) 
FROM EMP GROUP BY DEPTNO;
--		
--[����2]	EMP���̺��� ���,�̸�,����,�Ի�����,�μ���ȣ�� �����ϴ�
--		EMP_TEMP ���̺��� �����ϴµ� �ڷ�� �������� �ʰ� ������
--		�����Ͽ���.
CREATE TABLE EMP_TEMP
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO FROM EMP
WHERE 1=0;

--=======================================================
# �÷� �߰�/����/ ����
[1] �÷� �߰�
ALTER TABLE ���̺�� ADD �߰��� �÷�����(�÷��� �ڷ��� �⺻��)
[2] �÷� ���� ����
ALTER TABLE ���̺�� MODIFY ������ �÷�����
[3] �÷��� ����
ALTER TABLE ���̸� RENAME COLUMN OLD_�÷��� TO NEW_�÷���;
[4] �÷� ����
ALTER TABLE ���̺�� DROP COLUMN ������ �÷���
;
CREATE TABLE SAMPLE_TAB(
    NO NUMBER(4)
);
DESC SAMPLE_TAB;

-- <1> SAMPLE_TAB�� NAME VARCHAR2(20) �߰��ϼ���
ALTER TABLE SAMPLE_TAB ADD(NAME VARCHAR2(20));

DESC SAMPLE_TAB;

<2> NO�÷��� �ڷ����� CHAR(4)�� �����ϼ���
ALTER TABLE SAMPLE_TAB MODIFY (NO CHAR(4));
ALTER TABLE SAMPLE_TAB MODIFY NAME VARCHAR2(20) NOT NULL;

DESC SAMPLE_TAB;

<3> NO �÷����� NUM���� �����ϼ���
ALTER TABLE SAMPLE_TAB RENAME COLUMN NO TO NUM;

DESC SAMPLE_TAB;
<4> NAME �÷��� �����ϼ���
ALTER TABLE SAMPLE_TAB DROP COLUMN NAME;

DESC SAMPLE_TAB;

# ���̺� �̸� ����
RENAME OLD_NAME TO NEW_NAME;

SAMPLE_TAB ���̺���� TEMP_TAB���� �����ϼ���;

RENAME SAMPLE_TAB TO TEMP_TAB;

# ���̺� ����
DROP TABLE ���̺� [CASCADE CONSTRAINT];

SELECT * FROM TAB;
select * from bbs;
SELECT no,title,writer,content FROM bbs WHERE title like '%ó��%';

TEMP_TAB�� �����ϼ���
DROP TABLE TEMP_TAB;