-- add in constraints if necessary later



-- drop table banjavi.orders PURGE;  -- PURGE also removes table from recycling, remove foreign key table first
-- drop table banjavi.products PURGE;  -- PURGE also removes table from recycling
-- drop table banjavi.users PURGE;  -- Pdrop table banjavi.products PURGE;URGE also removes table from recycling




set autocommit off;

drop table banjavi.orders PURGE;
drop table banjavi.products PURGE;
drop table banjavi.users PURGE;

create table banjavi.users (
    user_id                     integer,          -- comment
    username                    varchar2(10),     -- unique?
    password                    varchar2(10),     -- special characters?
    type                        varchar2(10),     -- 'Manager', 'Employee', or 'Customer'
    constraint users_pk primary key (user_id)
);
insert into banjavi.users values(1, 'Adam', 'a1234', 'Manager');
insert into banjavi.users values(2, 'Ben', 'b1234', 'Manager');
insert into banjavi.users values(3, 'Carter', 'c1234', 'Employee');
insert into banjavi.users values(4, 'Don', 'd1234', 'Employee');
insert into banjavi.users values(5, 'Eric', 'e1234', 'Customer');
insert into banjavi.users values(6, 'Fred', 'f1234', 'Customer');
insert into banjavi.users values(7, 'Gary', 'g1234', 'Customer');
grant select on banjavi.users to public;

create table banjavi.products (
    product_id                  integer,          -- display as bar code in output
    name                        varchar2(30),     -- comment
    stock                       integer,          -- comment
    price                       number(*,2),       -- price of 1 unit of stock, in the format ...#####.##
    category                    varchar2(10),     -- category of product
    constraint products_pk primary key (product_id)
);
insert into banjavi.products values(1, 'Bleu Cheese', 25, 2.50, 'Dairy');
insert into banjavi.products values(2, 'Cheddar Cheese', 5, 2.00, 'Dairy');
insert into banjavi.products values(3, 'Whole Milk', 2, 3.00, 'Dairy');
insert into banjavi.products values(4, 'Almond Milk', 3, 4.50, 'Dairy');
insert into banjavi.products values(5, 'Butter', 6, 2.50, 'Dairy');
insert into banjavi.products values(6, 'Asparagus', 5, 1.00, 'Produce');
insert into banjavi.products values(7, 'Japanese Sweet Potato', 1, 7.00, 'Produce');
insert into banjavi.products values(8, 'Corn', 3, 3.75, 'Produce');
insert into banjavi.products values(9, 'Pomegranate', 4, 6.50, 'Produce');
insert into banjavi.products values(10, 'Kiwi', 22, 1.25, 'Produce');
insert into banjavi.products values(11, 'Spinach', 7, 8.50, 'Produce');
insert into banjavi.products values(12, 'Grapefruit', 2, 2.25, 'Produce');
insert into banjavi.products values(13, 'Watermelon', 3, 3.25, 'Produce');
insert into banjavi.products values(14, 'Cauliflower', 5, 5.25, 'Produce');
insert into banjavi.products values(15, 'Popcorn', 3, 4.50, 'Snacks');
insert into banjavi.products values(16, 'Super Gum', 2, 1.25, 'Snacks');
insert into banjavi.products values(17, 'Pepto-Bismol', 1, 3.50, 'Medicine');
insert into banjavi.products values(18, 'Cookie Dough Ice Cream', 8, 2.75, 'Frozen');
insert into banjavi.products values(19, 'Pizza Rolls', 2, 2.00, 'Frozen');
insert into banjavi.products values(20, 'Lean Cuisine Pasta', 1, 5.50, 'Frozen');
insert into banjavi.products values(21, 'Chicken Tenders', 12, 6.25, 'Meat');
insert into banjavi.products values(22, '2 LB Ground Beef', 3, 7.50, 'Meat');
insert into banjavi.products values(23, 'Pepsi', 1, 2.50, 'Beverages');
insert into banjavi.products values(24, 'Gatorade Glacier Freeze', 5, 2.50, 'Beverages');

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
insert into banjavi.orders values(1, 1, 1, TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 18, 8);
insert into banjavi.orders values(2, 1, 1, TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 11, 4);
insert into banjavi.orders values(3, 1, 1, TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 1, 20);
insert into banjavi.orders values(4, 2, 5, TO_DATE('2017/04/02 22:03:24', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/04/02 22:03:24', 'yyyy/mm/dd hh24:mi:ss'), 16, 1);
insert into banjavi.orders values(5, 2, 5, TO_DATE('2017/04/02 22:03:24', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/04/02 22:03:24', 'yyyy/mm/dd hh24:mi:ss'), 5, 4);
insert into banjavi.orders values(6, 3, 6, TO_DATE('2017/01/10 11:22:22', 'yyyy/mm/dd hh24:mi:ss'), TO_DATE('2017/01/10 11:22:22', 'yyyy/mm/dd hh24:mi:ss'), 7, 2);
grant select on banjavi.orders to public;
