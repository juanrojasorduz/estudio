--To evaluate this feature, we can modify a warehouse to have multicluster feature enabled 
--using for example a maximum of 3 clusters and standard scaling policy

--Then we can create 10 worksheets and paste this query in each one: 

SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.WEB_SITE T1
CROSS JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.WEB_SITE T2
CROSS JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.WEB_SITE T3
CROSS JOIN (SELECT TOP 57 * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL_OLD.WEB_SITE)  T4;

--Then execute all of the worksheets at the same time 

--Because of these queries requires a lot of computing capacity the warehouse will active more clusters in order to
--execute these queries. So that is a great example to use the "Scaling Out"

--We can monitor this activity if we go to warehouse section and the we see the activity for the warehouse
 



