-- create a transient database
create or replace transient database task_db;

-- prepare table
create or replace table task_db.public.customers (
    customer_id int autoincrement start = 1 increment =1,
    first_name varchar(40) default 'JENNIFER' ,
    create_date date);
    
    
-- create task
create or replace task customer_insert
    warehouse = compute_wh
    schedule = '1 MINUTE' -- Interval in minutes
    as 
    insert into customers(create_date) values(current_timestamp); -- Specify the SQL statement that executes the task
    
-- To see the state of tasks
show tasks;

-- task starting and suspending
-- Starting the task
alter task customer_insert resume;
-- Suspending the task
alter task customer_insert suspend;

-- To see how the task is working with de sql statement
select * from task_db.public.customers;
