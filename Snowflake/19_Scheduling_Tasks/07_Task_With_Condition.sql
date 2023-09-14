-- set the database task_db
use task_db;

-- Prepare table
create or replace table task_db.public.customers (
    customer_id int autoincrement start = 1 increment =1,
    first_name varchar(40) default 'JENNIFER' ,
    create_date date);

-- Create task
create or replace task customer_insert
    warehouse = compute_wh
    schedule = '1 MINUTE' -- Interval in minutes
    when 1=2 -- Condition
    as 
    insert into customers(create_date,first_name) values(current_timestamp,'MIKE'); -- Specify the SQL statement that executes the task

-- Create task 2
create or replace task customer_insert2
    warehouse = compute_wh
    schedule = '1 MINUTE' -- Interval in minutes
    when 1=1 -- Condition
    as 
    insert into customers(create_date,first_name) values(current_timestamp,'DEBIKA');


show tasks;

-- We resume both tasks
alter task customer_insert resume;
alter task customer_insert2 resume;

show tasks;

-- We verify how the table customers changes
select * from customers;

-- We see the task history details (We see the condition text and state field):
select * from table(information_schema.task_history())
order by scheduled_time desc;

-- We have to suspend both tasks
alter task customer_insert suspend;
alter task customer_insert2 suspend;

-- We verify the task status:
show tasks;

