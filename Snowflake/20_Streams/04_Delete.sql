-- ******* delete  ********        
-- First we verify how are the tables:                
select * from sales_final_table;

select * from sales_raw_staging;     
        
select * from sales_stream;    

-- we delete a record from the source table
delete from sales_raw_staging
where product = 'lemon';

-- We verify that the source table has the record deleted and stream table has captured this delete operation:                
select * from sales_raw_staging; 
select * from sales_stream; 

-- ******* process stream  ********            
-- Then we merge that change to have deleted the record in the target table        
merge into sales_final_table f      -- target table to merge changes from source table
using sales_stream s                -- stream that has captured the changes
   on  f.id = s.id          
when matched 
    and s.metadata$action ='DELETE' 
    and s.metadata$isupdate = 'FALSE'
    then delete;            

-- We verify that target table has deleted the record    
select * from sales_final_table;

-- We verify that stream object has deleted the records for the delete operation        
select * from sales_stream; 