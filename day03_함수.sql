--day03_�Լ�.sql
������ �Լ�
[1] ������ �Լ�
[2] ������ �Լ�
[3] ��¥�� �Լ�
[4] ��ȯ �Լ�
[5] ��Ÿ �Լ�

#[1] ������ �Լ�
<1> LOWER()/UPPER()
-- DUMMY ���̺� : DUAL
SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL;

SELECT * FROM DUAL;
SELECT 8*7 FROM DUAL;

<2> initcap() => ù ���ڸ� �빮��, �������� �ҹ���

-- dept���� �μ���ȣ, �μ���, �ٹ����� ��ȸ�ϵ� ù���ڸ� �빮�ڷ� �����ּ���
SELECT DEPTNO, INITCAP(DNAME), INITCAP(LOC) FROM DEPT;
SELECT * FROM DEPT;

<3> CONCAT(�÷�1, �÷�2) : �÷�1�� �÷�2�� ����
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO, ENAME) A FROM EMP;

SELECT CONCAT(DNAME, INITCAP(LOC)) FROM DEPT;

<4> SUBSTR(���� �Ǵ� �÷�, START, LEN)

SELECT SUBSTR('ABCDEFG', 3, 2) FROM DUAL;
SELECT SUBSTR('ABCDEFG', -3, 2) FROM DUAL;

SELECT SUBSTR('990215-1012345', -7,7) FROM DUAL;
SELECT SUBSTR('990215-1012345', -7) FROM DUAL;
SELECT SUBSTR('990215-1012345', 8,7) FROM DUAL;

<5> LENGTH(���� �Ǵ� �÷�) : ���ڿ� ���� ��ȯ
SELECT LENGTH('990215-1012345') FROM DUAL;

--[����]
--	 
--	 ��ǰ ���̺��� �ǸŰ��� ȭ�鿡 ������ �� �ݾ��� ������ �Բ� 
--	 �ٿ��� ����ϼ���.
SELECT OUTPUT_PRICE||'��' AS "����" FROM PRODUCTS;
--     �����̺��� �� �̸��� ���̸� �ϳ��� �÷����� ����� ������� ȭ�鿡
--	       �����ּ���.
SELECT CONCAT(NAME, AGE) FROM MEMBER;
--  ��� ���̺��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� �����
--	  ���,�̸�,����,�޿��� ����ϼ���. �� �̸������� �����ϼ���. 
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SUBSTR(ENAME, 1,1)>'K' AND SUBSTR(ENAME, 1,1)<'Y';
--  ������̺��� �μ��� 20���� ����� ���,�̸�,�̸��ڸ���,
--	�޿�,�޿��� �ڸ����� ����ϼ���.
SELECT EMPNO, ENAME, LENGTH(ENAME) AS "�̸��ڸ���", SAL, LENGTH(SAL) AS "�޿��ڸ���" FROM EMP;
--	
--	������̺��� ����̸� �� 6�ڸ� �̻��� �����ϴ� ������̸��� 
--	�̸��ڸ����� �����ּ���.
SELECT ENAME, LENGTH(ENAME) AS "�̸��ڸ���" FROM EMP WHERE LENGTH(ENAME)>=6;


<6> LPAD(�÷�,N,C)/RPAD(�÷�,N,C)

SELECT ENAME, LPAD(ENAME, 10, ' ') "����������" FROM EMP;
SELECT ENAME, RPAD(ENAME, 10, '*') A FROM EMP;

SELECT ENAME, SAL, LPAD(CONCAT('$',SAL), 10, ' ') �޿� FROM EMP;
SELECT RPAD(DNAME, 15, '@') FROM DEPT;


<7> LTRIM(����,����)/RTRIM(����,����)
:���� �� �� �־��� ���ڿ� ���� �ܾ ���� ��� �� ���ڸ� ������ ���������� ��ȯ

SELECT LTRIM('tttHello test', 't'), RTRIM('tttHello test', 't') FROM DUAL;
SELECT '    ������ ����      ', LENGTH('    ������ ����      ') FROM DUAL;
SELECT LTRIM('    ������ ����      ', ' '), LENGTH(LTRIM('    ������ ����      ', ' ')) FROM DUAL;
SELECT TRIM('    ������ ����      '), LENGTH(TRIM('    ������ ����      ')) FROM DUAL;

<8> REPLACE(�÷�, ��1, ��2)
�÷��� �߿� ��1�� ������ ��2�� ��ü�ϴ� �Լ�
SELECT REPLACE('112312312', '1', '2') FROM DUAL;

EMP���� JOB���� 'A'�� '$'�� �ٲپ� ���
SELECT REPLACE(JOB, 'A', '$') FROM EMP;

--�� ���̺��� ������ �ش��ϴ� �÷����� ���� ������ �л��� ������ ���
--	 ���л����� ������ ��µǰ� �ϼ���.
SELECT REPLACE(JOB, '�л�', '���л�') FROM MEMBER;
--
--�� ���̺� �ּҿ��� ����ø� ����Ư���÷� �����ϼ���.  
SELECT REPLACE(ADDR, '�����', '����Ư����') FROM MEMBER;
UPDATE MEMBER SET ADDR=REPLACE(ADDR, '�����', '����Ư����');

SELECT * FROM MEMBER;

ROLLBACK;
--������̺��� 10�� �μ��� ����� ���� ������ �� ������'T'��
--	�����ϰ� �޿��� ������ 0�� �����Ͽ� ����ϼ���.
SELECT RTRIM(JOB, 'T'), RTRIM(SAL, 0), DEPTNO  FROM EMP WHERE DEPTNO=10;

------------------------------------------------------------------------
[2] ������ �Լ�
<1> ROUND(��), ROUND(��1, ��2)

SELECT ROUND(456.678), ROUND(456.678,0),
ROUND(456.678,2), ROUND(456.678,-2) FROM DUAL;

<2> TRUNC(��), TRUNC(X,Y) : ���� �Լ�, ����
SELECT TRUNC(456.678), TRUNC(456.678,0),
TRUNC(456.678,2), TRUNC(456.678,-2) FROM DUAL;

<3> MOD(X,Y): ���������� ���ϴ� �Լ�
SELECT MOD(10,3) FROM DUAL;
<4> ABS(��): ���밪 ���ϴ� �Լ�
SELECT ABS(-9), ABS(9) FROM DUAL;

<5> CEIL(��)/FLOOR(��): �ø��Լ�/�����Լ�
SELECT CEIL(123.0001), FLOOR(123.0001) FROM DUAL;

-- -ȸ�� ���̺��� ȸ���� �̸�, ���ϸ���, ����, ���ϸ����� ���̷� ���� ���� �ݿø��Ͽ� �����ּ���
SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE) "M/A" FROM MEMBER;
--- ��ǰ ���̺��� ��ǰ ������� ����������� ���� ��ۺ� ���Ͽ� ����ϼ���.
SELECT TRUNC(TRANS_COST, -3) FROM PRODUCTS;
---������̺��� �μ���ȣ�� 10�� ����� �޿��� 
--	30���� ���� �������� ����ϼ���.
SELECT SAL, MOD(SAL,30) FROM EMP WHERE DEPTNO=10;

SELECT CEIL(234.234) FROM DUAL;
SELECT TRUNC(15.79,1) "Truncate" FROM DUAL;

SELECT NAME, AGE, ABS(AGE-40) FROM MEMBER;
-----------------------------------------------------------
[3] ��¥ �Լ�

SELECT SYSDATE, SYSDATE+3, SYSDATE-3, 
TO_CHAR(SYSDATE+3/24, 'YY/MM/DD HH:MI:SS') FROM DUAL;

DATE+(-) ����: �ϼ��� ���ϰų� ����
DATE-DATE: �ϼ�
SELECT NAME, REG_DATE, SYSDATE -REG_DATE "��� ���� �ϼ�" FROM MEMBER;


--[�ǽ�]
--	������̺��� ��������� �ٹ� �ϼ��� �� �� �����ΰ��� ����ϼ���.
--	�� �ٹ��ϼ��� ���� ��������� ����ϼ���.
SELECT ENAME, HIREDATE, 
FLOOR((SYSDATE-HIREDATE)/7)||'��'||CEIL(MOD((SYSDATE-HIREDATE),7))||'��' "�ٹ� �ϼ�" FROM EMP
ORDER BY HIREDATE;

<1> months_between(date1, date2)
:�� ��¥ ������ ������ ����
���� �κ� => ��, �Ҽ� ���� =>��

select ename, months_between(sysdate, hiredate) from emp
order by 2 desc;

SELECT NAME, REG_DATE, MONTHS_BETWEEN(SYSDATE,REG_DATE) FROM MEMBER;

<2> ADD_MONTHS: ���� ����
SELECT ADD_MONTHS(SYSDATE, 5) "5���� ��", ADD_MONTHS(SYSDATE, -3) "������" FROM DUAL;

SELECT ADD_MONTHS('22/07/31', 2) FROM DUAL;

<3> LAST_DAY(DATE): ���� ������ ��¥�� ����
SELECT LAST_DAY(SYSDATE), LAST_DAY('23/02/03') FROM DUAL;

<4> SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'CC YEAR-MONTH-DDD DY') FROM DUAL;
-------------------------------------------------------
[4] ��ȯ �Լ�
<1> TO_CHAR(��¥)
<2> TO_DATE(����)
<3> TO_CHAR(����)
<4> TO_NUMBER(����)

--- �����̺��� ������ڸ� 0000-00-00 �� ���·� ����ϼ���.
SELECT TO_CHAR(REG_DATE, 'YYYY-MM-DD') FROM MEMBER;
---  �����̺� �ִ� �� ���� �� ��Ͽ����� 2023���� 
--	 ���� ������ �����ּ���.
SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE, 'YYYY')=2023;
--- �����̺� �ִ� �� ���� �� ������ڰ� 2023�� 5��1�Ϻ��� 
--	 ���� ������ ����ϼ���. 
--	 ��, ����� ������ ��, ���� ���̵��� �մϴ�.
SELECT NAME, AGE, JOB, TO_CHAR(REG_DATE, 'YY/MM') FROM MEMBER WHERE REG_DATE>'23/05/01';

# TO_DATE(����,����): ���ڿ��� DATE�������� ��ȯ�ϴ� �Լ�

SELECT TO_DATE('22-08-19', 'YY-MM-DD')+3 FROM DUAL;
-- SELECT '22-08-19'+3 FROM DUAL;(X)
SELECT SYSDATE - TO_DATE('20191107', 'YYYYMMDD') FROM DUAL;

# TO_CHAR(����, ����)
SELECT TO_CHAR(1500000, 'L9,999,999') FROM DUAL;

SELECT TO_CHAR(100, '$9999') FROM DUAL;
SELECT TO_CHAR(7, 'RM') FROM DUAL;


--73] ��ǰ ���̺��� ��ǰ�� ���� �ݾ��� ���� ǥ�� ������� ǥ���ϼ���.
--	  õ�ڸ� ���� , �� ǥ���մϴ�
SELECT TO_CHAR(INPUT_PRICE, '9,999,999') FROM PRODUCTS;
--  74] ��ǰ ���̺��� ��ǰ�� �ǸŰ��� ����ϵ� ��ȭ�� ǥ���� �� ����ϴ� �����
--	  ����Ͽ� ����ϼ���.[��: \10,000]
SELECT TO_CHAR(OUTPUT_PRICE, 'L9,999,999') "�ǸŰ�" FROM PRODUCTS;
SELECT TO_CHAR(OUTPUT_PRICE, 'C9,999,999') "�ǸŰ�" FROM PRODUCTS;

# TO_NUMBER(����, ����): CHAR, VARCHAR2�� ���ڷ� ��ȯ
SELECT TO_NUMBER('150,000', '999,999') * 2 FROM DUAL;

'$450.25'�� 3�谪�� ���ϼ���
SELECT TO_NUMBER('$450.25', '$999D99')*3 FROM DUAL;

SELECT TO_CHAR(-23, 'S99') FROM DUAL;
SELECT TO_CHAR(-23, '99S'), TO_CHAR(-23, '99.99EEEE') FROM DUAL;

---------------------------------------------------------------
# �׷� �Լ�
: ���� �� �Ǵ� ���̺� ��ü�� �Լ��� ����Ǿ� �ϳ��� ����� �������� �Լ��� �ǹ�
<1> COUNT(�÷���) : NULL���� �����ϰ� ī��Ʈ�� ����
    COUNT(*) : NULL���� �����Ͽ� ī��Ʈ�� ����
    SELECT * FROM EMP;
    SELECT COUNT(MGR) "�����ڰ� �ִ� ��� ��", COUNT(COMM) "���ʽ��� �޴� ��� ��" FROM EMP;
    SELECT COUNT(DISTINCT MGR) "�����ڼ�" FROM EMP;
    SELECT COUNT(EMPNO) FROM EMP;
    SELECT COUNT(*) FROM EMP;

SELECT AVG(DISTINCT COMM) FROM EMP;

CREATE TABLE TEST(
A NUMBER(2),
B CHAR(3),
C VARCHAR2(10)
);
DESC TEST;
SELECT COUNT(*) FROM TEST;

INSERT INTO TEST VALUES(NULL, NULL, NULL);
SELECT * FROM TEST;

SELECT COUNT(A) FROM TEST;
SELECT COUNT(*) FROM TEST;
COMMIT;

--[�ǽ�]
--		 emp���̺��� ��� SALESMAN�� ���Ͽ� �޿��� ���,
--		 �ְ��,������,�հ踦 ���Ͽ� ����ϼ���.
SELECT ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), SUM(SAL) FROM EMP WHERE JOB='SALESMAN';
SELECT * FROM EMP WHERE JOB='SALESMAN';
--         EMP���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���,
--		���ʽ��� ���,��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����ϼ���.
SELECT COUNT(*), COUNT(COMM), AVG(COMM), COUNT(DISTINCT DEPTNO) FROM EMP;

���: WGHO ���� WHERE - GROUP BY - HAVING - ORDER BY
# GROUP BY ��

SELECT JOB, COUNT(*) FROM MEMBER GROUP BY JOB ORDER BY COUNT(*) DESC;
--17] �� ���̺��� ������ ����, �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
SELECT JOB, MAX(MILEAGE) FROM MEMBER GROUP BY JOB ORDER BY MAX(MILEAGE);
--18] ��ǰ ���̺��� �� ��ǰī�װ����� �� �� ���� ��ǰ�� �ִ��� �����ּ���.
SELECT CATEGORY_FK, COUNT(*) FROM PRODUCTS GROUP BY CATEGORY_FK ORDER BY COUNT(*),CATEGORY_FK;
--19] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ������ ��ǰ�� ����԰��� �����ּ���.
SELECT EP_CODE_FK, ROUND(AVG(INPUT_PRICE)) FROM PRODUCTS GROUP BY EP_CODE_FK ORDER BY AVG(INPUT_PRICE);


--����1] ��� ���̺��� �Ի��� �⵵���� ��� ���� �����ּ���.
SELECT TO_CHAR(HIREDATE, 'YYYY') AS YEAR, COUNT(*) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY') ORDER BY TO_CHAR(HIREDATE, 'YYYY');
--	����2] ��� ���̺��� �ش�⵵ �� ������ �Ի��� ������� �����ּ���.
SELECT TO_CHAR(HIREDATE, 'YYYY-MM'), COUNT(*) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM') ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--	����3] ��� ���̺��� ������ �ִ� ����, �ּ� ������ ����ϼ���.
SELECT JOB, MAX(SAL*12+NVL(COMM,0)) "�ִ� ����", MIN(SAL*12+NVL(COMM,0)) "�ּ� ����" FROM EMP GROUP BY JOB ORDER BY JOB;

HAVING

SELECT JOB, COUNT(*) FROM MEMBER GROUP BY JOB HAVING COUNT(*)>1;

--21] �� ���̺��� ������ ������ �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
--	      ��, �������� �ִ� ���ϸ����� 0�� ���� ���ܽ�ŵ�ô�. 
SELECT JOB, MAX(MILEAGE) FROM MEMBER GROUP BY JOB HAVING MAX(MILEAGE)<>0;   
--����2] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ��ǰ �ǸŰ��� ��հ� �� ������ 100������ ����
--	      ���� �׸��� ������ �����ּ���.
SELECT EP_CODE_FK, AVG(OUTPUT_PRICE) FROM PRODUCTS GROUP BY EP_CODE_FK HAVING MOD(AVG(OUTPUT_PRICE), 100)=0;



CREATE TABLE if not exists java_member(id varchar2(20) primary key,
			pw varchar2(10) not null,
			name varchar2(30) not null,
			tel varchar2(15),
			indate date default sysdate);
            
create table naver_member(id varchar2(10) primary key);
drop table naver_member;



select * from java_member;

SELECT COUNT(*) AS count FROM java_member WHERE id = 'kim';
SELECT COUNT(*) AS count FROM java_member WHERE id = 'lojr';

DELETE FROM java_member WHERE ID = '123';
DELETE FROM java_member WHERE ID = '123';
commit;
