--day09_DCL.sql
conn system/oracle; -- �� ����, ���� ��ܿ��� �ٲ����
show user;
�ý��� ������ scott���� �ο�����

grant create user, alter user, drop user to scott with admin option;
-- with admin option�� �ָ� scott�� �ٸ� user����
-- create user, alter user, drop user ���ѵ��� �ο��� �� �ְ� �ȴ�.

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
 �ó�����.
 1. DBA������ ���� SYSTEM���� ����
 2. ���ο� ����ڸ� ���� MILLER USER�� �����ϰ� ��� ����
 3. MILLER�� ���� �õ�  -> ���� ����
 4. SYSTEM���� �����Ͽ� MILLER���� CREATE SESSION ���� �ο�
 5. MILLER�� ���� �õ� --> ����
 6. TEST ���̺� �����ϱ� --> ���� ����
 7. SYSTEM���� ���� �� ���̺� ���� ���� �ο�
 8. �ٽ� ���̺� ������ ���ڵ� insert
 9. tablespace�� ���� ���� �����̶�� ����
 10. system���� ������ MILLER�� ���̺� �����̽� Ȯ��
	SELECT USERNAME, DEFAULT_TABLESPACE FROM DBA_USERS
	WHERE USERNAME='MILLER'

	���̺� �����̽��� ���̺�� �� �� �����ͺ��̽� ��ü���� ����Ǵ� ���.
	USERS�� ����� �����͸� �����ϱ� ���� ����.

	CREATE TABLE������ �������� ���̺��� �������� ���ϰų� INSERT
	���� ���� ���� ����� ���� ��� �ش� ����Ʈ ���̺����̽��� USERS
	�� ���� QUOTA�� �������� �ʾұ� ����.

11. SYSTEM ���� �� ���̺����̽� ���� �Ҵ��ϱ�
	ALTER USER MILLER QUOTA 2M ON SYSTEM

	QUOTA���� �̿��Ͽ� MILLER����ڰ� ����� ���̺����̽� ������
	�Ҵ������Ƿ� �ٽ� MILLER�� �����Ͽ� �õ��غ���.
 ----------------------------------------------------------------------------------
 
 �ó�����

 1. SCOTT�� mysun���� WITH GRANT OPTION�� ����Ͽ� dept���̺��� SELECT ������ �ο� �մϴ�. 

2. mysun�� emp���̺��� SELECT������ mymoon���� �ο� �մϴ�. (connect,resource�� mymoon���� grant�ص־� ��)

3. mymoon���� �����ؼ� scott.emp�� select�غ���

4. SCOTT�� mysun���� �ο��� emp���̺��� SELECT ������ ��� �մϴ�. (revoke  ... from)

5. mysun���� �����ؼ� scott.emp�� select�غ���

6.  mymoon���� �����ؼ� scott.emp�� select�غ���

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
------------PL/SQL�� ����Ϸ��� RESOURCE ROLE�� �ο��ؾ���
select grantee, privilege
from dba_sys_privs
where grantee = 'RESOURCE'
------------
select grantee, privilege
from dba_sys_privs
where grantee = 'CONNECT'
-----------��� �ý��� ������ �ο��� ROLE
select grantee, privilege
from dba_sys_privs
where grantee = 'DBA'

SQL> grant dba to scott;
-- �ǽ� ���� �̸� �ĳ����� cmd�� ģ �͵鵵 ���� ����
SQL> spool c:\multicampus\SQL\day08_DCL_�ǽ�_cmd.sql
SQL> spool off

-- ������ �� �ִ� ����Ʈ
http://gurubee.net/oracle/sql