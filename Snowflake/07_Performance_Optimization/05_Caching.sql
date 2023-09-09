
-- We execute this query:

SELECT AVG(C_BIRTH_YEAR) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.CUSTOMER

-- Then we select the query id which is in the execution panel, for example: 01aed570-0004-bcbd-0000-0000ab73f16d
-- When we select we can see two pages which are the query details page and also the query profile page, in the profile page..
-- .. we see that there are three steps in which snowflake executes this query, which are:
    -- 1) Table scan: SNOWFLAKE_SAMPLE_DATA . TPCDS_SF100TCL_OLD . CUSTOMER
    -- 2) Aggregate: SUM(CUSTOMER.C_BIRTH_YEAR)
    -- 3) Result[0]: SCALED_ROUND_INT_DIVIDE(SUM(CUSTOMER.C_BIRTH_YEAR), 96499144)

-- We execute this query again
SELECT AVG(C_BIRTH_YEAR) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.CUSTOMER
-- Then we select the query id and go to profile page, we will see that the processing use just one step which is:
    -- 1) Query Result Reuse[0] -- This means that the result has been used from this cache


--- What happens If we use another user to execute this query? 
// Setting up an additional user
CREATE ROLE DATA_SCIENTIST;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE DATA_SCIENTIST;

CREATE USER DS1 PASSWORD = 'DS1' LOGIN_NAME = 'DS1' DEFAULT_ROLE='DATA_SCIENTIST' DEFAULT_WAREHOUSE = 'DS_WH'  MUST_CHANGE_PASSWORD = FALSE;
GRANT ROLE DATA_SCIENTIST TO USER DS1;


-- We login with the user 'DS1' and the execute the query using the same warehouse

SELECT AVG(C_BIRTH_YEAR) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.CUSTOMER

-- Then we open the query ID to see the profile panel, then we see that the execution used the following step:
	-- Query Result Reuse[0] -- This means that the result has been used from the same cache 

-- IMPORTANT: The cache is used for the same datawarehouse and not for every user