-- First we create a database for sharing
create or replace database data_s;

-- Then we use the database we create
use database data_s;

-- Then we create a external stage to load data from an aws bucket 
create or replace stage data_s.public.aws_stage
    url='s3://bucketsnowflakes3';

-- we List the files we have in the stage
list @data_s.public.aws_stage;

-- we create a table where we will load the data from files
create or replace table data_s.public.orders (
 order_id varchar(30)
,amount	number(38,0)
,profit	number(38,0)
,quantity number(38,0)
,category varchar(30)
,subcategory varchar(30)
);

-- We load data from the staged files we have in the stage "aws_stage" to an existing table "orders"
copy into data_s.public.orders
    from @data_s.public.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*OrderDetails.*';

-- We prove that we have already loaded the data into orders    
select * from data_s.public.orders limit 10; 

-- Create a share object
create or replace share orders_share;


---- Setup usage grants to share object----

-- Grant usage on database to share
grant usage on database data_s to share orders_share; 

-- Grant usage on schema to share
grant usage on schema data_s.public to share orders_share; 

-- Grant SELECT on table
grant select on table data_s.public.orders to share orders_share; 

-- Validate Grants
show grants to share orders_share;

---- Add Consumer Account ----
alter share orders_share add account=djb31677; -- Here we set the account id for the consumer 

---- At consumer level:

-- Once the previos query is executed we go to the consumer account with the accountadmin role and execute this quuery:
show shares;

-- We take the owner accout value for the share EVCZBCG.VIB37232
-- It would be this: EVCZBCG.VIB37232, and this would be the producter account id
desc share evczbcg.vib37232.orders_share;

-- Create a database in consumer account using this share 
create or replace database data_s from share evczbcg.vib37232.orders_share;

-- Validate table access
select * from data_s.public.orders limit 10;

