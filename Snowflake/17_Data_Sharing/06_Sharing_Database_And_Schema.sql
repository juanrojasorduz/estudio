show shares;

-- Create share object
create or replace share complete_schema_share;

-- Grant usage on dabase & schema
grant usage on database our_first_db to share complete_schema_share;
grant usage on schema our_first_db.public to share complete_schema_share;

-- Grant select on all tables
grant select on all tables in schema our_first_db.public to share complete_schema_share;
grant select on all tables in database our_first_db to share complete_schema_share;

-- Add destination account to share
alter share complete_schema_share
add account=djb31677;


------ Go to the destination account and execute these: ------

-- Show all shares (Consumer & producers)
show shares;

-- See details on share
desc share evczbcg.vib37232.complete_schema_share;

-- Create database in consumer account using the share
create database our_first_db_share from share evczbcg.vib37232.complete_schema_share;

-- Validate the table access
select * from our_first_db_share.public.orders limit 10;


-- If we alter the composition of the dabase in the producer account we will need to grant access to ...
-- ..  those objects in the consumer account

-- Updating data
update our_first_db_share.public.orders
set profit=0 where profit < 0;

-- Add new table
create table our_first_db.public.new_table (id int);
