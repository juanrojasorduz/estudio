-- Show Tasks
show tasks;

-- Use this database
use snowflake;

-- use the table function "task_history()"
select *
  from table(information_schema.task_history())
  order by scheduled_time desc;
  
  
-- see results for a specific task in a given time
select *
from table(information_schema.task_history(
    scheduled_time_range_start=>dateadd('hour',-4,current_timestamp()),
    result_limit => 5,
    task_name=>'customer_insert2'));
  
 
-- see results for a given time period
select *
  from table(information_schema.task_history(
    scheduled_time_range_start=>to_timestamp_ltz('2021-04-22 11:28:32.776 -0700'),
    scheduled_time_range_end=>to_timestamp_ltz('2021-04-22 11:35:32.776 -0700')));  
  
select to_timestamp_ltz(current_timestamp);  
  
  
 