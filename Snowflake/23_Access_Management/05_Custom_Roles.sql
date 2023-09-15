use role sales_admin;

use sales_database;

-- create table --
create or replace table customers(
  id number,
  full_name varchar, 
  email varchar,
  phone varchar,
  spent number,
  create_date date default current_date);

-- insert values in table --
insert into customers (id, full_name, email,phone,spent)
values
  (1,'lewiss macdwyer','lmacdwyer0@un.org','262-665-9168',140),
  (2,'ty pettingall','tpettingall1@mayoclinic.com','734-987-7120',254),
  (3,'marlee spadazzi','mspadazzi2@txnews.com','867-946-3659',120),
  (4,'heywood tearney','htearney3@patch.com','563-853-8192',1230),
  (5,'odilia seti','oseti4@globo.com','730-451-8637',143),
  (6,'meggie washtell','mwashtell5@rediff.com','568-896-6138',600);
  
show tables;

-- query from table --
select* from customers;

use role sales_users;

-- grant usage to role sales_user
use role sales_admin;

grant usage on database sales_database to role sales_users;
grant usage on schema sales_database.public to role sales_users;
grant select on table sales_database.public.customers to role sales_users;


-- validate privileges --
use role sales_users;
select* from customers;
drop table customers; -- Insufficient privileges - The role user only have the privileges to do select
delete from customers; -- Insufficient privileges - The role user only have the privileges to do select
show tables;

-- grant delete privileges on table
use role sales_admin;
grant delete on table sales_database.public.customers to role sales_users;
use role sales_users;
delete from customers; -- We can do it now using sales_uers
drop table customers; -- Insufficient privileges - Because the role sales_users does not has the ownership of the table

use role sales_admin;