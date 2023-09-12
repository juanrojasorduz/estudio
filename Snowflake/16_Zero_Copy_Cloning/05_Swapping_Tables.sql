--  For tables:
-- ALTER TABLE <table_name>
-- 	SWAP WITH <target_table_name>

-- For schemas:
-- ALTER SCHEMA <table_name>
--	SWAP WITH <target_table_name>



--- Swaping tables

create schema our_first_db.copied_schema;

create table our_first_db.copied_schema.customers
clone our_first_db.public.customers;

select * from our_first_db.copied_schema.customers limit 10;

select * from our_first_db.public.customers limit 10;

delete from our_first_db.copied_schema.customers where id < 500;

select * from our_first_db.copied_schema.customers;

alter table our_first_db.copied_schema.customers
swap with our_first_db.public.customers;

-- Veryfing Results
select * from our_first_db.copied_schema.customers;
select * from our_first_db.public.customers;