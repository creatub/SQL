--day05_subquery.sql

SELECT * 
FROM EMP 
WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');

[1] 단일행 SUBQUERY
--문제2]사원테이블에서 급여의 평균보다 적은 사원의 사번,이름
--	업무,급여,부서번호를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
WHERE SAL<(SELECT AVG(SAL) FROM EMP);

--[문제 3]사원테이블에서 사원의 급여가 20번 부서의 최소급여
----		보다 많은 부서를 출력하세요.
SELECT *
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20);

SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20);

[2] 다중행 SUBQUERY
- 한 개 이상의 행을 반환하는 서브쿼리
- 다중행 서브쿼리 연산자가 별도로 있다
    <1> IN
    <2> ANY
    <3> ALL
    <4> EXISTS
- 업무별로 최대 급여를 받는 사원의 사원번호와 이름을 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL IN(
SELECT MAX(SAL)
FROM EMP
GROUP BY JOB);

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE (JOB, SAL) IN(
SELECT JOB, MAX(SAL)
FROM EMP
GROUP BY JOB);

-ANY 연산자
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO <> 20
AND SAL > ANY(SELECT SAL FROM EMP WHERE JOB='SALESMAN');

=> 서브 쿼리 결과 값 중 어느 하나 값이라도 만족하면 결과를 반환한다.

SELECT ENAME, SAL FROM EMP
WHERE DEPTNO <> 20
AND SAL > (SELECT MIN(SAL) FROM EMP WHERE JOB='SALESMAN');

- ALL 연산자

SELECT ENAME, SAL FROM EMP
WHERE DEPTNO <> 20
AND SAL > ALL(SELECT SAL FROM EMP WHERE JOB='SALESMAN');

=> 서브쿼리 결과값 중 모든 결과값이 만족돼야만 결과값을 반환

SELECT ENAME, SAL FROM EMP
WHERE DEPTNO <> 20
AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN');

-------------------------------------------------------------
-EXISTS 연산자
 : 서브쿼리 결과 데이터가 존재하는지 여부를 따져서 존재하는 값들만 결과로 반환함
 
 예제)사원을 관리할 수 있는 사원의 정보를 보여 줍니다.
 SELECT EMPNO, ENAME, JOB 
 FROM EMP E
 WHERE EXISTS (
    SELECT EMPNO FROM EMP 
    WHERE E.EMPNO = MGR
 );
 
 -------------------------------
 [3] 다중열 SUBQUERY
-- 실습] 업무별로 최소 급여를 받는 사원의 사번,이름,업무,부서번호를
--		   출력하세요. 단 업무별로 정렬하세요.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL FROM EMP
WHERE (JOB,SAL) IN (SELECT JOB, MIN(SAL) FROM EMP GROUP BY JOB)
ORDER BY JOB;

#1. SELECT문에서 서브쿼리
--84] 고객 테이블에 있는 고객 정보 중 마일리지가 
--	가장 높은 금액의 고객 정보를 보여주세요.
SELECT * FROM MEMBER 
WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER);
--
--	85] 상품 테이블에 있는 전체 상품 정보 중 상품의 판매가격이 
--	    판매가격의 평균보다 큰  상품의 목록을 보여주세요. 
--	    단, 평균을 구할 때와 결과를 보여줄 때의 판매 가격이
--	    50만원을 넘어가는 상품은 제외시키세요.
SELECT * FROM PRODUCTS 
WHERE OUTPUT_PRICE<=500000 
AND OUTPUT_PRICE > (SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS WHERE OUTPUT_PRICE<=500000);

--	
--	86] 상품 테이블에 있는 판매가격에서 평균가격 이상의 상품 목록을 구하되 평균을
--	    구할 때 판매가격이 최대인 상품을 제외하고 평균을 구하세요.
SELECT * FROM PRODUCTS 
WHERE OUTPUT_PRICE>(
    SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS 
    WHERE OUTPUT_PRICE!=(SELECT MAX(OUTPUT_PRICE) FROM PRODUCTS)
);
SELECT * FROM PRODUCTS;
#2. UPDATE에서 SUBQUERY
--89] 고객 테이블에 있는 고객 정보 중 마일리지가 가장 높은 금액을
--	     가지는 고객에게 보너스 마일리지 5000점을 더 주는 SQL을 작성하세요.
UPDATE MEMBER SET MILEAGE = MILEAGE+5000
WHERE USERID IN (SELECT USERID FROM MEMBER WHERE MILEAGE=(SELECT MAX(MILEAGE) FROM MEMBER)); 

--
--90] 고객 테이블에서 마일리지가 없는 고객의 등록일자를 고객 테이블의 
--	      등록일자 중 가장 뒤에 등록한 날짜에 속하는 값으로 수정하세요.
UPDATE MEMBER SET REG_DATE = (SELECT MAX(REG_DATE) FROM MEMBER)
WHERE MILEAGE = 0;
ROLLBACK;
SELECT * FROM MEMBER;

#3. DELETE에서 SUBQUERY
--DELETE FROM 테이블명 WHERE 조건절
--91] 상품 테이블에 있는 상품 정보 중 공급가가 가장 큰 상품은 삭제 시키는 
--	      SQL문을 작성하세요.
SELECT * FROM PRODUCTS;
ROLLBACK;
DELETE FROM PRODUCTS WHERE INPUT_PRICE = (SELECT MAX(INPUT_PRICE) FROM PRODUCTS);      
--
--	92] 상품 테이블에서 상품 목록을 공급 업체별로 정리한 뒤,
--	     각 공급업체별로 최소 판매 가격을 가진 상품을 삭제하세요.
DELETE FROM PRODUCTS 
WHERE (EP_CODE_FK, OUTPUT_PRICE) IN (
    SELECT EP_CODE_FK, MIN(OUTPUT_PRICE) FROM PRODUCTS
    GROUP BY EP_CODE_FK
);
