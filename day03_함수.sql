--day03_함수.sql
단일행 함수
[1] 문자형 함수
[2] 숫자형 함수
[3] 날짜형 함수
[4] 변환 함수
[5] 기타 함수

#[1] 문자형 함수
<1> LOWER()/UPPER()
-- DUMMY 테이블 : DUAL
SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL;

SELECT * FROM DUAL;
SELECT 8*7 FROM DUAL;

<2> initcap() => 첫 문자만 대문자, 나머지는 소문자

-- dept에서 부서번호, 부서명, 근무지를 조회하되 첫글자만 대문자로 보여주세요
SELECT DEPTNO, INITCAP(DNAME), INITCAP(LOC) FROM DEPT;
SELECT * FROM DEPT;

<3> CONCAT(컬럼1, 컬럼2) : 컬럼1과 컬럼2를 연결
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO, ENAME) A FROM EMP;

SELECT CONCAT(DNAME, INITCAP(LOC)) FROM DEPT;

<4> SUBSTR(변수 또는 컬럼, START, LEN)

SELECT SUBSTR('ABCDEFG', 3, 2) FROM DUAL;
SELECT SUBSTR('ABCDEFG', -3, 2) FROM DUAL;

SELECT SUBSTR('990215-1012345', -7,7) FROM DUAL;
SELECT SUBSTR('990215-1012345', -7) FROM DUAL;
SELECT SUBSTR('990215-1012345', 8,7) FROM DUAL;

<5> LENGTH(변수 또는 컬럼) : 문자열 길이 반환
SELECT LENGTH('990215-1012345') FROM DUAL;

--[문제]
--	 
--	 상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 
--	 붙여서 출력하세요.
SELECT OUTPUT_PRICE||'원' AS "가격" FROM PRODUCTS;
--     고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에
--	       보여주세요.
SELECT CONCAT(NAME, AGE) FROM MEMBER;
--  사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--	  사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요. 
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SUBSTR(ENAME, 1,1)>'K' AND SUBSTR(ENAME, 1,1)<'Y';
--  사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,
--	급여,급여의 자릿수를 출력하세요.
SELECT EMPNO, ENAME, LENGTH(ENAME) AS "이름자릿수", SAL, LENGTH(SAL) AS "급여자릿수" FROM EMP;
--	
--	사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 
--	이름자릿수를 보여주세요.
SELECT ENAME, LENGTH(ENAME) AS "이름자릿수" FROM EMP WHERE LENGTH(ENAME)>=6;


<6> LPAD(컬럼,N,C)/RPAD(컬럼,N,C)

SELECT ENAME, LPAD(ENAME, 10, ' ') "오른쪽정렬" FROM EMP;
SELECT ENAME, RPAD(ENAME, 10, '*') A FROM EMP;

SELECT ENAME, SAL, LPAD(CONCAT('$',SAL), 10, ' ') 급여 FROM EMP;
SELECT RPAD(DNAME, 15, '@') FROM DEPT;


<7> LTRIM(변수,문자)/RTRIM(변수,문자)
:변수 값 중 주어진 문자와 같은 단어가 있을 경우 그 문자를 삭제한 나머지값을 반환

SELECT LTRIM('tttHello test', 't'), RTRIM('tttHello test', 't') FROM DUAL;
SELECT '    오늘의 날씨      ', LENGTH('    오늘의 날씨      ') FROM DUAL;
SELECT LTRIM('    오늘의 날씨      ', ' '), LENGTH(LTRIM('    오늘의 날씨      ', ' ')) FROM DUAL;
SELECT TRIM('    오늘의 날씨      '), LENGTH(TRIM('    오늘의 날씨      ')) FROM DUAL;

<8> REPLACE(컬럼, 값1, 값2)
컬럼값 중에 값1이 있으면 값2로 교체하는 함수
SELECT REPLACE('112312312', '1', '2') FROM DUAL;

EMP에서 JOB에서 'A'를 '$'로 바꾸어 출력
SELECT REPLACE(JOB, 'A', '$') FROM EMP;

--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--	 대학생으로 변경해 출력되게 하세요.
SELECT REPLACE(JOB, '학생', '대학생') FROM MEMBER;
--
--고객 테이블 주소에서 서울시를 서울특별시로 수정하세요.  
SELECT REPLACE(ADDR, '서울시', '서울특별시') FROM MEMBER;
UPDATE MEMBER SET ADDR=REPLACE(ADDR, '서울시', '서울특별시');

SELECT * FROM MEMBER;

ROLLBACK;
--사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--	삭제하고 급여중 우측의 0을 삭제하여 출력하세요.
SELECT RTRIM(JOB, 'T'), RTRIM(SAL, 0), DEPTNO  FROM EMP WHERE DEPTNO=10;

------------------------------------------------------------------------
[2] 숫자형 함수
<1> ROUND(값), ROUND(값1, 값2)

SELECT ROUND(456.678), ROUND(456.678,0),
ROUND(456.678,2), ROUND(456.678,-2) FROM DUAL;

<2> TRUNC(값), TRUNC(X,Y) : 버림 함수, 절삭
SELECT TRUNC(456.678), TRUNC(456.678,0),
TRUNC(456.678,2), TRUNC(456.678,-2) FROM DUAL;

<3> MOD(X,Y): 나머지값을 구하는 함수
SELECT MOD(10,3) FROM DUAL;
<4> ABS(값): 절대값 구하는 함수
SELECT ABS(-9), ABS(9) FROM DUAL;

<5> CEIL(값)/FLOOR(값): 올림함수/내림함수
SELECT CEIL(123.0001), FLOOR(123.0001) FROM DUAL;

-- -회원 테이블에서 회원의 이름, 마일리지, 나이, 마일리지를 나이로 나눈 값을 반올림하여 보여주세요
SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE) "M/A" FROM MEMBER;
--- 상품 테이블의 상품 정보가운데 백원단위까지 버린 배송비를 비교하여 출력하세요.
SELECT TRUNC(TRANS_COST, -3) FROM PRODUCTS;
---사원테이블에서 부서번호가 10인 사원의 급여를 
--	30으로 나눈 나머지를 출력하세요.
SELECT SAL, MOD(SAL,30) FROM EMP WHERE DEPTNO=10;

SELECT CEIL(234.234) FROM DUAL;
SELECT TRUNC(15.79,1) "Truncate" FROM DUAL;

SELECT NAME, AGE, ABS(AGE-40) FROM MEMBER;
-----------------------------------------------------------
[3] 날짜 함수

SELECT SYSDATE, SYSDATE+3, SYSDATE-3, 
TO_CHAR(SYSDATE+3/24, 'YY/MM/DD HH:MI:SS') FROM DUAL;

DATE+(-) 숫자: 일수를 더하거나 뺀다
DATE-DATE: 일수
SELECT NAME, REG_DATE, SYSDATE -REG_DATE "등록 이후 일수" FROM MEMBER;


--[실습]
--	사원테이블에서 현재까지의 근무 일수가 몇 주 몇일인가를 출력하세요.
--	단 근무일수가 많은 사람순으로 출려하세요.
SELECT ENAME, HIREDATE, 
FLOOR((SYSDATE-HIREDATE)/7)||'주'||CEIL(MOD((SYSDATE-HIREDATE),7))||'일' "근무 일수" FROM EMP
ORDER BY HIREDATE;

<1> months_between(date1, date2)
:두 날짜 사이의 월수를 구함
정수 부분 => 월, 소수 구분 =>일

select ename, months_between(sysdate, hiredate) from emp
order by 2 desc;

SELECT NAME, REG_DATE, MONTHS_BETWEEN(SYSDATE,REG_DATE) FROM MEMBER;

<2> ADD_MONTHS: 월을 더함
SELECT ADD_MONTHS(SYSDATE, 5) "5개월 뒤", ADD_MONTHS(SYSDATE, -3) "석달전" FROM DUAL;

SELECT ADD_MONTHS('22/07/31', 2) FROM DUAL;

<3> LAST_DAY(DATE): 월의 마지막 날짜를 구함
SELECT LAST_DAY(SYSDATE), LAST_DAY('23/02/03') FROM DUAL;

<4> SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'CC YEAR-MONTH-DDD DY') FROM DUAL;
-------------------------------------------------------
[4] 변환 함수
<1> TO_CHAR(날짜)
<2> TO_DATE(문자)
<3> TO_CHAR(숫자)
<4> TO_NUMBER(문자)

--- 고객테이블의 등록일자를 0000-00-00 의 형태로 출력하세요.
SELECT TO_CHAR(REG_DATE, 'YYYY-MM-DD') FROM MEMBER;
---  고객테이블에 있는 고객 정보 중 등록연도가 2023년인 
--	 고객의 정보를 보여주세요.
SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE, 'YYYY')=2023;
--- 고객테이블에 있는 고객 정보 중 등록일자가 2023년 5월1일보다 
--	 늦은 정보를 출력하세요. 
--	 단, 고객등록 정보는 년, 월만 보이도록 합니다.
SELECT NAME, AGE, JOB, TO_CHAR(REG_DATE, 'YY/MM') FROM MEMBER WHERE REG_DATE>'23/05/01';

# TO_DATE(문자,포맷): 문자열을 DATE유형으로 변환하는 함수

SELECT TO_DATE('22-08-19', 'YY-MM-DD')+3 FROM DUAL;
-- SELECT '22-08-19'+3 FROM DUAL;(X)
SELECT SYSDATE - TO_DATE('20191107', 'YYYYMMDD') FROM DUAL;

# TO_CHAR(숫자, 포맷)
SELECT TO_CHAR(1500000, 'L9,999,999') FROM DUAL;

SELECT TO_CHAR(100, '$9999') FROM DUAL;
SELECT TO_CHAR(7, 'RM') FROM DUAL;


--73] 상품 테이블에서 상품의 공급 금액을 가격 표시 방법으로 표시하세요.
--	  천자리 마다 , 를 표시합니다
SELECT TO_CHAR(INPUT_PRICE, '9,999,999') FROM PRODUCTS;
--  74] 상품 테이블에서 상품의 판매가를 출력하되 주화를 표시할 때 사용하는 방법을
--	  사용하여 출력하세요.[예: \10,000]
SELECT TO_CHAR(OUTPUT_PRICE, 'L9,999,999') "판매가" FROM PRODUCTS;
SELECT TO_CHAR(OUTPUT_PRICE, 'C9,999,999') "판매가" FROM PRODUCTS;

# TO_NUMBER(문자, 포맷): CHAR, VARCHAR2를 숫자로 변환
SELECT TO_NUMBER('150,000', '999,999') * 2 FROM DUAL;

'$450.25'의 3배값을 구하세요
SELECT TO_NUMBER('$450.25', '$999D99')*3 FROM DUAL;

SELECT TO_CHAR(-23, 'S99') FROM DUAL;
SELECT TO_CHAR(-23, '99S'), TO_CHAR(-23, '99.99EEEE') FROM DUAL;

---------------------------------------------------------------
# 그룹 함수
: 여러 행 또는 테이블 전체에 함수가 적용되어 하나의 결과를 가져오는 함수를 의미
<1> COUNT(컬럼명) : NULL값을 무시하고 카운트를 센다
    COUNT(*) : NULL값도 포함하여 카운트를 센다
    SELECT * FROM EMP;
    SELECT COUNT(MGR) "관리자가 있는 사원 수", COUNT(COMM) "보너스를 받는 사원 수" FROM EMP;
    SELECT COUNT(DISTINCT MGR) "관리자수" FROM EMP;
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

--[실습]
--		 emp테이블에서 모든 SALESMAN에 대하여 급여의 평균,
--		 최고액,최저액,합계를 구하여 출력하세요.
SELECT ROUND(AVG(SAL)), MAX(SAL), MIN(SAL), SUM(SAL) FROM EMP WHERE JOB='SALESMAN';
SELECT * FROM EMP WHERE JOB='SALESMAN';
--         EMP테이블에 등록되어 있는 인원수, 보너스에 NULL이 아닌 인원수,
--		보너스의 평균,등록되어 있는 부서의 수를 구하여 출력하세요.
SELECT COUNT(*), COUNT(COMM), AVG(COMM), COUNT(DISTINCT DEPTNO) FROM EMP;

어순: WGHO 순서 WHERE - GROUP BY - HAVING - ORDER BY
# GROUP BY 절

SELECT JOB, COUNT(*) FROM MEMBER GROUP BY JOB ORDER BY COUNT(*) DESC;
--17] 고객 테이블에서 직업의 종류, 각 직업에 속한 최대 마일리지 정보를 보여주세요.
SELECT JOB, MAX(MILEAGE) FROM MEMBER GROUP BY JOB ORDER BY MAX(MILEAGE);
--18] 상품 테이블에서 각 상품카테고리별로 총 몇 개의 상품이 있는지 보여주세요.
SELECT CATEGORY_FK, COUNT(*) FROM PRODUCTS GROUP BY CATEGORY_FK ORDER BY COUNT(*),CATEGORY_FK;
--19] 상품 테이블에서 각 공급업체 코드별로 공급한 상품의 평균입고가를 보여주세요.
SELECT EP_CODE_FK, ROUND(AVG(INPUT_PRICE)) FROM PRODUCTS GROUP BY EP_CODE_FK ORDER BY AVG(INPUT_PRICE);


--문제1] 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
SELECT TO_CHAR(HIREDATE, 'YYYY') AS YEAR, COUNT(*) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY') ORDER BY TO_CHAR(HIREDATE, 'YYYY');
--	문제2] 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
SELECT TO_CHAR(HIREDATE, 'YYYY-MM'), COUNT(*) FROM EMP GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM') ORDER BY TO_CHAR(HIREDATE, 'YYYY-MM');
--	문제3] 사원 테이블에서 업무별 최대 연봉, 최소 연봉을 출력하세요.
SELECT JOB, MAX(SAL*12+NVL(COMM,0)) "최대 연봉", MIN(SAL*12+NVL(COMM,0)) "최소 연봉" FROM EMP GROUP BY JOB ORDER BY JOB;

HAVING

SELECT JOB, COUNT(*) FROM MEMBER GROUP BY JOB HAVING COUNT(*)>1;

--21] 고객 테이블에서 직업의 종류와 각 직업에 속한 최대 마일리지 정보를 보여주세요.
--	      단, 직업군의 최대 마일리지가 0인 경우는 제외시킵시다. 
SELECT JOB, MAX(MILEAGE) FROM MEMBER GROUP BY JOB HAVING MAX(MILEAGE)<>0;   
--문제2] 상품 테이블에서 각 공급업체 코드별로 상품 판매가의 평균값 중 단위가 100단위로 떨어
--	      지는 항목의 정보를 보여주세요.
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
