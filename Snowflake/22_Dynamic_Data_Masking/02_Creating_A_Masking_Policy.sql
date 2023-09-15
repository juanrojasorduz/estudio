create or replace database demo_db;

use demo_db;

use role accountadmin;

-- prepare table for sensitive customer data--
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


-- set up roles
create or replace role analyst_masked;
create or replace role analyst_full;


-- grant select on table to roles
grant usage on database demo_db to role analyst_masked;
grant usage on database demo_db to role analyst_full;

grant select on table demo_db.public.customers to role analyst_masked;
grant select on table demo_db.public.customers to role analyst_full;

grant usage on schema demo_db.public to role analyst_masked;
grant usage on schema demo_db.public to role analyst_full;

-- grant warehouse access to roles
grant usage on warehouse compute_wh to role analyst_masked;
grant usage on warehouse compute_wh to role analyst_full;


-- assign roles to a user
grant role analyst_masked to user JDROJASO;
grant role analyst_full to user JDROJASO;


-- set up masking policy
create or replace masking policy phone 
    as (val varchar) returns varchar ->
            case        
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else '##-###-##'
            end;
  
-- apply policy on a specific column 
alter table if exists customers modify column phone 
set masking policy phone;

-- validating policies
use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;