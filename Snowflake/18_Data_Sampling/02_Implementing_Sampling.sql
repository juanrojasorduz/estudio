-- Create a sampling database named sampling_db
create or replace transient database sampling_db;

--Method 1: Rows
-- Creating a sample
create or replace view sampling_db.public.address_sample
as 
select * from snowflake_sample_data.tpcds_sf10tcl.customer_address 
sample row (1) seed(27); -- Using the method row for sampling, using a 1% percentage that every single raw is included
                         -- If another developer whants to get the same sampling has to specify the same seed       
-- Veryfing the view
select count(*) from sampling_db.public.address_sample limit 10;


-- Calculate the percentage of each location type
select ca_location_type, (count(*)/324576)*100
from sampling_db.public.address_sample
group by ca_location_type;


-- Method 2: Blocks
select count(*) from snowflake_sample_data.tpcds_sf10tcl.customer_address 
sample system (1) seed(23); --Using a 1% of every block

select count(*) from snowflake_sample_data.tpcds_sf10tcl.customer_address 
sample system (10) seed(23); --Using a 10% of every block