--day06_DDL.sql

-- CREATE TABLE [schema.]table_name => schema는 scott. system. 등 사용자 이름 (테이블 소유자)

DDL (DATA DEFINITION LANGUAGE)
- CREATE, ALTER, DROP, RENAME, TRUNCATE

# CREATE문
[1] PRIMARY KEY 제약 조건
<1> 컬럼 수준
    CREATE TABLE TEST_TAB1(
        ID NUMBER(2) CONSTRAINT TEST_TAB1_ID_PK PRIMARY KEY, -- 컬럼수준의 제약
        NAME VARCHAR2(10)        
    );
    
    DESC TEST_TAB1;
    
    데이터 사전에서 조회
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB1';

<2> 테이블 수준
    CREATE TABLE TEST_TAB2(
        ID NUMBER(2),
        NAME VARCHAR2(10),
        --테이블 수준의 제약
        CONSTRAINT TEST_TAB2_ID_PK PRIMARY KEY (ID)
    );
    
    SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB2';
--    
--# 제약조건 삭제
--    ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명
--    
--# 제약조건 추가
--    ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건유형 (컬럼명)
--    
--# 제약조건명 변경
--    ALTER TABLE 테이블명 RENAME CONSTRAINT OLD_제약조건명 TO NEW_제약조건명
    
--- TEST_TAB2의 TEST_TAB2_ID_PK 제약조건을 삭제하세요
ALTER TABLE TEST_TAB2 DROP CONSTRAINT TEST_TAB2_ID_PK;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TEST_TAB2';
--- TEST_TAB2에 NAME 컬럼에 PRIMARY 제약조건을 추가하세요
ALTER TABLE TEST_TAB2 ADD CONSTRAINT TEST_TAB2_NAME_PK PRIMARY KEY (NAME);
--- TEST_TAB2에 NAME 컬럼에 준 제약조건명을 변경하세요
ALTER TABLE TEST_TAB2 RENAME CONSTRAINT TEST_TAB2_NAME_PK TO TEST_TAB2_NAME_PK_NEW;

INSERT INTO TEST_TAB1(ID, NAME)
VALUES(2, '김철수');
COMMIT;
SELECT * FROM TEST_TAB1;

--PK==> UNIQUE + NOT NULL
-------------------------------------------------------------
[2] FOREIGN KEY (외래키)

부모 테이블 - MASTER TABLE
DEPT_TAB
CREATE TABLE DEPT_TAB(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(15),
    LOC VARCHAR2(50),
    CONSTRAINT DEPT_TAB_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

SELECT * FROM DEPT_TAB;

자식 테이블 - DETAIL TABLE
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

--데이터사전에서 조회
select * from user_constraints where table_name='EMP_TAB';
dept_tab에 데이터 삽입
10 '인사부' '서울'
20 '기획부' '세종'
insert into dept_tab values(10, '인사부', '서울');
insert into dept_tab values(20, '기획부', '세종');
select * from dept_tab;
commit;
emp_tab에 데이터 넣기
10번부서에 2명
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1000,'홍길동','manager',null,sysdate, 5000,10);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1001,'김철수','clerk',1000,sysdate, 4000,10);
select * from emp_tab;
commit;
20번부서에 1명
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1002,'김수연','analyst',1000,sysdate, 4000,10);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1003,'최연호','analyst',1001,sysdate, 4000,20);
insert into emp_tab(empno, ename, job, mgr, hiredate, sal, deptno)
values(1004,'호치민','operator',1001,sysdate, 3000,20);
commit;
select * from emp_tab;
dept_tab 20번 부서 삭제
delete from dept_tab where deptno=20;--이럼 오류남
--자식 레코드가 하나라도 있으면 삭제 ㄴㄴ함
-- 자식 레코드를 수정하던지 삭제하던지 한 후 해줘야함
==> child record found
외래키로 참조되는 자식 레코드가 있을 경우 부모 레코드는 삭제 불가
emp_tab에서 20번 부서 직원들의 부서번호를 10번으로 수정하세요
update emp_tab set deptno=10 where deptno=20;
select * from emp_tab;
commit;
delete from dept_tab where deptno=20;
select * from dept_tab;


SELECT * FROM EMP_TAB;

/*
게시판 테이블
bbs
no number(4) pk
title varchar2(200) not null
writer ===> java_member테이블의 id를 참조하도록 하되 on delete cascade 옵션을 주어 fk를 주자
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
--게시글 2개 삽입하세요

insert into bbs(no, title, writer, content)
values(1,'처음 쓰는 글','hong','오늘 처음 글을 써요');

insert into bbs(no, title, writer, content)
values(2,'두번째 쓰는 글','haha','하하 호호 히히');

insert into bbs(no, title, writer, content)
values(3,'오늘도 반가워요','hong','오늘 즐겁게');

--hong 아이디 회원을 삭제하세요
delete from java_member where id='hong';

select * from java_member; -- 'hong' 삭제
select * from bbs;
rollback;


[3] UNIQUE 제약조건
- 유일한 값을 갖도록 제한
- NULL은 허용된다

CREATE TABLE UNI_TAB(
    DEPTNO NUMBER(2) CONSTRAINT UNI_TAB_DEPTNO_UK UNIQUE,
    DNAME CHAR(14),
    LOC CHAR(10)
);

INSERT INTO UNI_TAB
VALUES(10,'노무부','서울');

INSERT INTO UNI_TAB
VALUES(NULL, '총무부', '서울');


SELECT * FROM UNI_TAB2;
COMMIT;

CREATE TABLE UNI_TAB2(
    DEPTNO NUMBER(2),
    DNAME CHAR(14),
    LOC CHAR(10),
    CONSTRAINT UNI_TAB2_DEPTNO_UK UNIQUE(DEPTNO)
);

데이터 사전에서 조회
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='UNI_TAB2';
--------------------------------------------------------
[4] NOT NULL
- NULL값을 허용하지 않음
- 컬럼 수준에서만 제약 가능

CREATE TABLE NN_TAB(
    DEPTNO NUMBER(2) CONSTRAINT NN_TAB_DEPTNO_NN NOT NULL,
    DNAME CHAR(14)
);
INSERT INTO NN_TAB VALUES(1,'인사부');
INSERT INTO NN_TAB VALUES(NULL, '인사부'); -- 오류

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='NN_TAB';

[5] CHECK 제약 조건
- 행이 만족해야할 조건을 기술

CREATE TABLE CK_TAB(
    DEPTNO NUMBER(2) CONSTRAINT CK_TAB_DEPTNO_CK CHECK (DEPTNO>10 AND DEPTNO <=20),
    DNAME CHAR(16)
);
INSERT INTO CK_TAB VALUES(20, '기획부');
INSERT INTO CK_TAB VALUES(23, '기획부'); -- 오류
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
VALUES(123,345,'서울시 강북구');
SELECT * FROM ZIPCODE;

INSERT INTO MEMBER_TAB
VALUES(1, '홍길동', 'M', '960506', '1284505', '010-4958-2492', 123, 456, '서울시 강남구');

# SUBQUERY를 이용한 테이블 생성
--
--CREATE TABLE 테이블명(컬럼명1...)
--AS 
--SUBQUERY

--EMP에서 30번 부서에 근무하는 사원정보만 가져와서
--EMP_30 테이블을 생성하세요

CREATE TABLE EMP_30
AS 
SELECT * FROM EMP WHERE DEPTNO=30;

CREATE TABLE EMP_30(ENO, ENAME, JOB, HDATE, SAL, COMM, DNO) 
AS 
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, DEPTNO 
FROM EMP WHERE DEPTNO=30;

SELECT * FROM EMP_30;
DESC EMP_30;

--[문제1]
--		EMP테이블에서 부서별로 인원수,평균 급여, 급여의 합, 최소 급여,
--		최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
SELECT * FROM EMP;
CREATE TABLE EMP_DEPTNO(DEPTNO, NUM_PEOPLE, SAL_AVG, SAL_SUM, SAL_MIN, SAL_MAX)
AS
SELECT DEPTNO, COUNT(EMPNO), ROUND(AVG(SAL)), SUM(SAL), MIN(SAL), MAX(SAL) 
FROM EMP GROUP BY DEPTNO;
--		
--[문제2]	EMP테이블에서 사번,이름,업무,입사일자,부서번호만 포함하는
--		EMP_TEMP 테이블을 생성하는데 자료는 포함하지 않고 구조만
--		생성하여라.
CREATE TABLE EMP_TEMP
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, DEPTNO FROM EMP
WHERE 1=0;

--=======================================================
# 컬럼 추가/변경/ 삭제
[1] 컬럼 추가
ALTER TABLE 테이블명 ADD 추가할 컬럼정보(컬럼명 자료형 기본값)
[2] 컬럼 정보 수정
ALTER TABLE 테이블명 MODIFY 수정할 컬럼정보
[3] 컬럼명 수정
ALTER TABLE 테이명 RENAME COLUMN OLD_컬럼명 TO NEW_컬럼명;
[4] 컬럼 삭제
ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명
;
CREATE TABLE SAMPLE_TAB(
    NO NUMBER(4)
);
DESC SAMPLE_TAB;

-- <1> SAMPLE_TAB에 NAME VARCHAR2(20) 추가하세요
ALTER TABLE SAMPLE_TAB ADD(NAME VARCHAR2(20));

DESC SAMPLE_TAB;

<2> NO컬럼의 자료형을 CHAR(4)로 변경하세요
ALTER TABLE SAMPLE_TAB MODIFY (NO CHAR(4));
ALTER TABLE SAMPLE_TAB MODIFY NAME VARCHAR2(20) NOT NULL;

DESC SAMPLE_TAB;

<3> NO 컬럼명을 NUM으로 수정하세요
ALTER TABLE SAMPLE_TAB RENAME COLUMN NO TO NUM;

DESC SAMPLE_TAB;
<4> NAME 컬럼을 삭제하세요
ALTER TABLE SAMPLE_TAB DROP COLUMN NAME;

DESC SAMPLE_TAB;

# 테이블 이름 변경
RENAME OLD_NAME TO NEW_NAME;

SAMPLE_TAB 테이블명을 TEMP_TAB으로 변경하세요;

RENAME SAMPLE_TAB TO TEMP_TAB;

# 테이블 삭제
DROP TABLE 테이블 [CASCADE CONSTRAINT];

SELECT * FROM TAB;
select * from bbs;
SELECT no,title,writer,content FROM bbs WHERE title like '%처음%';

TEMP_TAB을 삭제하세요
DROP TABLE TEMP_TAB;