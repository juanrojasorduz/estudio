-- Using the traditional method to schedule the task 
create or replace task task_db.public.customer_insert
    warehouse = compute_wh
    schedule = '60 MINUTE'
    as 
    insert into customers(create_date) values(current_timestamp);

-- Using the cron method to schedule the task 
create or replace task task_db.public.customer_insert
    warehouse = compute_wh
    schedule = 'USING CRON 0 7,10 * * 5L UTC'  -- We have to define the value for each * : 'USING CRON * * * * * TIMEZONE'
    as 
    insert into customers(create_date) values(current_timestamp);
    

-- 0 7,10 * * 5L:

    -- *: 0    :  Every full hour this would be executed
    -- *: 7,10 :  Every full hour but it has to be 7 am o'clock or 10 am o'clock
    -- *: *    :
    -- *: *    :
    -- *: 5L   :  Every full hour but it has to be 7 am o'clock or 10 am o'clock and last friday of the month
    
-- Timezone: UTC
-- Last Day of the month

-- __________ minute (0-59)
-- | ________ hour (0-23) for range (7-10)
-- | | ______ day of month (1-31, or L)
-- | | | ____ month (1-12, JAN-DEC)
-- | | | | __ day of week (0-6, SUN-SAT, or L) 
-- | | | | |
-- | | | | |
-- * * * * *

-- every minute
-- schedule = 'USING CRON * * * * * UTC';

-- every day at 6am utc timezone
-- schedule = 'USING CRON 0 6 * * * UTC';

-- every hour starting at 9 am and ending at 5 pm on sundays 
-- schedule = 'USING CRON 0 9-17 * * SUN America/Los_Angeles';


create or replace task customer_insert
    warehouse = compute_wh
    schedule = 'USING CRON 0 9,17 * * * UTC'
    as 
    insert into customers(create_date) values(current_timestamp);

show tasks;
  