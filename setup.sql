-- add in constraints if necessary later



-- drop table banjavi.orders PURGE;  -- PURGE also removes table from recycling, remove foreign key table first
-- drop table banjavi.products PURGE;  -- PURGE also removes table from recycling
-- drop table banjavi.users PURGE;  -- Pdrop table banjavi.products PURGE;URGE also removes table from recycling




set autocommit off;

drop table banjavi.orders PURGE;
drop table banjavi.products PURGE;
drop table banjavi.users PURGE;
drop sequence user_id_seq;
drop trigger trg_user_id;
drop sequence product_id_seq;
drop trigger trg_product_id;
drop sequence purchase_id_seq;
drop trigger trg_purchase_id;



create table banjavi.users (
    user_id                     integer,          -- comment
    username                    varchar2(10),     -- unique?
    password                    varchar2(10),     -- special characters?
    type                        varchar2(10),     -- 'Manager', 'Employee', or 'Customer'
    constraint users_pk primary key (user_id),
    constraint username_unique UNIQUE (username)
);
create sequence user_id_seq START WITH 1;
create trigger trg_user_id
   before insert on banjavi.users
   for each row
 begin
   select user_id_seq.nextval
     into :new.user_id
     from dual;
 end;
 /
insert into banjavi.users values(0,'Adam', 'a1234', 'Manager');
insert into banjavi.users values(0,'Ben', 'b1234', 'Manager');
insert into banjavi.users values(0,'Carter', 'c1234', 'Employee');
insert into banjavi.users values(0,'Don', 'd1234', 'Employee');
insert into banjavi.users values(0,'Eric', 'e1234', 'Customer');
insert into banjavi.users values(0,'Fred', 'f1234', 'Customer');
insert into banjavi.users values(0,'Gary', 'g1234', 'Customer');
grant select on banjavi.users to public;



create table banjavi.products (
    product_id                  integer,          -- display as bar code in output
    name                        varchar2(30),     -- comment
    stock                       integer,          -- comment
    price                       number(*,2),       -- price of 1 unit of stock, in the format ...#####.##
    category                    varchar2(10),     -- category of product
    constraint products_pk primary key (product_id)
);
create sequence product_id_seq START WITH 1;
create trigger trg_product_id
   before insert on banjavi.products
   for each row
 begin
   select product_id_seq.nextval
     into :new.product_id
     from dual;
 end;
 /
insert into banjavi.products values(0, 'Bleu Cheese', 25, 2.50, 'Dairy');
insert into banjavi.products values(0, 'Cheddar Cheese', 5, 2.00, 'Dairy');
insert into banjavi.products values(0, 'Whole Milk', 2, 3.00, 'Dairy');
insert into banjavi.products values(0, 'Almond Milk', 3, 4.50, 'Dairy');
insert into banjavi.products values(0, 'Butter', 6, 2.50, 'Dairy');
insert into banjavi.products values(0, 'Asparagus', 5, 1.00, 'Produce');
insert into banjavi.products values(0, 'Japanese Sweet Potato', 1, 7.00, 'Produce');
insert into banjavi.products values(0, 'Corn', 3, 3.75, 'Produce');
insert into banjavi.products values(0, 'Pomegranate', 4, 6.50, 'Produce');
insert into banjavi.products values(0, 'Kiwi', 22, 1.25, 'Produce');
insert into banjavi.products values(0, 'Spinach', 7, 8.50, 'Produce');
insert into banjavi.products values(0, 'Grapefruit', 2, 2.25, 'Produce');
insert into banjavi.products values(0, 'Watermelon', 3, 3.25, 'Produce');
insert into banjavi.products values(0, 'Cauliflower', 5, 5.25, 'Produce');
insert into banjavi.products values(0, 'Popcorn', 3, 4.50, 'Snacks');
insert into banjavi.products values(0, 'Super Gum', 2, 1.25, 'Snacks');
insert into banjavi.products values(0, 'Pepto-Bismol', 1, 3.50, 'Medicine');
insert into banjavi.products values(0, 'Cookie Dough Ice Cream', 8, 2.75, 'Frozen');
insert into banjavi.products values(0, 'Pizza Rolls', 2, 2.00, 'Frozen');
insert into banjavi.products values(0, 'Lean Cuisine Pasta', 1, 5.50, 'Frozen');
insert into banjavi.products values(0, 'Chicken Tenders', 12, 6.25, 'Meat');
insert into banjavi.products values(0, '2 LB Ground Beef', 3, 7.50, 'Meat');
insert into banjavi.products values(0, 'Pepsi', 1, 2.50, 'Beverages');
insert into banjavi.products values(0, 'Gatorade Glacier Freeze', 5, 2.50, 'Beverages');
grant select on banjavi.products to public;



create table banjavi.orders (
    purchase_id                 integer,          --
    order_id                    integer,          --
    user_id                     integer,          --
    date_placed                 DATE,             --
    pick_up_date                DATE,             --
    product_id                  integer,          --
    quantity                    integer,          --
    constraint orders_pk primary key (purchase_id),
    constraint fk1_supplier foreign key (user_id) REFERENCES banjavi.users(user_id),
    constraint fk2_supplier foreign key (product_id) REFERENCES banjavi.products(product_id)
);
create sequence purchase_id_seq START WITH 1;
create trigger trg_purchase_id
   before insert on banjavi.orders
   for each row
 begin
   select purchase_id_seq.nextval
     into :new.purchase_id
     from dual;
 end;
 /
insert into banjavi.orders values(0, 1, 1, TO_DATE('2017/05/03', 'yyyy/mm/dd'), TO_DATE('2017/05/03', 'yyyy/mm/dd'), 18, 8);
insert into banjavi.orders values(0, 1, 1, TO_DATE('2017/05/03', 'yyyy/mm/dd'), TO_DATE('2017/05/03', 'yyyy/mm/dd'), 11, 4);
insert into banjavi.orders values(0, 1, 1, TO_DATE('2017/05/03', 'yyyy/mm/dd'), TO_DATE('2017/05/03', 'yyyy/mm/dd'), 1, 3);
insert into banjavi.orders values(0, 2, 5, TO_DATE('2017/04/02', 'yyyy/mm/dd'), TO_DATE('2017/04/04', 'yyyy/mm/dd'), 16, 1);

insert into banjavi.orders values(0, 3, 5, TO_DATE('2017/04/02', 'yyyy/mm/dd'), TO_DATE('2017/04/04', 'yyyy/mm/dd'), 6, 1);
insert into banjavi.orders values(0, 3, 5, TO_DATE('2017/04/02', 'yyyy/mm/dd'), TO_DATE('2017/04/04', 'yyyy/mm/dd'), 22, 3);
insert into banjavi.orders values(0, 4, 5, TO_DATE('2017/06/12', 'yyyy/mm/dd'), TO_DATE('2017/06/14', 'yyyy/mm/dd'), 1, 7);
insert into banjavi.orders values(0, 4, 5, TO_DATE('2017/06/12', 'yyyy/mm/dd'), TO_DATE('2017/04/14', 'yyyy/mm/dd'), 17, 5);
insert into banjavi.orders values(0, 4, 5, TO_DATE('2017/06/12', 'yyyy/mm/dd'), TO_DATE('2017/04/14', 'yyyy/mm/dd'), 7, 7);

grant select on banjavi.orders to public;
