-- Error handling using the ON_ERROR option - SKIP FILE 3
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter = ',' skip_header = 1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    on_error = SKIP_FILE_3
    size_limit = 30;
    
      
-- create schema to keep organized
create or replace schema manage_db.file_formats;


-- creating file format object
create or replace file format manage_db.file_formats.my_file_format;
    
    
-- see properties of file format object
desc file format manage_db.file_formats.my_file_format;


--using file format object in copy command
copy into our_first_db.public.orders_ex
    from @manage_db.external_stages.aws_stage_errorex
    file_format = (FORMAT_NAME=MANAGE_DB.file_formats.my_file_format)
    files = ('OrderDetails_error.csv')
    on_error = 'skip_file_3';
    
    
    
--altering file format object

alter file format manage_db.file_formats.my_file_format
    set skip_header = 1;


--Defining properties on creation of file format object

create or replace file format manage_db.file_formats.my_file_format
type=JSON,
time_format=AUTO;


desc file format manage_db.file_formats.my_file_format;
    


--prepare database & table
create or replace database copy_db;


--create example table

create or replace table copy_db.public.orders (
    order_id varchar(30),
    amount int,
    profit int,
    quantity int,
    category varchar(30),
    subcategory varchar(30)
);



-- prepare stage object

create or replace stage copy_db.public.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';
    
-- prepare stage object

create or replace stage copy_db.public.aws_stage_copy
    url='s3://snowflakebucket-copyoption/returnfailed/';
    
list @copy_db.public.aws_stage_copy;    


select * from copy_db.public.orders limit 10;



copy into copy_db.public.orders
    from @aws_stage_copy
    file_format = (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;
    
    
copy into copy_db.public.orders
    from @aws_stage_copy
    file_format = (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;
    

list @copy_db.public.aws_stage_copy; 
    
   
    

-- storing rejected/failed results in a table
create or replace table rejected as 
select rejected_record from table(result_scan(last_query_id()));


insert into rejected 
select rejected_record from table(result_scan('01a877dc-0004-32d0-0037-d087000119a2'));


select * from rejected;


create or replace table rejected_values as 
select 
split_part(rejected_record,',',1) as order_id, 
split_part(rejected_record,',',2) as amount,
split_part(rejected_record,',',3) as profit,
split_part(rejected_record,',',4) as quantity,
split_part(rejected_record,',',5) as category,
split_part(rejected_record,',',6) as subcategory
from rejected;


select * from rejected_values;


select * from information_schema.load_history;

--- To see loading history
select * from snowflake.account_usage.load_history;


--Filter on specific table & schema
select * from snowflake.account_usage.load_history
    where schema_name = 'PUBLIC' and table_name = 'ORDERS_EX' and coalesce(error_count,0) > 0;






