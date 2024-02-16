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