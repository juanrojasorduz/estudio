----- change clause ------ 

--- create example db & table ---

create or replace database sales_db;

use sales_db;

create or replace table sales_raw(
	id varchar,
	product varchar,
	price varchar,
	amount varchar,
	store_id varchar);

-- insert values
insert into sales_raw
	values
		(1, 'eggs', 1.39, 1, 1),
		(2, 'baking powder', 0.99, 1, 1),
		(3, 'eggplants', 1.79, 1, 2),
		(4, 'ice cream', 1.89, 1, 2),
		(5, 'oats', 1.98, 2, 1);

-- To track changes in this table we use change_tracking = true        
alter table sales_raw
set change_tracking = true;

-- Use this changes statement 
select * from sales_raw
changes(information => default)  --> we select the method to see changes, standard (default) or append
at (offset => -0.5*60); -- Using a time travel feature

-- We can use also timestamp 
select current_timestamp;

-- insert values
insert into sales_raw values (6, 'bread', 2.99, 1, 2);
insert into sales_raw values (7, 'onions', 2.89, 1, 2);

-- To see changes using timestamp we paste the timestamp we got previously
select * from sales_raw
changes(information  => default)
at (timestamp => '2023-09-14 11:54:37.558 -0700'::timestamp_tz);

-- We can evaluate it for append_only
select * from sales_raw
changes(information  => append_only)
at (timestamp => '2023-09-14 11:58:57.559 -0700'::timestamp_tz);

-- We make a chenge using update
update sales_raw
set product = 'toast2' where id=6;

-- information value
-- We can use also timestamp 
select current_timestamp; -- We copy this timestamp to evaluate the changes

update sales_raw
set product = 'toast2' where id=7;

-- Evaluate change using the default method
select * from sales_raw
changes(information  => default)
at (timestamp => '2023-09-14 12:02:03.738 -0700'::timestamp_tz);

-- Evaluate change using the default method
select * from sales_raw
changes(information  => append_only)
at (timestamp => '2023-09-14 12:02:03.738 -0700'::timestamp_tz);  -- We will not see changes because this method is for insert only

-- We can create a table using the changes we have for a certain method
create or replace table products 
as
select * from sales_raw
changes(information  => append_only)  -- Evaluate the changes after a certain timestamp
at (timestamp => '2023-09-14 11:54:37.558 -0700'::timestamp_tz);  

-- See how is the created table
select * from products;
