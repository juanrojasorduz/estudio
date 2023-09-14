-- ******* update 1 ********

select * from sales_raw_staging;     
        
select * from sales_stream;

-- We do an update in the source table
update sales_raw_staging
set product ='potato' where product = 'banana';

--We verify this change in the table and stream object:
select * from sales_raw_staging; 
select * from sales_stream;

-- We can use a merge to update the changes into target table
merge into sales_final_table f      -- target table to merge changes from source table
using sales_stream s   -- stream that has captured the changes             
   on  f.id = s.id                 
when matched 
    and s.metadata$action ='INSERT'
    and s.metadata$isupdate ='TRUE'        -- indicates the record has been updated 
    then update 
    set f.product = s.product,
        f.price = s.price,
        f.amount= s.amount,
        f.store_id=s.store_id;
        
-- We verify the changes in target table
select * from sales_final_table;

-- We verify source table
select * from sales_raw_staging;     

-- We verify that records on stream have been deleted
select * from sales_stream;

-- We can repeat the same process for another record
-- ******* update 2 ********

update sales_raw_staging
set product ='green apple' where product = 'apple';

--We verify this change in the table and stream object:
select * from sales_raw_staging; 
select * from sales_stream;

merge into sales_final_table f      -- target table to merge changes from source table
using sales_stream s                -- stream that has captured the changes
   on  f.id = s.id                 
when matched 
    and s.metadata$action ='INSERT'
    and s.metadata$isupdate ='TRUE'        -- indicates the record has been updated 
    then update 
    set f.product = s.product,
        f.price = s.price,
        f.amount= s.amount,
        f.store_id=s.store_id;

-- We verify the changes in target table
select * from sales_final_table;

-- We verify source table
select * from sales_raw_staging;     

-- We verify that records on stream have been deleted
select * from sales_stream;