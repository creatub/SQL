select * from tab;
desc upcategory;
desc downcategory;
desc products;
desc member;

insert into member(userid, name, pwd, hp1, hp2, hp3, post, addr1, addr2, indate, mileage, mstate)
values('hong','홍길동','111','010','2222','3333','12345','서울 마포구 도화동','1번지',sysdate,1000,0);
commit;
select * from member;

insert into upcategory(upcg_code, upcg_name)
values(1,'전자제품');
insert into upcategory(upcg_code, upcg_name)
values(2,'생활용품');
insert into upcategory(upcg_code, upcg_name)
values(3,'의류');
select * from upcategory;

insert into downcategory(upcg_code, downcg_code, downcg_name)
values(1, 1, '노트북');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(1, 2, '냉장고');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(2, 3, '주방세제');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(2, 4, '휴지');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(3, 5, '남성의류');
insert into downcategory(upcg_code, downcg_code, downcg_name)
values(3, 6, '여성의류');
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
-- ==> 장바구니 뷰를 생성
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


--decode가 if문 같은 역할
create or replace view memberView
as 
select m.*, decode(mstate,0,'활동회원',-1,'정지회원',-2,'탈퇴회원',9,'관리자') mstateStr
from member m
where mstate >-2;

select name,userid,mstate,mstateStr from memberView;