------- append-only type ------
use streams_db;
show streams; -- We can see that the value for Mode is DEFAULT,so that is the first type

-- Types of streams:
-- Standard (DEFAULT): It works with INSERT,UPDATE AND DELETE
-- Append-Only: It works just with INSERT

select * from sales_raw_staging;     

-- create stream with default
create or replace stream sales_stream_default
on table sales_raw_staging;

-- create stream with append-only
create or replace stream sales_stream_append
on table sales_raw_staging 
append_only = true; -- For append only stream we have to add this condition

-- view streams
show streams;

-- insert values
insert into sales_raw_staging values (14,'honey',4.99,1,1);
insert into sales_raw_staging values (15,'coffee',4.89,1,2);
insert into sales_raw_staging values (15,'coffee',4.89,1,2);

-- Both streams capture the same changes
select * from sales_stream_append;
select * from sales_stream_default;


-- But if we execute delete operations in source table, just the Standard type will capture this changes
select * from sales_raw_staging;

delete from sales_raw_staging where id=7;

select * from sales_stream_append;
select * from sales_stream_default; -- Just this one captures the change

-- consume stream via "create table ... as" now we will create a temporary table to consume the streams
create or replace temporary table product_table
as select * from sales_stream_default;
create or replace temporary table product_table
as select * from sales_stream_append;

-- Now we see how are the streams objects
select * from sales_stream_append; 
select * from sales_stream_default; 

-- But if we execute update operations in source table, just the Standard type will capture this changes
update sales_raw_staging
set product = 'coffee 200g'
where product ='coffee';

-- We see how are the stream objects
select * from sales_stream_append;
select * from sales_stream_default; -- Just the default stream captures this changes 

-- consume stream via "create table ... as" now we will create a temporary table to consume the streams
create or replace temporary table product_table
as select * from sales_stream_default;
create or replace temporary table product_table
as select * from sales_stream_append;

-- Now we see how are the streams objects
select * from sales_stream_append; 
select * from sales_stream_default; 
