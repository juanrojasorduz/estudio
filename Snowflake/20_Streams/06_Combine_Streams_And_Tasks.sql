use streams_db;

------- automatate the updates using tasks --
create or replace task all_data_changes
    warehouse = compute_wh
    schedule = '1 minute'
    when system$stream_has_data('sales_stream')  -- Verify if there id data in the stream "sales_stream"
    as 
merge into sales_final_table f      -- target table to merge changes from source table
using ( select stre.*,st.location,st.employees
        from sales_stream stre
        join store_table st
        on stre.store_id = st.store_id
       ) s
on f.id=s.id
when matched                        -- delete condition
    and s.metadata$action ='DELETE' 
    and s.metadata$isupdate = 'FALSE'
    then delete                   
when matched                        -- update condition
    and s.metadata$action ='INSERT' 
    and s.metadata$isupdate  = 'TRUE'       
    then update 
    set f.product = s.product,
        f.price = s.price,
        f.amount= s.amount,
        f.store_id=s.store_id
when not matched 
    and s.metadata$action ='INSERT'
    then insert 
    (id,product,price,store_id,amount,employees,location)
    values
    (s.id, s.product,s.price,s.store_id,s.amount,s.employees,s.location);

-- We verify the status of this task
show tasks;  

-- We start the task using:
alter task all_data_changes resume;

-- We see if task is in started state 
show tasks;

// we make some changes into the source table 

insert into sales_raw_staging values (11,'milk',1.99,1,2);
insert into sales_raw_staging values (12,'chocolate',4.49,1,2);
insert into sales_raw_staging values (13,'cheese',3.89,1,1);

update sales_raw_staging
set product = 'chocolate bar'
where product ='chocolate';
       
delete from sales_raw_staging
where product = 'mango';    

// verify results
select * from sales_raw_staging;     
        
select * from sales_stream;

select * from sales_final_table;

// verify the history
select *
from table(information_schema.task_history())
order by name asc,scheduled_time desc;

-- Finally we suspend the task (IMPORTANT)
alter task all_data_changes suspend;

-- Verify the status of task
show tasks;