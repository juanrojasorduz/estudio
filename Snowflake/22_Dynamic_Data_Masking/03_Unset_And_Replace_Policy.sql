
-- #### more examples  #####

use role accountadmin;

--- 1) apply policy to multiple columns

-- apply policy on a specific column 
alter table if exists customers modify column full_name 
set masking policy phone;

-- apply policy on another specific column 
alter table if exists customers modify column phone
set masking policy phone;

-- validating policies
use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;

use role accountadmin;


--- 2) replace or drop policy
-- If we try to drop or replace this polity we cannot do it because we have to first unset the policy
drop masking policy phone;

create or replace masking policy phone as (val varchar) returns varchar ->
            case
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else concat(left(val,2),'*******')
            end;

-- list and describe policies
desc masking policy phone;
show masking policies;

-- show columns with applied policies - Verify which column using the field REF_COLUMN_NAME
select * from table(information_schema.policy_references(policy_name=>'phone'));

-- remove policy before replacing/dropping 
alter table if exists customers modify column full_name 
unset masking policy;

alter table if exists customers modify column email
unset masking policy;

alter table if exists customers modify column phone
unset masking policy;

-- Verify if there is a column with policy masking
select * from table(information_schema.policy_references(policy_name=>'phone'));
select * from table(information_schema.policy_references(policy_name=>'names'));

-- Now we can replace the policy phone and create a new one for names
create or replace masking policy phone as (val varchar) returns varchar ->
            case
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else concat(left(val,2),'*******')
            end;
            
create or replace masking policy names as (val varchar) returns varchar ->
            case
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else concat(left(val,2),'*******')
            end;

-- apply policy
alter table if exists customers modify column full_name
set masking policy names;

alter table if exists customers modify column phone
set masking policy phone;

-- validating policies
use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;

use role accountadmin;

