-- use a certain warehouse in snowflake

use warehouse test;

-- delete a warehouse

drop warehouse test;

-- show the access history details in snowflake

select * from snowflake.account_usage.access_history 

-- create a warehouse with an specific features
;

CREATE WAREHOUSE NW_WH
    WITH WAREHOUSE_SIZE = XSMALL  -- -> warehouse size
    MAX_CLUSTER_COUNT = 3         ---> maximum number of clusters
    AUTO_SUSPEND = 300            ----> time in seconds to suspend a warehouse  
    AUTO_RESUME = TRUE            -----> The warehouse resumes when a new query is submitted.
    COMMENT = 'Demo Warehouse With SQL';
    
    
-- Create a database from a share provided by account sfc_samples 
create database snowflake_sample_data
from
    share sfc_samples.sample_data;
    
    
-- Grant the PUBLIC role access to the database.
    -- Optionally change the role name to restrict access to a subset of users.
    grant imported privileges on database snowflake_sample_data to role public;
    
    
select * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER limit 5;
    
          
create database our_first_db;

use database our_first_db;

create table "OUR_FIRST_DB"."PUBLIC"."LOAN_PAYMENT" (
        "Loan_ID" STRING,
        "loan_status" STRING,
        "Principal" STRING,
        "terms" STRING,
        "effective_date" STRING,
        "due_date" STRING,
        "paid_off_time" STRING,
        "past_due_days" STRING,
        "age" STRING,
        "education" STRING,
        "Gender" STRING
    );
    
    
//Check that table is empy   
select * from public.loan_payment;




//Loading the data from S3 bucket
    copy into public.loan_payment
from 
    s3://bucketsnowflakes3/Loan_payments_data.csv file_format = (
        type = csv field_delimiter = ',' skip_header = 1
    );


show shares;
    
    
select * from public.loan_payment limit 10;


create or replace database manage_db;


use database manage_db;


create or replace schema external_stages;


-- creating external stage
--Creates a new named internal or external stage to use for loading data from files into Snowflake tables and unloading data from tables into files:
--Internal stage: Stores data files internally within Snowflake. Internal stages can be either permanent or temporary.
--External stage: References data files stored in a location outside of Snowflake.

create or replace stage manage_db.external_stages.aws_stage
    url='s3://bucketsnowflakes3'
    credentials=(aws_key_id='ABCD_DUMMY_ID' aws_secret_key='1234abcd_key');    


-- description of external stage
desc stage manage_db.external_stages.aws_stage;


-- alter external stage
alter stage aws_stage
    set credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');
    

-- publicly accessible staging area
create or replace stage manage_db.external_stages.aws_stage
    url='s3://bucketsnowflakes3';  
    

-- list files in stage
list @manage_db.external_stages.aws_stage;    


create or replace table our_first_db.public.orders (
    order_id varchar(30),
    amount int,
    profit int,
    quantity int,
    category varchar(30),
    subcategory varchar(30));
    
    
-- copy command with fully qualified stage object
copy into our_first_db.public.orders
    from @manage_db.external_stages.aws_stage
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails.csv')
    ;    
  
select * from our_first_db.public.orders limit 10

;

--example table 1
create or replace table our_first_db.public.orders_ex (
    order_id varchar(30),
    amount int);
    

-- copy command with select statement and pattern
copy into our_first_db.public.orders_ex
    from (select s.$1, s.$2 from @manage_db.external_stages.aws_stage s)
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    pattern='.*Order.*'
    ;
    
    
select * from our_first_db.public.orders_ex limit 10;


--example table 2
create or replace table our_first_db.public.orders_ex (
    order_id varchar(30),
    amount int,
    profit int,
    profitable_flag varchar(30)
);


-- example 2 - copy command using a SQL function (subset of functions available)

copy into our_first_db.public.orders_ex
    from (select 
            s.$1,
            s.$2,
            s.$3,
            case when cast(s.$3 as int) < 0 then 'not_profitable' else 'profitable' end
          from @manage_db.external_stages.aws_stage s)
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails.csv');    


select * from our_first_db.public.orders_ex limit 10;


--create new stage
create or replace stage manage_db.external_stages.aws_stage_errorex
    url='s3://bucketsnowflakes4';  
    
-- list files in stage
list @manage_db.external_stages.aws_stage_errorex;    


--create example table

create or replace table our_first_db.public.orders_ex (
    order_id varchar(30),
    amount int,
    profit int,
    quantity int,
    category varchar(30),
    subcategory varchar(30)
);

-- Error handling using the ON_ERROR option - Only correct files are loaded
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv')
    on_error = 'CONTINUE';
   

-- Error handling using the ON_ERROR option - Loading not executed
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv')
    on_error = 'ABORT_STATEMENT';
    
   
-- delete raws   
truncate table our_first_db.public.orders_ex;


-- Error handling using the ON_ERROR option - SKIP FILE 1
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    on_error = 'SKIP_FILE';
    
    
-- Error handling using the ON_ERROR option - SKIP FILE 2
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    on_error = 'SKIP_FILE_2';    
    
-- Error handling using the ON_ERROR option - SKIP FILE 3
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    on_error = 'SKIP_FILE_3';    
    
-- delete raws   
truncate table our_first_db.public.orders_ex;    