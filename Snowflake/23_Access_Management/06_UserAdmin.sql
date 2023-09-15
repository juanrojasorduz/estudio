-- useradmin --
use role useradmin;
--- user 4 ---
create user ben password = '123' 
default_role = accountadmin 
must_change_password = true;

-- We cannot assign a role that it was not assigned using hierarchy, 
-- The role security_admin can do it
grant role hr_admin to user ben;

use role securityadmin;
grant role hr_admin to user ben;
grant role hr_users to user ben;

-- Fix the role hr_admin to assign it to sysadmin
grant role hr_admin to role sysadmin;

-- Verify who is the owner for each role
show roles;