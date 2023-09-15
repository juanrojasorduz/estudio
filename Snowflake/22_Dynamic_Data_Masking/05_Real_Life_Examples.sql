-- ### more examples - 1 - ###

use role accountadmin;

-- We create a policy for emails
create or replace masking policy emails as (val varchar) returns varchar ->
case
  when current_role() in ('ANALYST_FULL') then val
  when current_role() in ('ANALYST_MASKED') then regexp_replace(val,'.+\@','*****@') -- leave email domain unmasked
  else '********'
end;

-- apply policy
alter table if exists customers modify column email
set masking policy emails;

-- validating policies
use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;

use role accountadmin;

--### more examples - 2 - ###
-- We create a policy
create or replace masking policy sha2 as (val varchar) returns varchar ->
case
  when current_role() in ('ANALYST_FULL') then val
  else sha2(val) -- return hash of the column value
end;

-- apply policy
-- Unset the previous policy masking
alter table if exists customers modify column full_name
unset masking policy;

-- Set the new policy for full name
alter table if exists customers modify column full_name
set masking policy sha2;

-- validating policies
use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;

use role accountadmin;

--### more examples - 3 - ###
-- We create a policy
create or replace masking policy dates as (val date) returns date ->
case
  when current_role() in ('ANALYST_FULL') then val
  else date_from_parts(0001, 01, 01)::date -- returns 0001-01-01 00:00:00.000
end;

-- apply policy on a specific column 
alter table if exists customers modify column create_date 
set masking policy dates;

-- validating policies

use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;