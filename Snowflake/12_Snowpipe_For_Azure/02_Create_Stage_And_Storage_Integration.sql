CREATE OR REPLACE DATABASE SNOWPIPE;

-- create integration object that contains the access information
CREATE OR REPLACE STORAGE INTEGRATION azure_snowpipe_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID =  'a8e855ef-303a-4a47-816e-c709a721c7df'  -- Go to estudio/Snowflake/09_Loading_From_Azure/01_Configuring_Containers_And_Snowflake.txt  
  STORAGE_ALLOWED_LOCATIONS = ( 'azure://jdsnowstorageaccount.blob.core.windows.net/jdsnowpipecsv'); -- Go to estudio/Snowflake/09_Loading_From_Azure/01_Configuring_Containers_And_Snowflake.txt  

  

  
-- Describe integration object to provide access
DESC STORAGE integration azure_snowpipe_integration;

-- Go to estudio/Snowflake/09_Loading_From_Azure/01_Configuring_Containers_And_Snowflake.txt
---- Create file format & stage objects ----

-- create file format

create or replace file format snowpipe.public.fileformat_azure
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1;

-- create stage object
create or replace stage snowpipe.public.stage_azure
    STORAGE_INTEGRATION = azure_snowpipe_integration
    URL = 'azure://jdsnowstorageaccount.blob.core.windows.net/jdsnowpipecsv'
    FILE_FORMAT = fileformat_azure;
    

-- list files
LIST @snowpipe.public.stage_azure;

