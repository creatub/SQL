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