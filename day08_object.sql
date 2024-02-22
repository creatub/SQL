--day08_object.sql
# ORACLE의 객체
[1] TABLE
[2] SEQUENCE
[3] VIEW
[4] INDEX
[5] SYNONYM
....
# SEQUENCE
DEPT의 pk로 사용되는 DEPTNO 값으로 사용할 시퀀스를 만들어보자
CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 60 -- 시작값
INCREMENT BY 10 -- 증가치
MAXVALUE 99 -- 최대값
MINVALUE 60
NOCACHE
NOCYCLE; -- 최대값 도달하면 다시 60으로 돌아가지 X

데이터 사전에서 조회

SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'DEPT_DEPTNO_SEQ';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

# 시퀀스 사용법
- NEXTVAL : 시퀀스의 다음값을 반환
- CURRVAL : 시퀀스의 현재값을 반환
- [주의사항] NEXTVAL을 하지 않은 채로 CURRVAL을 먼저 사용할 수 없다.

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '홍보부', '인천');
SELECT * FROM DEPT;

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '영업부3','수원');

SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;

SELECT * FROM BBS;

BBS 테이블(게시판)에 사용할 시퀀스를 생성하세요.
--<1> BBS 테이블(게시판)에 사용할 시퀀스를 생성하세요
--시작값: n
--증가치: 1
--최소값: N
--NOCYCLE
--CACHE n
CREATE SEQUENCE BBS_NO_SEQ
START WITH 7
INCREMENT BY 1
MINVALUE 4
NOCYCLE
NOCACHE;
--<2> BBS에 시퀀스를 이용해서 게시글을 삽입하세요
SELECT * FROM BBS;
INSERT INTO BBS(NO, TITLE, WRITER, CONTENT)
VALUES(BBS_NO_SEQ.NEXTVAL, '글', 'kim', '쓰기');

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

# 시퀀스 삭제
DROP SEQUENCE 시퀀스명;

DROP SEQUENCE DEPT_DEPTNO_SEQ;

-------------------------------------------
# VIEW
- 가상의 테이블
- 주로 PW같은 개인정보 들어있을 경우 그걸 제외하고 뷰 생성
CREATE [OR REPLACE] VIEW 뷰이름
AS
SELECT 문;

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

==> ORA-01031: insufficient privileges 에러 발생
system/oracle로 접속해서
grant create view to scott; 해줘야함

grant create view to scott;

select * from emp20_view;

-- EMP 테이블에서 30번 부서만 EMPNO을 EMP_NO로 ENAME을 NAME으로
-- SAL를 SALARY로 바꾸어 EMP30_VIEW 생성
CREATE OR REPLACE VIEW EMP30_VIEW(EMP_NO, NAME, SALARY)
AS
SELECT EMPNO, ENAME, SAL FROM EMP WHERE DEPTNO=30;

UPDATE EMP SET DEPTNO=10 WHERE ENAME = UPPER('ALLEN');

SELECT * FROM EMP30_VIEW;
SELECT * FROM EMP;
UPDATE EMP30_VIEW SET SALARY=1550 WHERE NAME = UPPER('WARD');

뷰를 수정하면 => 원테이블도 수정됨
테이블 수정 => 뷰도 수정됨

만약 뷰를 수정 못하게 하려면 WITH READ ONLY 옵션을 준다

-- 고객 테이블의 고객 정보 중 나이가 19세 이상인
-- 고객의 정보를 확인하는 뷰를 만들어보세요.
-- 단 뷰의 이름은 MEMBER_19VIEW로 하세요.
CREATE OR REPLACE VIEW MEMBER_19VIEW
AS
SELECT * FROM MEMBER WHERE AGE>=19
WITH READ ONLY;

SELECT * FROM MEMBER_19VIEW ORDER BY AGE;

UPDATE MEMBER SET AGE=17 WHERE USERID='id1';

-- MEMBER_19VIEW에서 'id3'인 회원의 마일리지를 500점 부여하세요
UPDATE MEMBER_19VIEW SET MILEAGE=MILEAGE+500 WHERE USERID='id3';

-- 카테고리, 상품, 공급업체를 join한 뷰를 만드세요
--뷰이름 : prod_view
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

--JOIN문으로 생성한 뷰는 읽기 전용으로만 사용 가능

# with check option
=> where 절의 조건을 엄격하게 유지하도록 제한함

create or replace view emp20vw
as select * from emp
where deptno=20
with check option constraint emp20vw_ck;

select * from emp20vw;

update emp20vw set sal=sal+500 where empno=7369;

update emp20vw set deptno=30 where empno=7369;--오류
--ORA-01402: view WITH CHECK OPTION where-clause violation

# 데이터 사전 조회
- user_views
- user_objects

select text from user_views where view_name=upper('emp20vw');
select * from user_objects where object_name=upper('emp20vw');

# View 삭제
drop view 뷰이름;

drop view emp20vw;
----------------------------------------
# Index

--‘자주 조회’하고 ‘수정 빈도’가 낮으며 ‘데이터 중복’
create index 인덱스명 on 테이블명 (컬럼명);

create index emp_ename_indx on emp (ename);
데이터 사전에서 조회
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
-- 내부적으로 오름차순 정렬

SELECT * FROM MEMBER
WHERE NAME LIKE '%길동%';

SELECT * FROM PRODUCTS;
--상품 테이블에서 인덱스를 걸어두면 좋을 컬럼을 찾아 인덱스를 만드세요.
-- 외래키가 좋음 -> CATEGORY_FK, EP_CODE_FK
CREATE INDEX PRODUCTS_INDX1 ON PRODUCTS (CATEGORY_FK);
CREATE INDEX PRODUCTS_INDX2 ON PRODUCTS (EP_CODE_FK);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'PRODUCTS';
#인덱스 삭제
DROP INDEX 인덱스명;

MEMBER_INDX를 삭제하세요
DROP INDEX MEMBER_INDX;

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'MEMBER';
-----------------------------------------------------------------
# Synonym -동의어
오라클 객체(테이블, 뷰, 시퀀스, 프로시저..)에 대한 별칭 (ALIAS)
객체에 대한 참조를 의미

-- 도스창에서 진행
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
--SQL> insert into note values(1, '안녕하세요');
--
--1 row created.
--
--SQL> insert into note values(2, '반가워요');
--
--1 row created.
--
--SQL> grant all on note to scott;
--SQL> conn scott/tiger
--SQL> select * from mystar.note
--SQL> insert into mystar.note values(3, '저는 스콧이에요');
--SQL> conn system/oracle
--Connected.
--SQL> grant create synonym to scott;
--
--Grant succeeded.
--SQL> conn scott/tiger
--Connected.
--SQL> create synonym A for mystar.note;
- 동의어 생성
CREATE SYNONYM 동의어이름 FOR 객체명(스키마.테이블명);

데이터사전에서 조회
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

- 동의어 삭제
DROP SYNONYM 동의어명;

DROP SYNONYM A;

SELECT * FROM A;
SELECT * FROM MYSTAR.NOTE;
----------------------------------------
# 프로시저 - crud

# db설계 - 개념설계/논리설계/물리설계, 정규화
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