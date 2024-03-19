select * from tab;
desc upcategory;
desc downcategory;
desc products;
desc member;

insert into member(userid, name, pwd, hp1, hp2, hp3, post, addr1, addr2, indate, mileage, mstate)
values('hong','ȫ�浿','111','010','2222','3333','12345','���� ������ ��ȭ��','1����',sysdate,1000,0);
commit;
select * from member;

insert into upcategory(upcg_code, upcg_name)
values(1,'������ǰ');
insert into upcategory(upcg_code, upcg_name)
values(2,'��Ȱ��ǰ');
insert into upcategory(upcg_code, upcg_name)
values(3,'�Ƿ�');
select * from upcategory;

insert into downcategory(upcg_code, downcg_code, downcg_name)
values(1, 1, '��Ʈ��');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(1, 2, '�����');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(2, 3, '�ֹ漼��');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(2, 4, '����');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(3, 5, '�����Ƿ�');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(3, 6, '�����Ƿ�');
select * from downcategory;
commit;
rollback;

create sequence product_seq nocache;

select * from products;
commit;


select 
p.*,
(select upCg_name from upCategory where upCg_code = p.upCg_code) upCg_name,
(select downCg_name from downCategory where downCg_code=p.downCg_code) downCg_name
from products p
order by pnum desc;


select c.*, p.pname, p.pimage1, price, saleprice, point
    ,(c.pqty * p.saleprice) totalPrice
    ,(c.pqty * p.point) totalPoint
from cart c join products p 
on c.pnum=p.pnum;
-- ==> ��ٱ��� �並 ����
create or replace view cartView
as 
select c.*, p.pname, p.pimage1, price, saleprice, point
,(c.pqty * p.saleprice) totalPrice
,(c.pqty * p.point) totalPoint
from cart c join products p 
on c.pnum=p.pnum;

select * from cartView where userid='hong';

select sum(totalPrice) totalPrice, sum(totalPoint) totalPoint
from cartView where userid='hong';

select * from member;

select userid,name,mstate,pwd from member;

update member set mstate=-2 where userid='kim2';
commit;

update member set mstate=9 where userid='admin';
commit;

update member set mstate=-1 where userid='asdfg';
commit;


--decode�� if�� ���� ����
create or replace view memberView
as 
select m.*, decode(mstate,0,'Ȱ��ȸ��',-1,'����ȸ��',-2,'Ż��ȸ��',9,'������') mstateStr
from member m
where mstate >-2;

select name,userid,mstate,mstateStr from memberView;