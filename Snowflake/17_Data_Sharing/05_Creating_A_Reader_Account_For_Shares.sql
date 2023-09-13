-- Make sure to have selected the role of accountadmin

-- Create Reader Account and copy the json response --
create managed account jd_reader_account
admin_name = jd_reader_admin,
admin_password = 'Elmasterdata1993$',
type = reader;

-- Show accounts
show managed accounts;

-- After executing the previous query, copy the locator value "HCB54004" and paste it for reader account id
-- Share the data -- 

alter share orders_share 
add account = hcb54004;

-- If we got problems with the restriccions for the previous query, execute this query
alter share orders_share 
add account =  hcb54004
share_restrictions = false;


---------- Execute these in the reader account--------------------------

-- Open the reader account using the URL we got previously

-- Show all shares (consumer & producers)
show shares;

-- See details on share <owner_account>.<name>
desc share evczbcg.vib37232.orders_share;

-- Create a database in consumer account using the share
create database data_share_db from share evczbcg.vib37232.orders_share;

-- Validate table access - We cannot get data because there are not warehouses created
select * from data_share_db.public.orders limit 10;

-- Setup virtual warehouse
create warehouse read_wh with
warehouse_size='x-small'
auto_suspend = 180
auto_resume = true
initially_suspended = true;

-- So we execute the query again:
select * from data_share_db.public.orders limit 10;

-- Create and set up users --

-- Create user
create user user1 password = 'difficult_passw@ord=123';

-- Grant usage on warehouse
grant usage on warehouse read_wh to role public;

-- Grating privileges on a Shared Database for other users
grant imported privileges on database data_share_db to role public;



