-- To set multifactor authentication go to profile 

--- user 1 ---
create user maria password = '123' 
default_role = accountadmin 
must_change_password = true; -- The user has to change password after log in the first time

grant role accountadmin to user maria;


--- user 2 ---
create user frank password = '123' 
default_role = securityadmin 
must_change_password = true;

grant role securityadmin to user frank;


--- user 3 ---
create user adam password = '123' 
default_role = sysadmin 
must_change_password = true;

grant role sysadmin to user adam;