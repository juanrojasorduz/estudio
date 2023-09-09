--- How to load data in a file from a table in snowflake to the stage in GCP
--To do this we need to have the write access in GCP


------- Unload data -----
USE ROLE ACCOUNTADMIN;
USE DATABASE MANAGE_DB;


-- create stage object
create or replace stage manage_db.public.stage_gcp
    STORAGE_INTEGRATION = gcp_integration
    URL = 'gcs://jdsnowflakebucket/csv_happiness'
    FILE_FORMAT = fileformat_gcp;

-- We have to alter the storage integration if we have a new URL,but in this case is just a new folder into a bucket
ALTER STORAGE INTEGRATION gcp_integration
SET  storage_allowed_locations=('gcs://jdsnowflakebucket/', 'gcs://jdsnowflakebucketf/');

SELECT * FROM manage_db.public.happiness;

-- Here we unload the data from the table to a file in this csv folder
COPY INTO @manage_db.public.stage_gcp
FROM
manage_db.public.happiness;
