// Publicly accessible staging area    

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage

LIST @MANAGE_DB.external_stages.aws_stage;

//Load data using copy command

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*OrderDetails.*';
    

// Create table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_CACHING (
ORDER_ID	VARCHAR(30)
,AMOUNT	NUMBER(38,0)
,PROFIT	NUMBER(38,0)
,QUANTITY	NUMBER(38,0)
,CATEGORY	VARCHAR(30)
,SUBCATEGORY	VARCHAR(30)
,DATE DATE)   ; 



INSERT INTO OUR_FIRST_DB.PUBLIC.ORDERS_CACHING
SELECT
t1.ORDER_ID
,t1.AMOUNT	
,t1.PROFIT	
,t1.QUANTITY	
,t1.CATEGORY	
,t1.SUBCATEGORY	
,DATE(UNIFORM(1500000000,1700000000,(RANDOM())))
FROM OUR_FIRST_DB.PUBLIC.ORDERS t1
CROSS JOIN (SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS) t2
CROSS JOIN (SELECT TOP 100 * FROM OUR_FIRST_DB.PUBLIC.ORDERS) t3;


// Query Performance before Cluster Key
-- If we run this query we will see that most of time is consumed by table scan
-- Also in profile we can see in the statistics section that all the partitions were scanned

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_CACHING  WHERE DATE = '2020-06-09';


-- So we will see if the time consumed in scan is better using a cluster key

// Adding Cluster Key & Compare the result
-- To see this change effective we need to wait more than one hour to execute the query again
-- In this case just three partitions were scanned over 59
ALTER TABLE OUR_FIRST_DB.PUBLIC.ORDERS_CACHING CLUSTER BY ( DATE ) ;

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_CACHING  WHERE DATE = '2020-01-07';


// Not ideal clustering & adding a different Cluster Key using function
-- If we execute this query  using an expression MONTH(DATE) for the filter the cluster key "DATE" will not be effective, so ...
-- ... we need to redefine the cluster key and then execute the query
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_CACHING  WHERE MONTH(DATE)=11;

ALTER TABLE OUR_FIRST_DB.PUBLIC.ORDERS_CACHING CLUSTER BY ( MONTH(DATE) );

-- After modify the cluster key we will see that the scan process is more efective
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_CACHING  WHERE MONTH(DATE)=11;


drop table OUR_FIRST_DB.PUBLIC.ORDERS_CACHING