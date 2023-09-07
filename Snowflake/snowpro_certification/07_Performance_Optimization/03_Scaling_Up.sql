-------Implement Scaling Up
--Changing the size of the virtual warehouse
---depending on different work loads in different periods

-- Here we change the warehouse size from SMALL to XSMALL
ALTER WAREHOUSE COMPUTE_WH
SET WAREHOUSE_SIZE='XSMALL';

-- Here we change the warehouse size from XSMALL to SMALL
ALTER WAREHOUSE COMPUTE_WH
SET WAREHOUSE_SIZE='SMALL';

