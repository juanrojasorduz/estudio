-- Select the database
use task_db;

-- Show tasks 
show tasks;

-- Verify the table
select * from task_db.public.customers limit 10;

-- prepare a second table
create or replace table task_db.public.customers2 (
    customer_id int,
    first_name varchar(40),
    create_date date);
        
-- suspend parent task
alter task task_db.public.customer_insert suspend;
    
-- create a child task
create or replace task task_db.public.customer_insert2
    warehouse = compute_wh
    after customer_insert
    as 
    insert into customers2 select * from customers;
    
    
-- prepare a third table
create or replace table task_db.public.customers3 (
    customer_id int,
    first_name varchar(40),
    create_date date,
    insert_date date default date(current_timestamp));
    

-- create a child task
create or replace task task_db.public.customer_insert3
    warehouse = compute_wh
    after customer_insert2
    as 
    insert into customers3 (customer_id,first_name,create_date) select * from customers2;


show tasks;

alter task task_db.public.customer_insert 
set schedule = '1 MINUTE';

-- resume tasks (first root task)
alter task customer_insert3 resume;
alter task customer_insert2 resume;
alter task customer_insert resume;

select * from customers2;

select * from customers3;

-- suspend tasks again
alter task customer_insert suspend;
alter task customer_insert2 suspend;
alter task customer_insert3 suspend;

-- Verify that all tasks are suspended
show tasks;