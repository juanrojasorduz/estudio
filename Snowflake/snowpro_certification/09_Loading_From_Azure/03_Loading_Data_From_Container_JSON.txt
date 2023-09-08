
--- Load JSON ----

 
create or replace file format manage_db.public.fileformat_azure_json
    TYPE = JSON;
  
  
create or replace stage manage_db.public.stage_azure
    STORAGE_INTEGRATION = azure_integration
    URL = 'azure://jdsnowstorageaccount.blob.core.windows.net/jdsnowflakejson'
    FILE_FORMAT = fileformat_azure_json; 
  
LIST  @manage_db.public.stage_azure;

-- Query from stage  
SELECT * FROM @manage_db.public.stage_azure;  


-- Query one attribute/column
SELECT $1:"Car Model" FROM @manage_db.public.stage_azure; 
  
-- Convert data type  
SELECT $1:"Car Model"::STRING FROM @manage_db.public.stage_azure; 

-- Query all attributes  
SELECT 
$1:"Car Model"::STRING, 
$1:"Car Model Year"::INT,
$1:"car make"::STRING, 
$1:"first_name"::STRING,
$1:"last_name"::STRING
FROM @manage_db.public.stage_azure;   
  
-- Query all attributes and use aliases 
SELECT 
$1:"Car Model"::STRING as car_model, 
$1:"Car Model Year"::INT as car_model_year,
$1:"car make"::STRING as "car make", 
$1:"first_name"::STRING as first_name,
$1:"last_name"::STRING as last_name
FROM @manage_db.public.stage_azure;     


Create or replace table manage_db.public.car_owner (
    car_model varchar, 
    car_model_year int,
    car_make varchar, 
    first_name varchar,
    last_name varchar);
 
COPY INTO manage_db.public.car_owner
FROM
(SELECT 
$1:"Car Model"::STRING as car_model, 
$1:"Car Model Year"::INT as car_model_year,
$1:"car make"::STRING as "car make", 
$1:"first_name"::STRING as first_name,
$1:"last_name"::STRING as last_name
FROM @manage_db.public.stage_azure);

SELECT * FROM manage_db.public.CAR_OWNER;


-- Alternative: Using a raw file table step
truncate table manage_db.public.car_owner;
select * from manage_db.public.car_owner;

create or replace table manage_db.public.car_owner_raw (
  raw variant);

COPY INTO manage_db.public.car_owner_raw
FROM @manage_db.public.stage_azure;

SELECT * FROM manage_db.public.car_owner_raw;

    
INSERT INTO manage_db.public.car_owner  
(SELECT 
$1:"Car Model"::STRING as car_model, 
$1:"Car Model Year"::INT as car_model_year,
$1:"car make"::STRING as car_make, 
$1:"first_name"::STRING as first_name,
$1:"last_name"::STRING as last_name
FROM car_owner_raw)  ;
  
  
select * from manage_db.public.car_owner;
  