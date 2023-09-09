// Create table first
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.movie_titles (
  show_id STRING,
  type STRING,
  title STRING,
  director STRING,
  cast STRING,
  country STRING,
  date_added STRING,
  release_year STRING,
  rating STRING,
  duration STRING,
  listed_in STRING,
  description STRING );
  
  

// Create file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;
    
    
 // Create stage object with integration object & file format object
CREATE OR REPLACE stage MANAGE_DB.external_stages.csv_folder
    URL = 's3://bucketforsnowflakejd/csv/' -- We Paste the bucket S3 URI
    STORAGE_INTEGRATION = s3_int -- We paste the storage integration name that we created previously
    FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat; -- We paste the file format name that we created previously



// Use Copy command to load the data from the bucket      
COPY INTO OUR_FIRST_DB.PUBLIC.movie_titles
    FROM @MANAGE_DB.external_stages.csv_folder;
    
-- We got an error in the previous execution because there is a value that have multiple comas, So ..
-- ... we have to an additional field to separate the columns which is FIELD_OPTIONALLY_ENCLOSED_BY to use "" as an ..
-- extra delimiter
    
// Create file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE    
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' ;

-- Then we execute this query again to load the data:
COPY INTO OUR_FIRST_DB.PUBLIC.movie_titles
    FROM @MANAGE_DB.external_stages.csv_folder;

--- Then we prove if the data was loaded correctly with:

SELECT * FROM OUR_FIRST_DB.PUBLIC.movie_titles;
    