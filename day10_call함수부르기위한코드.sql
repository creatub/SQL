create or replace procedure bbs_add
(
    ptitle in bbs.title%type,
    pwriter in bbs.writer%type,
    pcontent in bbs.content%type
)
is
begin
    insert into bbs(no, title, writer, content, wdate)
    values(bbs_no_seq.nextval, ptitle, pwriter, pcontent, sysdate);
    commit;
end;
/

select * from user_sequences;

exec bbs_add('���ν����� ���� ���', 'hong', '���ν����� jdbc �����մϴ�');

select * from bbs order by no;
-----------------------------
--sys_refcursor Ÿ���� �̿��ϸ� �ڹٿ��� ResultSet���� ���� �� �ִ�.
create or replace procedure bbs_list
(mycr out sys_refcursor)
is
begin
    open mycr for
    select no, title, writer, content, wdate from bbs
    order by no desc;
end;
/
------------------------------
create or replace procedure bbs_find
(mycr out sys_refcursor, pwriter in bbs.writer%type)
is
begin
    open mycr for
    select no, title, writer, content, wdate from bbs
    where writer like '%'||pwriter||'%'
    order by no desc;
end;
/
------------------------------
variable rs refcursor
exec bbs_find(:rs, 'k');

print rs

select * from java_member;