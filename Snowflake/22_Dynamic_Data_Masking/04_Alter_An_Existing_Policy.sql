-- alter existing policies 

use role analyst_masked;
select * from customers;

use role accountadmin;

-- We alter the policy, so we do not have to unset columns
alter masking policy phone set body ->
case        
 when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
 else '**-**-**'
 end;

-- We verify the changes  
use role analyst_masked;
select * from customers;