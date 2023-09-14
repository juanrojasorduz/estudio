-- create a stored procedure
use task_db;

select * from customers;

create or replace procedure customers_insert_procedure (create_date varchar)
    returns string not null
    language javascript
    as                        -- It has just one variab
        $$
        var sql_command = 'INSERT INTO CUSTOMERS(CREATE_DATE) VALUES(:1);'
        snowflake.execute(
            {
            sqlText: sql_command,
            binds: [CREATE_DATE]
            });
        return "Successfully executed.";
        $$;
                    
create or replace task customer_taks_procedure
warehouse = compute_wh
schedule = '1 MINUTE'
as call  customers_insert_procedure (current_timestamp);

show tasks;

alter task customer_taks_procedure resume;

select * from customers;

-- Suspend the task
alter task customer_taks_procedure suspend;