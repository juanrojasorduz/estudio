CREATE OR REPLACE WAREHOUSE COMPUTE_WAREHOUSE --Creates a new virtual warehouse in the system
WITH
WAREHOUSE_SIZE=XSMALL -- Specifies the size of the virtual warehouse. 
MAX_CLUSTER_COUNT= 3 -- Specifies the maximum number of clusters for a multi-cluster warehouse.
AUTO_SUSPEND= 300 -- Specifies the number of seconds of inactivity after which a warehouse is automatically suspended.
AUTO_RESUME= TRUE -- Specifies whether to automatically resume a warehouse when a SQL statement (e.g. query) is submitted to it.
INITIALLY_SUSPENDED= TRUE -- Specifies whether the warehouse is created initially in the ‘Suspended’ state.
COMMENT = 'This is our second warehouse'; -- Specifies a comment for the warehouse.

DROP WAREHOUSE COMPUTE_WAREHOUSE; -- Removes the specified virtual warehouse from the system.

-- We can use another Util statements for warehouse porpuses

DESCRIBE WAREHOUSE COMPUTE_WH; --Describes the warehouse. For example, shows the date that the warehouse was created.

SHOW WAREHOUSES; --Lists all the warehouses in your account for which you have access privileges.

USE WAREHOUSE COMPUTE_WH; --Specifies the active/current warehouse for the session.