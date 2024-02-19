--day04_join.sql

DEPT�� EMP�� JOIN
[1] EQUI JOIN (INNER JOIN, NATURAL JOIN)

<1> OLD VERSION
SELECT EMP.DEPTNO, DNAME, EMPNO, ENAME, JOB
FROM DEPT, EMP
WHERE DEPT.DEPTNO = EMP.DEPTNO
ORDER BY EMP.DEPTNO ASC;

<2> NEW VERSION - ����� JOIN�� �̿� (ǥ�� SQL)
SELECT D.*, E.*
FROM DEPT D LEFT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO;
--[�ǽ�]
--	 SALESMAN�� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����Ͽ���.
SELECT E.EMPNO,E.ENAME,E.JOB,E.SAL,E.DEPTNO,D.LOC
FROM EMP E JOIN DEPT D 
ON E.DEPTNO=D.DEPTNO WHERE E.JOB='SALESMAN';
--     ���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--	      �̸��� ��ǰ �̸��� �Բ� �����ּ���.
SELECT c.category_name, p.products_name, OUTPUT_PRICE
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = p.category_fk
ORDER BY CATEGORY_CODE;
--     ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--	      ������ü(COMPANY)�� �Ｚ�� ��ǰ�� ������ �����Ͽ� 
--          ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--	      ������ ���� ������ ȭ�鿡 �����ּ���.
SELECT C.CATEGORY_NAME, P.PRODUCTS_NAME, P.OUTPUT_PRICE, P.COMPANY
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = p.category_fk
WHERE COMPANY ='�Ｚ';
--
--	�� ��ǰ���� ī�װ� �� ��ǰ��, ������ ����ϼ���. �� ī�װ��� 'TV'�� ���� 
--	      �����ϰ� ������ ������ ��ǰ�� ������ ������ ������ �����ϼ���.

SELECT C.CATEGORY_NAME, P.PRODUCTS_NAME, P.OUTPUT_PRICE
FROM CATEGORY C JOIN PRODUCTS P
ON c.category_code = p.category_fk
WHERE C.CATEGORY_NAME!='TV'
ORDER BY P.OUTPUT_PRICE;

[2] NON-EQUI JOIN
- '='�� �ƴ� �����ȣ�� ����Ͽ� �����ϴ� ���

 SELECT * FROM SALGRADE;
 SELECT * FROM EMP;
 
 ��������� �����ֵ� ���, �̸�, ����, �޿�, �޿� ���, �޿������ ��������, �޿������ �ְ����� �Բ� �����ּ���
 
 SELECT EMPNO, ENAME, JOB, SAL, GRADE, LOSAL, HISAL
 FROM EMP E JOIN SALGRADE S
 ON E.SAL BETWEEN S.LOSAL AND S.HISAL
 ORDER BY SAL DESC;
 
 
[3] OUTER JOIN
- ���� ���̺� ��ġ�ϴ� ���� ������ �ٸ��� ���̺��� NULL�� �Ͽ� ���� ������

<1> OLD VERSION
SELECT D.*, ENAME, E.DEPTNO
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO(+) ORDER BY 1;

<2> LEFT OUTER JOIN / RIGHT OUTER JOIN / FULL OUTER JOIN
-- LEFT OUTER JOIN
SELECT D.DEPTNO, DNAME, ENAME, E.DEPTNO, SAL
FROM DEPT D LEFT JOIN EMP E
ON D.DEPTNO = E.DEPTNO ORDER BY 1;

SELECT E.*, D.*
FROM EMP E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- RIGHT OUTER JOIN
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E RIGHT JOIN DEPT D
ON E.DEPTNO = D.DEPTNO ORDER BY 1;

-- FULL OUTER JOIN
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E FULL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO ORDER BY 1;

--����98] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ���޾�ü�ڵ�, ��ǰ�̸�, 
--      ��ǰ���ް�, ��ǰ �ǸŰ� ������ ����ϵ� ���޾�ü�� ����
--      ��ǰ�� ����ϼ���(��ǰ�� ��������).
SELECT EP_NAME, EP_CODE, PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE 
FROM SUPPLY_COMP S RIGHT JOIN PRODUCTS P
ON S.EP_CODE = P.EP_CODE_FK ORDER BY 1;

SELECT EP_NAME, EP_CODE, PRODUCTS_NAME, INPUT_PRICE, OUTPUT_PRICE 
FROM PRODUCTS P, SUPPLY_COMP S
WHERE P.EP_CODE_FK = S.EP_CODE(+) ORDER BY 1;
--
--	����99] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ī�װ���, ��ǰ��, ��ǰ�ǸŰ�
--		������ ����ϼ���. ��, ���޾�ü�� ��ǰ ī�װ��� ���� ��ǰ��
--		����մϴ�.
SELECT EP_NAME, CATEGORY_NAME, PRODUCTS_NAME, OUTPUT_PRICE
FROM SUPPLY_COMP S RIGHT JOIN PRODUCTS P
ON S.EP_CODE = P.EP_CODE_FK LEFT JOIN CATEGORY C
ON P.CATEGORY_FK = C.CATEGORY_CODE;

SELECT * FROM CATEGORY;

[4] SELF JOIN
- �ڱ��ڽ��� ���̺�� JOIN�ϴ� ���

SELECT E.EMPNO, E.ENAME, E.MGR "MGR NO", M.ENAME "MGR NAME" 
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

--    [����] emp���̺��� "������ �����ڴ� �����̴�"�� ������ ����ϼ���.
SELECT E.ENAME||'�� �����ڴ� '||M.ENAME||'�̴�.' 
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

[5] CARTESIAN PRODUCT �Ǵ� CROSS JOIN
- ��� ����� ���� ==> ���ʿ��� �����Ͱ� ����
- ���� ������ ������ ���

SELECT D.DEPTNO, DNAME, E.DEPTNO, ENAME
FROM DEPT D, EMP E ORDER BY 1 ASC, 3 ASC;
--=> DEPT�� 4�� �� X EMP�� 14�� �� ==> 56���� ���� ��µ�

[6] ���� ������ - SET OPERATOR
--SELECT �÷���1,... FROM TABLE1
--SET OPERATOR
--SELECT �÷���1,... FROM TABLE2

<1> UNION / UNION ALL : ������
--UNION: �ߺ��Ǵ� ���� �ѹ��� ���
SELECT DEPTNO FROM DEPT 
UNION
SELECT DEPTNO FROM EMP;

--UNION ALL: ��� ������ ������
SELECT DEPTNO FROM DEPT 
UNION ALL
SELECT DEPTNO FROM EMP;

=> DEPT�� 4�� + EMP�� 14�� => 18�� �� ���

<2> ������ (INTERSECT)
SELECT DEPTNO FROM DEPT
INTERSECT
SELECT DEPTNO FROM EMP;

<3> ������ (MINUS)
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

--[����]
--
---  emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
--    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.
SELECT ENAME, JOB, SAL, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE LOC ='NEW YORK';

SELECT ENAME, JOB, SAL, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND D.LOC='NEW YORK';
--- EMP���̺��� ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ�
--    SELECT���� �ۼ��ϼ���.
SELECT ENAME, E.DEPTNO, LOC, COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE COMM IS NOT NULL;

SELECT ENAME, E.DEPTNO, LOC, COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
AND COMM IS NOT NULL;
--
--- EMP���̺��� �̸� �� L�ڰ� �ִ� ����� ���� �̸�,����,�μ���,��ġ�� 
--   ����ϴ� ������ �ۼ��ϼ���.
SELECT ENAME, JOB, E.DEPTNO, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME LIKE '%L%';
--
--- �Ʒ��� ����� ����ϴ� ������ �ۼ��Ͽ���(�����ڰ� ���� King�� �����Ͽ�
--	��� ����� ���)
SELECT E.ENAME "EMPLOYEE", E.EMPNO "EMP#", NVL(M.ENAME, ' ') Manager, NVL(TO_CHAR(M.EMPNO), ' ') "MGR#"
FROM EMP E LEFT OUTER JOIN EMP M
ON E.MGR = M.EMPNO
ORDER BY M.EMPNO DESC;
--	---------------------------------------------
--	Emplyee		Emp#		Manager	Mgr#
--	---------------------------------------------
--	KING		7839
--	BLAKE		7698		KING		7839
--	CKARK		7782		KING		7839
--	.....
--	---------------------------------------------
--	14ROWS SELECTED.

