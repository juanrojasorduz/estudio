
-- create database & table --
create or replace database customer_db;

create or replace table customer_db.public.customers (
  id int,
  first_name string,
  last_name string,
  email string,
  gender string,
  job string,
  phone string);
    
-- stage and file format
create or replace file format manage_db.file_formats.csv_file
    type = csv
    field_delimiter = ','
    skip_header = 1;
    
create or replace stage manage_db.external_stages.time_travel_stage
    url = 's3://data-snowflake-fundamentals/time-travel/'
    file_format = manage_db.file_formats.csv_file;
    
list  @manage_db.external_stages.time_travel_stage;


-- copy data and insert in table
copy into customer_db.public.customers
from @manage_db.external_stages.time_travel_stage
files = ('customers.csv');

select * from customer_db.public.customers limit 10;

-- create view -- 
create or replace view customer_db.public.customer_view as
select 
first_name,
last_name,
email
from customer_db.public.customers
where job != 'DATA SCIENTIST'; 


-- grant usage & select --
grant usage on database customer_db to role public;
grant usage on schema customer_db.public to role public;
grant select on table customer_db.public.customers to role public;
grant select on view customer_db.public.customer_view to role public;

show views like '%customer%';

-- create secure view -- If we do not want to share views

create or replace secure view customer_db.public.customer_view_secure as
select 
first_name,
last_name,
email
from customer_db.public.customers
where job != 'DATA SCIENTIST';

-- grant permisions over the secure view to role public
grant select on view customer_db.public.customer_view_secure to role public;

-- If we execute this query using the role public we will not see the query definition in text field
show views like '%customer%';



