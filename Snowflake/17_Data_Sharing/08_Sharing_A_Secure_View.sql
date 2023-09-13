show shares;

-- create share object
create or replace share view_share;

-- grant usage on dabase & schema
grant usage on database customer_db to share view_share;
grant usage on schema customer_db.public to share view_share;

-- grant select on view
grant select on view  customer_db.public.customer_view to share view_share; -- We cannot share a not secure view
grant select on view  customer_db.public.customer_view_secure to share view_share;


-- add account to share
alter share view_share
add account=djb31677;


------ Go to the consumer account and execute: ----------

-- Show all shares (Consumer & producers)
show shares;

-- See details on share
desc share evczbcg.vib37232.view_share;

-- Create database in consumer account using the share
create database view_share_db from share evczbcg.vib37232.view_share;

-- Validate the table access
select * from view_share_db.public.customer_view_secure limit 10;
