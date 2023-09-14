-- remove caching just to have a fair test -- part 1
-- execute these statements:
alter session set use_cached_result=false; -- disable global caching
alter warehouse compute_wh suspend;
alter warehouse compute_wh resume;

-- prepare table
create or replace transient database orders;

create or replace schema tpch_sf100;

create or replace table tpch_sf100.orders as
select * from snowflake_sample_data.tpch_sf100.orders;

select * from orders limit 100;

-- example statement view -- Lots of users want to execute it frequently 
select
year(o_orderdate) as year,
max(o_comment) as max_comment,
min(o_comment) as min_comment,
max(o_clerk) as max_clerk,
min(o_clerk) as min_clerk
from orders.tpch_sf100.orders
group by year(o_orderdate)
order by year(o_orderdate) limit 10;

-- create materialized view
create or replace materialized view orders_mv
as 
select
year(o_orderdate) as year,
max(o_comment) as max_comment,
min(o_comment) as min_comment,
max(o_clerk) as max_clerk,
min(o_clerk) as min_clerk
from orders.tpch_sf100.orders
group by year(o_orderdate);

-- We see that behind by= How far the updates of the materialized view are behind the updates of the base table
show materialized views;

-- query view
select * from orders_mv
order by year;

-- update or delete values
update orders
set o_clerk='clerk#99900000' 
where o_orderdate='1992-01-01';

   -- test updated data --
-- example statement view -- 
select
year(o_orderdate) as year,
max(o_comment) as max_comment,
min(o_comment) as min_comment,
max(o_clerk) as max_clerk,
min(o_clerk) as min_clerk
from orders.tpch_sf100.orders
group by year(o_orderdate)
order by year(o_orderdate);

-- query view -- We see hat the 
select * from orders_mv
order by year;

show materialized views;