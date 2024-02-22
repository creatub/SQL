--day09_DCL.sql
conn system/oracle; -- 안 먹힘, 우측 상단에서 바꿔야함
show user;
시스템 권한을 scott에게 부여하자

grant create user, alter user, drop user to scott with admin option;
-- with admin option을 주면 scott도 다른 user에게
-- create user, alter user, drop user 권한들을 부여할 수 있게 된다.

--SQL> create user myson
--  2  identified by myson;
--User created.
--SQL> alter user myson
--  2  identified by tiger;
--User altered.
--SQL> drop user myson cascade ;
--User dropped.


revoke create user, alter user, drop user from scott;



 ------------------------------------------------------------------------------          
 시나리오.
 1. DBA권한을 가진 SYSTEM으로 접속
 2. 새로운 사용자를 생성 MILLER USER를 생성하고 비번 지정
 3. MILLER로 접속 시도  -> 권한 부족
 4. SYSTEM으로 접속하여 MILLER에게 CREATE SESSION 권한 부여
 5. MILLER로 접속 시도 --> 성공
 6. TEST 테이블 생성하기 --> 권한 부족
 7. SYSTEM으로 접속 후 테이블 생성 권한 부여
 8. 다시 테이블 생성후 레코드 insert
 9. tablespace에 대한 권한 부족이라고 나옴
 10. system으로 접속후 MILLER의 테이블 스페이스 확인
	SELECT USERNAME, DEFAULT_TABLESPACE FROM DBA_USERS
	WHERE USERNAME='MILLER'

	테이블 스페이스는 테이블과 뷰 등 데이터베이스 객체들이 저장되는 장소.
	USERS는 사용자 데이터를 저장하기 위한 공간.

	CREATE TABLE권한을 줬음에도 테이블을 생성하지 못하거나 INSERT
	하지 못한 것은 사용자 생성 당시 해당 디폴트 테이블스페이스인 USERS
	에 대한 QUOTA를 설정하지 않았기 때문.

11. SYSTEM 접속 후 테이블스페이스 영역 할당하기
	ALTER USER MILLER QUOTA 2M ON SYSTEM

	QUOTA절을 이용하여 MILLER사용자가 사용할 테이블스페이스 영역을
	할당했으므로 다시 MILLER로 접속하여 시도해보자.
 ----------------------------------------------------------------------------------
 
 시나리오

 1. SCOTT가 mysun에게 WITH GRANT OPTION을 사용하여 dept테이블의 SELECT 권한을 부여 합니다. 

2. mysun이 emp테이블의 SELECT권한을 mymoon에게 부여 합니다. (connect,resource를 mymoon에게 grant해둬야 함)

3. mymoon으로 접속해서 scott.emp를 select해보자

4. SCOTT가 mysun에게 부여한 emp테이블의 SELECT 권한을 취소 합니다. (revoke  ... from)

5. mysun으로 접속해서 scott.emp를 select해보자

6.  mymoon으로 접속해서 scott.emp를 select해보자

---------------------------------------------------------------------------------------------
ROLE;
--SQL> conn system/oracle
--Connected.
--SQL> show user
--USER is "SYSTEM"
--SQL> create role manager;
--Role created.
--SQL> grant create session, create table, create view, create synonym to manager;
--Grant succeeded.
--SQL> select grantee, privilege
--  2  from dba_sys_privs
--  3  where grantee=upper('manager');

--------------------------------------
------------PL/SQL을 사용하려면 RESOURCE ROLE을 부여해야함
select grantee, privilege
from dba_sys_privs
where grantee = 'RESOURCE'
------------
select grantee, privilege
from dba_sys_privs
where grantee = 'CONNECT'
-----------모든 시스템 권한이 부여된 ROLE
select grantee, privilege
from dba_sys_privs
where grantee = 'DBA'

SQL> grant dba to scott;
-- 실습 전에 미리 쳐놨으면 cmd로 친 것들도 저장 가능
SQL> spool c:\multicampus\SQL\day08_DCL_실습_cmd.sql
SQL> spool off

-- 공부할 수 있는 사이트
http://gurubee.net/oracle/sql