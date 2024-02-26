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

exec bbs_add('프로시저로 글을 써요', 'hong', '프로시저와 jdbc 연동합니다');

select * from bbs order by no;
-----------------------------
--sys_refcursor 타입을 이용하면 자바에서 ResultSet으로 받을 수 있다.
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