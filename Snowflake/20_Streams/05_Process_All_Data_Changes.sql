
-- ******* process update,insert & delete simultaneously  ********                
use streams_db;

-- We will see how are the tables:
select * from sales_raw_staging;             
select * from sales_stream;
select * from sales_final_table;    
        
-- The first change will be an insert:
insert into sales_raw_staging values (2,'lemon',0.99,1,1);

-- We see how is the stream object:
select * from sales_stream;

-- We will merge the changes in the target table
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

-- We will see how are the tables:
select * from sales_raw_staging;             
select * from sales_stream;
select * from sales_final_table;    


--- The Second change will be an update
update sales_raw_staging
set product = 'lemonade'
where product ='lemon';

-- We see how is the stream object:
select * from sales_stream;

-- We will merge the changes in the target table
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

-- We will see how are the tables:
select * from sales_raw_staging;             
select * from sales_stream;
select * from sales_final_table;   

-- Finally we will do a delete change
delete from sales_raw_staging
where product = 'lemonade'; 

-- We see how is the stream object:
select * from sales_stream;

-- We will merge the changes in the target table
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

-- We will see how are the tables:
select * from sales_raw_staging;             
select * from sales_stream;
select * from sales_final_table; 


--------------- example 2 ---------------
-- We will do a multiple change
insert into sales_raw_staging values (10,'lemon juice',2.99,1,1);

update sales_raw_staging
set price = 3
where product ='mango';
       
delete from sales_raw_staging
where product = 'potato';    


-- We see how is the stream object and the source table:
select * from sales_raw_staging; 
select * from sales_stream;

-- We will merge the changes in the target table
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

-- We will see how are the tables:
select * from sales_raw_staging;             
select * from sales_stream;
select * from sales_final_table; 