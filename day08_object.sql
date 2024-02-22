--day08_object.sql
# ORACLE�� ��ü
[1] TABLE
[2] SEQUENCE
[3] VIEW
[4] INDEX
[5] SYNONYM
....
# SEQUENCE
DEPT�� pk�� ���Ǵ� DEPTNO ������ ����� �������� ������
CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 60 -- ���۰�
INCREMENT BY 10 -- ����ġ
MAXVALUE 99 -- �ִ밪
MINVALUE 60
NOCACHE
NOCYCLE; -- �ִ밪 �����ϸ� �ٽ� 60���� ���ư��� X

������ �������� ��ȸ

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'DEPT_DEPTNO_SEQ';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

# ������ ����
- NEXTVAL : �������� �������� ��ȯ
- CURRVAL : �������� ���簪�� ��ȯ
- [���ǻ���] NEXTVAL�� ���� ���� ä�� CURRVAL�� ���� ����� �� ����.

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, 'ȫ����', '��õ');
SELECT * FROM DEPT;

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '������3','����');

SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;

SELECT * FROM BBS;

BBS ���̺�(�Խ���)�� ����� �������� �����ϼ���.
--<1> BBS ���̺�(�Խ���)�� ����� �������� �����ϼ���
--���۰�: n
--����ġ: 1
--�ּҰ�: N
--NOCYCLE
--CACHE n
CREATE SEQUENCE BBS_NO_SEQ
START WITH 7
INCREMENT BY 1
MINVALUE 4
NOCYCLE
NOCACHE;
--<2> BBS�� �������� �̿��ؼ� �Խñ��� �����ϼ���
SELECT * FROM BBS;
INSERT INTO BBS(NO, TITLE, WRITER, CONTENT)
VALUES(BBS_NO_SEQ.NEXTVAL, '��', 'kim', '����');

SELECT LAST_NUMBER FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'BBS_NO_SEQ';

ALTER SEQUENCE BBS_NO_SEQ 
INCREMENT BY 5
MAXVALUE 199
CACHE 20
CYCLE;
SELECT BBS_NO_SEQ.NEXTVAL FROM DUAL;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'DEPT_DEPTNO_SEQ';

SELECT * FROM bbs;
select * from user_constraints where table_name = 'BBS';

# ������ ����
DROP SEQUENCE ��������;

DROP SEQUENCE DEPT_DEPTNO_SEQ;

-------------------------------------------
# VIEW
- ������ ���̺�
- �ַ� PW���� �������� ������� ��� �װ� �����ϰ� �� ����
CREATE [OR REPLACE] VIEW ���̸�
AS
SELECT ��;

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

==> ORA-01031: insufficient privileges ���� �߻�
system/oracle�� �����ؼ�
grant create view to scott; �������

grant create view to scott;

select * from emp20_view;

-- EMP ���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
-- SAL�� SALARY�� �ٲپ� EMP30_VIEW ����
CREATE OR REPLACE VIEW EMP30_VIEW(EMP_NO, NAME, SALARY)
AS
SELECT EMPNO, ENAME, SAL FROM EMP WHERE DEPTNO=30;

UPDATE EMP SET DEPTNO=10 WHERE ENAME = UPPER('ALLEN');

SELECT * FROM EMP30_VIEW;
SELECT * FROM EMP;
UPDATE EMP30_VIEW SET SALARY=1550 WHERE NAME = UPPER('WARD');

�並 �����ϸ� => �����̺� ������
���̺� ���� => �䵵 ������

���� �並 ���� ���ϰ� �Ϸ��� WITH READ ONLY �ɼ��� �ش�

-- �� ���̺��� �� ���� �� ���̰� 19�� �̻���
-- ���� ������ Ȯ���ϴ� �並 ��������.
-- �� ���� �̸��� MEMBER_19VIEW�� �ϼ���.
CREATE OR REPLACE VIEW MEMBER_19VIEW
AS
SELECT * FROM MEMBER WHERE AGE>=19
WITH READ ONLY;

SELECT * FROM MEMBER_19VIEW ORDER BY AGE;

UPDATE MEMBER SET AGE=17 WHERE USERID='id1';

-- MEMBER_19VIEW���� 'id3'�� ȸ���� ���ϸ����� 500�� �ο��ϼ���
UPDATE MEMBER_19VIEW SET MILEAGE=MILEAGE+500 WHERE USERID='id3';

-- ī�װ�, ��ǰ, ���޾�ü�� join�� �並 ���弼��
--���̸� : prod_view
SELECT * FROM PRODUCTS;
SELECT * FROM SUPPLY_COMP;
SELECT * FROM CATEGORY;

CREATE OR REPLACE VIEW PROD_VIEW
AS
SELECT * FROM 
(SELECT * 
FROM CATEGORY C JOIN PRODUCTS P
ON C.CATEGORY_CODE = P.CATEGORY_FK) J LEFT OUTER JOIN SUPPLY_COMP S
ON J.EP_CODE_FK = S.EP_CODE;

SELECT * FROM PROD_VIEW;
SELECT CATEGORY_NAME, PRODUCTS_NAME,OUTPUT_PRICE,EP_NAME
FROM PROD_VIEW;

--JOIN������ ������ ��� �б� �������θ� ��� ����

# with check option
=> where ���� ������ �����ϰ� �����ϵ��� ������

create or replace view emp20vw
as select * from emp
where deptno=20
with check option constraint emp20vw_ck;

select * from emp20vw;

update emp20vw set sal=sal+500 where empno=7369;

update emp20vw set deptno=30 where empno=7369;--����
--ORA-01402: view WITH CHECK OPTION where-clause violation

# ������ ���� ��ȸ
- user_views
- user_objects

select text from user_views where view_name=upper('emp20vw');
select * from user_objects where object_name=upper('emp20vw');

# View ����
drop view ���̸�;

drop view emp20vw;
----------------------------------------
# Index

--������ ��ȸ���ϰ� ������ �󵵡��� ������ �������� �ߺ���
create index �ε����� on ���̺�� (�÷���);

create index emp_ename_indx on emp (ename);
������ �������� ��ȸ
- user_objects
- user_indexes
- user_ind_columns

SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='INDEX' AND OBJECT_NAME = 'EMP_ENAME_INDX';
select * from user_indexes;
select * from user_indexes where table_name='EMP';


CREATE INDEX MEMBER_INDX ON MEMBER (NAME);
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='INDEX' AND OBJECT_NAME = 'MEMBER_INDX';
select * from user_indexes where table_name='MEMBER';
-- ���������� �������� ����

SELECT * FROM MEMBER
WHERE NAME LIKE '%�浿%';

SELECT * FROM PRODUCTS;
--��ǰ ���̺��� �ε����� �ɾ�θ� ���� �÷��� ã�� �ε����� ���弼��.
-- �ܷ�Ű�� ���� -> CATEGORY_FK, EP_CODE_FK
CREATE INDEX PRODUCTS_INDX1 ON PRODUCTS (CATEGORY_FK);
CREATE INDEX PRODUCTS_INDX2 ON PRODUCTS (EP_CODE_FK);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'PRODUCTS';
#�ε��� ����
DROP INDEX �ε�����;

MEMBER_INDX�� �����ϼ���
DROP INDEX MEMBER_INDX;

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-----------------------------------------------------------------
# Synonym -���Ǿ�
����Ŭ ��ü(���̺�, ��, ������, ���ν���..)�� ���� ��Ī (ALIAS)
��ü�� ���� ������ �ǹ�

-- ����â���� ����
--SQL> create user mystar
--  2  identified by mystar;
--SQL> grant connect,resource to mystar;
--SQL> conn mystar/mystar
--SQL> create table note(
--  2  no number(2),
--  3  msg varchar2(30)
--  4  );
--SQL> ed
--Wrote file afiedt.buf
--SQL> insert into note values(1, '�ȳ��ϼ���');
--
--1 row created.
--
--SQL> insert into note values(2, '�ݰ�����');
--
--1 row created.
--
--SQL> grant all on note to scott;
--SQL> conn scott/tiger
--SQL> select * from mystar.note
--SQL> insert into mystar.note values(3, '���� �����̿���');
--SQL> conn system/oracle
--Connected.
--SQL> grant create synonym to scott;
--
--Grant succeeded.
--SQL> conn scott/tiger
--Connected.
--SQL> create synonym A for mystar.note;
- ���Ǿ� ����
CREATE SYNONYM ���Ǿ��̸� FOR ��ü��(��Ű��.���̺��);

�����ͻ������� ��ȸ
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

- ���Ǿ� ����
DROP SYNONYM ���Ǿ��;

DROP SYNONYM A;

SELECT * FROM A;
SELECT * FROM MYSTAR.NOTE;
----------------------------------------
# ���ν��� - crud

# db���� - ���伳��/������/��������, ����ȭ
----------------------------------------
select * from java_member;
commit;

select * from user_sequences;
select * from bbs;
commit;
DROP sequence BBS_NO_SEQ;
delete from bbs where no>7;

SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME = 'BBS_NO_SEQ';