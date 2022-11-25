-- create file format and stage object

create or replace file format manage_db.file_formats.parquet_format
    type = 'parquet';
    
create or replace stage manage_db.external_stages.parquetstage
    url = 's3://snowflakeparquetdemo'
    file_format = manage_db.file_formats.parquet_format;
    
-- preview the data

list @manage_db.external_stages.parquetstage;

select * from @manage_db.external_stages.parquetstage limit 10;


--file format in queries
//create or replace stage manage_db.external_stages.parquetstage
//    url = 's3://snowflakeparquetdemo';
//
//select * from @manage_db.external_stages.parquetstage
//(file_format => 'manage_db.file_formats.parquet_format') limit 10;

-- queries can be omitted in case of the current namespace

use manage_db.file_formats;

select * from @manage_db.external_stages.parquetstage
(file_format => manage_db.file_formats.parquet_format) limit 10;


--syntax for querying unstructed data
select
$1:__index_level_0__::int as index_level,
$1:cat_id::varchar(50) as category,
date($1:date::int) as date,
$1:dept_id::varchar(50) as dept_id,
$1:id::varchar(50) as id,
$1:item_id::varchar(50) as item_id,
$1:state_id::varchar(50) as state_id,
$1:store_id::varchar(50) as store_id,
$1:value::int as value
from @manage_db.external_stages.parquetstage limit 10;



select 
current_timestamp as timestamp,
to_timestamp_ntz(current_timestamp) as timestamp_ntz;


--create destination table

create or replace table our_first_db.public.parquet_data (
  row_number int,
  index_level int,
  cat_id varchar(50),
  date date,
  dept_id varchar(50),
  id varchar(50),
  item_id varchar(50),
  state_id varchar(50),
  store_id varchar(50),
  value int,
  load_date timestamp default to_timestamp_ntz(current_timestamp)
);


--load the parquet data

copy into our_first_db.public.parquet_data
from (
select  
metadata$file_row_number,  
$1:__index_level_0__::int,
$1:cat_id::varchar(50),
date($1:date::int),
$1:dept_id::varchar(50),
$1:id::varchar(50),
$1:item_id::varchar(50),
$1:state_id::varchar(50),
$1:store_id::varchar(50),
$1:value::int,  
to_timestamp_ntz(current_timestamp)     
from @manage_db.external_stages.parquetstage)
;


select * from our_first_db.public.parquet_data limit 10;














