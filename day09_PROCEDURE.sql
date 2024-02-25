-- day09_PROCEDURE.sql
#SQL의 장점과 단점

<장점>
	(1) 사용자가 이해하기 쉬운 단어로 구성
	(2) 쉽게 배울 수 있다.
	(3) 복잡한 로직을 간단하게 작성할 수 있다.
	(4) ANSI에 의해 문법이 표준화되어 있다.

<단점>
	(1) 반복처리를 할 수 없다.(Loop)
	(2) 비교처리를 할 수 없다.(IF)
	(3) Error 처리를 할 수 없다.(예외처리)
	(4) SQL문을 캡슐화 할 수 없다.
	(5) 변수선언을 할 수 없다.
	(6) 실행할 때 마다 분석작업 후 실행
	(7) Network Traffic을 유발한다.

이러한 단점을 극복하기 위해 PL/SQL을 사용
PL/SQL은 SQL로 얻을 수 없는 
절차적 언어의 기능을 가지고 있다.
--PL/SQL : Oracle's Procedual Language extension to SQL

# PL/SQL 사용 이유

1. 반복 처리를 할 수 있다.(Loop)
2. 비교 처리를 할 수 있다.(IF)
3. Error 처리를 할 수 있다.(예외처리)
4. SQL문을 캡슐화 할 수 있다.
   (데이터의 보안 및 무결성)
5. 변수 선언을 할 수 있다.
6. 실행할 때 마다 분석된 결과를 
   실행 만 하기 때문에 성능이 빠르다.
7. Network Traffic이 감소된다.
 여러 sql문장을 block으로 묶고 
 한번에 블럭 전부를 서버로 전송하기
 때문에 통신량을 줄일 수 있다.
----------------------------------------
# 프로시저 - crud

# db설계 - 개념설계/논리설계/물리설계, 정규화
----------------------------------------

PL/SQL을 이용한 프로시저 만들기

[1] 익명 블럭으로 프로시저 생성
[2] 이름을 갖는 프로시저
;--------------------------------------------
set serveroutput on;

DECLARE -- 변수 선언할 거 있을 때만 사용
--선언부
    I_MSG VARCHAR2(100);
    today timestamp;
BEGIN
--실행부
    I_MSG := 'Hello World~'; -- 변수에 값을 할당
    select systimestamp into today from dual;
    dbms_output.put_line(i_msg); -- 변수값 출력
    dbms_output.put_line(today);
END;
/
-------------------------------------------

현재 시간에서 1시간 전과 3시간 후의 시각을 구해 출력하는 프로시저를 작성하세요
;
DECLARE
    now_ timestamp;
    hour1 timestamp;
    hour3 timestamp;
BEGIN
    select systimestamp into now_
    from dual;
    hour1 := now_-1/24;
    hour3 := now_+1/8;
    dbms_output.put_line(hour1);
    dbms_output.put_line(hour3);
END;
/
-------------------------------------------------------
[2] 이름을 갖는 프로시저 생성
java_member 테이블에 데이터를 삽입하는 프로시저를 작성하세요

select * from java_member;
id, pw, name, tel ==> 매개변수 in parameter;


create or replace procedure java_member_add(
    p_id in varchar2,
    p_pw in varchar2,
    p_name in varchar2,
    p_tel in varchar2
)
is
begin
    insert into java_member(id,pw,name,tel)
    values(p_id,p_pw,p_name,p_tel);
    commit;
    dbms_output.put_line(p_name||'님의 정보를 등록했어요');
    --예외처리
    exception
    when dup_val_on_index then
    dbms_output.put_line(p_id||'님의 아이디가 이미 존재합니다 - 등록실패');
end;
/
-----------------------------------------------
EXECUTE JAVA_MEMBER_ADD('CCDD', '222', '김새롬', '010-3452-8556');
EXEC JAVA_MEMBER_ADD('AABB', '333', '최용남', '010-8876-9939');
EXEC JAVA_MEMBER_ADD('hong', '333', '최용남', '010-8876-9939');
SELECT * FROM JAVA_MEMBER;

emp에서 부서번호와 인상률(10, 20)을 인파라미터로 받아서
해당 부서의 사원들의 급여를 10% 인상하는 프로시저를 작성하세요
desc emp;
create or replace procedure EMP_SALUP(
    p_deptno in number,
    p_uprate in number
)
is
begin
    update emp set sal=sal*(1+p_uprate*0.01) where deptno=p_deptno;
--    commit;
    dbms_output.put_line(p_deptno||'번 부서의 급여가 '||p_uprate||'% 만큼 인상됐어요');
end;
/
select * from bbs;
EXEC EMP_SALUP(20, 10);

update emp set sal=sal*(1/1.1) where deptno=20;
commit;


--------------------------------------------------
PL/SQL의 자료형
- scalar
- composite
- reference
- lob

[1] %type 을 이용한 자료형 지정
사번을 인 파라미터로 받아
해당 사원의 이름, 담당업무, 급여를 출력하는 프로시저

CREATE OR REPLACE PROCEDURE EMP_INFO(PNO IN EMP.EMPNO%TYPE)
IS
    VNAME EMP.ENAME%TYPE;
    VJOB EMP.JOB%TYPE;
    VSAL EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, JOB, SAL
    INTO VNAME,VJOB,VSAL
    FROM EMP
    WHERE EMPNO = PNO;
    
    DBMS_OUTPUT.PUT_LINE('사번 : '||PNO);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('업무 : '||VJOB);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSAL);
END;
/

-- DBMS_OUTPUT.PUT_LINE을 하려면 SERVEROUTPUT켜줘야 함
SET SERVEROUTPUT ON
EXEC EMP_INFO(7369);
-----------------------------------------
[2] %ROWTYPE
--상품번호를 IN파라미터로 전달하면
--해당상품 정보(상품명, 판매가, 배송비)를
--가져와 출력하는 프로시저
-----------------------------------------
SELECT * FROM PRODUCTS;
CREATE OR REPLACE PROCEDURE PROD_INFO
(PNO IN PRODUCTS.PNUM%TYPE)
IS
    VPROD PRODUCTS%ROWTYPE; --테이블의 ROW와 같은 타입
BEGIN
    SELECT PRODUCTS_NAME, OUTPUT_PRICE, TRANS_COST
    INTO VPROD.PRODUCTS_NAME, VPROD.OUTPUT_PRICE, VPROD.TRANS_COST
    FROM PRODUCTS WHERE PNUM = PNO;
    
    DBMS_OUTPUT.PUT_LINE(VPROD.PRODUCTS_NAME||' '||VPROD.OUTPUT_PRICE||' '||VPROD.TRANS_COST);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNO||'번 상품은 없습니다');
END;
/
----------------------------
EXEC PROD_INFO(20);

# 복합 데이터 타입
[1] TABLE
[2] RECORD
----------------------------
-- 커서를 사용하면 좋은데 아직 안배워서 테이블 사용
[1] TABLE
- TYPE 테이블타입명 IS TABLE OF 컬럼자료형
  INDEX BY BINARY_INTEGER;
  
  변수명 테이블타입명;
  변수명 BINARY_INTEGER := 기본값
  
--  [실습]
--  부서번호를 인파라미터로 전달하면
--  해당 부서의 사원명, 담당업무를 가져와 출력
------------------------------------------
CREATE OR REPLACE PROCEDURE TABLE_TYPE
(PNO IN EMP.DEPTNO%TYPE)
IS
    --테이블 선언
    TYPE ENAME_ARR IS TABLE OF EMP.ENAME%TYPE
    INDEX BY BINARY_INTEGER;
    
    TYPE JOB_ARR IS TABLE OF EMP.JOB%TYPE
    INDEX BY BINARY_INTEGER;
    
    --테이블 타입의 변수 선언
    ENAME_TAB ENAME_ARR;
    JOB_TAB JOB_ARR;
    I BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT ENAME, JOB FROM EMP WHERE DEPTNO = PNO) LOOP
    I := I+1; -- I 값 증가
    -- 테이블 타입 변수에 결과값 저장
    ENAME_TAB(I) := K.ENAME;
    JOB_TAB(I) := K.JOB;
    END LOOP;
    -- 저장된 값을 출력해보자
    FOR J IN 1 .. I LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(ENAME_TAB(J),12)||RPAD(JOB_TAB(J),10));
    END LOOP;
END;
/
EXEC TABLE_TYPE(20);
------------------------------------
[2] RECORD TYPE
-- JAVA의 CLASS같은 개념
-- 선언
- TYPE 레코드타입명 IS RECORD
  (필드명1 자료형,
   필드명2 자료형, ...)
-- 사용
- 변수명 레코드타입명;

- 레코드타입명.필드명1,... 식으로 사용

--[실습]
--게시판(BBS)의 작성자명을 인 파라미터로 전달하면
--해당 작성자가 쓴 글을 가져와 출력
SELECT * FROM BBS;
CREATE OR REPLACE PROCEDURE REC_TYPE
(PNAME IN BBS.WRITER%TYPE)
IS
    --레코드 타입 선언
    TYPE BBS_REC IS RECORD(
        VNO BBS.NO%TYPE,
        VTITLE BBS.TITLE%TYPE,
        VWRITER BBS.WRITER%TYPE,
        VCONTENT BBS.CONTENT%TYPE,
        VWDATE BBS.WDATE%TYPE
    );
    -- 레코드 타입의 변수 선언
    K BBS_REC;
BEGIN
    SELECT *
    INTO K
    FROM BBS
    WHERE WRITER=PNAME;
    DBMS_OUTPUT.PUT_LINE(RPAD(K.VNO,6)||RPAD(K.VTITLE,20)||RPAD(K.VWRITER,9)||RPAD(K.VCONTENT,30)||K.VWDATE);
    --예외철
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||'님의 글은 없습니다');
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE(PNAME||'님 글은 2건 이상이에요');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('기타 에러 발생');
END;
/

EXEC REC_TYPE('lee');

----------------------------------------------
# 바인드 변수 선언 및 사용

  VAR[IABLE] [variable [NUMBER| CHAR(n)| VARCHAR2(n)]]
  
variable rvar number
-----------------------------------------
declare
begin
  -- 바인드변수 참조할때는 콜론(:)을 앞에 붙인다
  :rvar := 100;
end;
/
-----------------------------------------
print rvar
---------------------------------------
--#FUNCTION - 함수
--반환값이 있을때 함수를 사용한다
--CREATE OR REPLACE FUNCTION 함수명(인파라미터)
--RETURN 반환타입자료형
--IS|AS
--BEGIN
--    실행문
--    RETURN 반환값;
--END;
--/
---------------------------------------
--사원명을 인파라미터로 전달하면
--해당사원의 사번을 반환하는 함수를 구성해보자
CREATE OR REPLACE FUNCTION GET_EMPNO(PNAME IN EMP.ENAME%TYPE)
RETURN EMP.EMPNO%TYPE
IS
    VNO EMP.EMPNO%TYPE;
BEGIN
    SELECT EMPNO
    INTO VNO
    FROM EMP WHERE ENAME=UPPER(PNAME);
    DBMS_OUTPUT.PUT_LINE(PNAME||'님의 사번은 '||VNO||'입니다');
    RETURN VNO;
END;
/
-------------------------------------
함수를 실행하기 위해선 먼저 바인드 변수를 선언한다. (반환값을 받기 위해)
VAR GNO NUMBER;
EXEC :GNO := GET_EMPNO('KING')

PRINT GNO
----------------------------
# 커서
[1] 암시적 커서
[2] 명시적 커서

[1]암시적 커서
--[실습] 사번을 인파라미터로 전달하면
--해당 사원의 급여를 출력하고
--급여를 10% 인상한 뒤, 급여가 인상된 사원수를
--출력하는 프로시저
-------------
CREATE OR REPLACE PROCEDURE IMPLICIT_CR
(PNO IN EMP.EMPNO%TYPE)
IS
    VSAL EMP.SAL%TYPE;
    V_CNT NUMBER;
BEGIN
    SELECT SAL
    INTO VSAL
    FROM EMP WHERE EMPNO = PNO;
    -- 검색한 데이터가 있다면 
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('검색한 데이터가 있어요 급여는 '||VSAL||'입니다');
    END IF;
    UPDATE EMP SET SAL=SAL*1.1 WHERE EMPNO=PNO;
    --암시적 커서 이용해 수정된 행의 수를 저장
    V_CNT := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('급여가 10% 인상된 사원 수는 '||V_CNT||'명 입니다');
END;
/
---------
EXEC IMPLICIT_CR(7788);

SELECT * FROM EMP WHERE EMPNO=7788;
ROLLBACK;
---------------------------
--BBS에 등록된 모든 게시글을 가져와서 NO TITLE WRITER
--출력해서 보여주는 프로시저를 작성하세요
CREATE OR REPLACE PROCEDURE BBS_ALL
IS
    K BBS%ROWTYPE;
BEGIN
    SELECT NO, TITLE, WRITER
    INTO K.NO, K.TITLE, K.WRITER
    FROM BBS ORDER BY NO DESC;
    DBMS_OUTPUT.PUT_LINE(K.NO||' '||K.TITLE||' '||K.WRITER);
END;
/
---------------------------------------------
EXEC BBS_ALL;
==>RUNTIME ERROR 발생
다중행의 결과를 받아오는 경우는 명시적 커서를 이용하든지
FOR루프를 이용하든지...

# 명시적 커서 선언
- CURSOR 커서명 IS
  SELECT문
# 명시적 커서를 이용하여 데이터 꺼내기
<1> 커서 열기 - OPEN 커서명
<2> 데이터 인출 - FETCH 커서명 INTO 변수
<3> 커서 닫기 - CLOSE 커서명
FETCH할 때 반복문이 필요하다 - LOOP문, WHILE LOOP문, FOR LOOP문 등 이용
-----------------------------------------------
CREATE OR REPLACE PROCEDURE BBS_ALL
IS
    K BBS%ROWTYPE;
    -- 커서 선언
    CURSOR BCR IS
    SELECT NO, TITLE, WRITER FROM BBS
    ORDER BY NO DESC;
BEGIN
    --커서 열기
    OPEN BCR;
    --반복문 돌면서 데이터 인출
    LOOP
    --FETCH INTO
    FETCH BCR INTO K.NO, K.TITLE, K.WRITER;
    EXIT WHEN BCR%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(RPAD(K.NO,6)||RPAD(K.TITLE,20)||RPAD(K.WRITER,10));
    END LOOP;
    --커서 닫기
    CLOSE BCR;
END;
/

EXEC BBS_ALL;

--[문제]
--부서별 사원수와 급여 합계, 평균 급여, 최대급여, 최소급여를 구하는 프로시저를 만들어보세요.
CREATE OR REPLACE PROCEDURE DEPT_SAL_CR
IS
    -- 커서 선언
    CURSOR CR IS 
    SELECT DEPTNO, COUNT(EMPNO) CNT, 
    ROUND(AVG(SAL)) AVG_SAL, 
    MAX(SAL) MAX_SAL, 
    MIN(SAL) MIN_SAL 
    FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;
BEGIN
    -- FOR LOOP에서 커서 사용
    FOR K IN CR LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(K.DEPTNO,4)||RPAD(K.CNT,8)||
        RPAD(K.AVG_SAL,8)||RPAD(K.MAX_SAL,8)||RPAD(K.MIN_SAL,8));
    END LOOP;
    --커서 열기
--    OPEN CR;
--    --반복문 돌면서 데이터 인출
--    LOOP
--    --FETCH INTO
--    FETCH CR INTO K.DEPTNO, K.CNT, K.AVG_SAL, K.MAX_SAL, K.MIN_SAL;
--    EXIT WHEN CR%NOTFOUND;
--    DBMS_OUTPUT.PUT_LINE(RPAD(K.DEPTNO,4)||RPAD(K.CNT,8)||RPAD(K.AVG_SAL,8)||RPAD(K.MAX_SAL,8)||RPAD(K.MIN_SAL,8));
--    END LOOP;
--    --커서 닫기
--    CLOSE CR;
END;
/
--------------------------------
EXEC DEPT_SAL_CR
--------------------------------
FOR 변수명 IN 커서명 LOOP
...
END LOOP
==> FOR에서 사용된 변수가 RECORD 타입과 동일
---------------------------------
FOR 변수명 IN (서브쿼리) LOOP
END LOOP; -- 서브쿼리를 이렇게 써주면 커서를 명시적으로 안해도 됨
---------------------------------

DECLARE
BEGIN
    FOR K IN (SELECT * FROM DEPT) LOOP
        DBMS_OUTPUT.PUT_LINE('---------------------------------');
        DBMS_OUTPUT.PUT_LINE(LPAD(K.DEPTNO, 4)||LPAD(K.DNAME,15)||LPAD(K.LOC,12));
    END LOOP;
END;
/
-----------------------------------
--SQL문 이용해서 EMP에서 
--10번 부서 사원이면 '회계부서', 20 '연구부서', 30 '영업부서' 그외 '기타부서'

SELECT EMPNO,ENAME,DEPTNO,
DECODE(DEPTNO,10,'회계부서',20,'연구부서',30,'영업부서','기타부서') "부서명"
FROM EMP ORDER BY DEPTNO;

-------------------------------------------
PL/SQL에서는 IF문 사용 가능
    
    IF 조건1 THEN 실행문;
    ELSIF 조건2 THEN 실행문;
    ELSIF 조건3 THEN 실행문;
    ELSE 실행문;
    END IF;
-------------------------------------------
--사번을 인파라미터로 전달하면
--해당 사원의 부서번호,사원명, 부서명을 가져와 출력하는 프로시저
-------------------------------------------
CREATE OR REPLACE PROCEDURE EMP_INFO
(PNO IN EMP.EMPNO%TYPE)
IS
    VDNO EMP.DEPTNO%TYPE;
    VNAME EMP.ENAME%TYPE;
    VDNAME VARCHAR2(20);
BEGIN
    SELECT DEPTNO, ENAME
    INTO VDNO, VNAME
    FROM EMP WHERE EMPNO=PNO;
    IF VDNO = 10 THEN VDNAME := '회계부서';
    ELSIF VDNO = 20 THEN VDNAME := '연구부서';
    ELSIF VDNO = 30 THEN VDNAME := '영업부서';
    ELSE VDNAME := '기타부서';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(PNO||'번: '||VNAME||'님 부서는 '||VDNAME||'입니다');
END;
/

SELECT * FROM EMP;
EXEC EMP_INFO(7566);


SELECT * FROM bbs WHERE title like '%글%';