
-------------------- stream example: insert ------------------------
create or replace transient database streams_db;

-- create example table 
create or replace table sales_raw_staging(
  id varchar,
  product varchar,
  price varchar,
  amount varchar,
  store_id varchar);
  
-- insert values 
insert into sales_raw_staging 
    values
        (1,'banana',1.99,1,1),
        (2,'lemon',0.99,1,1),
        (3,'apple',1.79,1,2),
        (4,'orange juice',1.89,1,2),
        (5,'cereals',5.98,2,1);  

create or replace table store_table(
  store_id number,
  location varchar,
  employees number);

insert into store_table values(1,'chicago',33);
insert into store_table values(2,'london',12);

create or replace table sales_final_table(
  id int,
  product varchar,
  price number,
  amount int,
  store_id int,
  location varchar,
  employees int);

 -- insert into final table
insert into sales_final_table 
    select 
    sa.id,
    sa.product,
    sa.price,
    sa.amount,
    st.store_id,
    st.location, 
    st.employees 
    from sales_raw_staging sa
    join store_table st on st.store_id=sa.store_id ;

-- create a stream object to capture changes in sales_raw_changes
create or replace stream sales_stream on table sales_raw_staging;

-- We see the streams we have created, we can see the type equal to DELTA
show streams;

desc stream sales_stream;

-- get changes on data using stream (inserts)
select * from sales_stream;

-- We can see how is the table now
select * from sales_raw_staging;
                                        
-- insert values to evalute stram object
insert into sales_raw_staging  
    values
        (6,'mango',1.99,1,2),
        (7,'garlic',0.99,1,1);
        
-- get changes on data using stream (inserts)
select * from sales_stream;

select * from sales_raw_staging;

-- We can see that new rows are not in the target table
select * from sales_final_table;        
        
-- So we need to consume stream object to have the new rows inserted
insert into sales_final_table 
    select 
    sa.id,
    sa.product,
    sa.price,
    sa.amount,
    st.store_id,
    st.location, 
    st.employees 
    from sales_stream sa
    join store_table st on st.store_id=sa.store_id ;

-- Now we have new records added
select * from sales_final_table;  

-- So the stream records have been deleted after consuming them
select * from sales_stream;

-- So we can repeat this process again and the results will be the same

-- insert values 
insert into sales_raw_staging  
    values
        (8,'paprika',4.99,1,2),
        (9,'tomato',3.99,1,2);
               
 -- consume stream object
insert into sales_final_table 
    select 
    sa.id,
    sa.product,
    sa.price,
    sa.amount,
    st.store_id,
    st.location, 
    st.employees 
    from sales_stream sa
    join store_table st on st.store_id=sa.store_id ;
                     
select * from sales_final_table;        

select * from sales_raw_staging;     
        
select * from sales_stream;
