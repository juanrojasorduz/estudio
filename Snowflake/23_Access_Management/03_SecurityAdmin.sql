-- securityadmin role --
--  create and manage roles & users --


-- create sales roles & users for sales--

create role sales_admin;
create role sales_users;

-- create hierarchy
grant role sales_users to role sales_admin;

-- as per best practice assign roles to sysadmin
grant role sales_admin to role sysadmin;


-- create sales user
create user simon_sales password = '123' default_role =  sales_users 
must_change_password = true;
grant role sales_users to user simon_sales;

-- create user for sales administration
create user olivia_sales_admin password = '123' default_role =  sales_admin
must_change_password = true;
grant role sales_admin to user  olivia_sales_admin;

-----------------------------------

-- create sales roles & users for hr--

create role hr_admin;
create role hr_users;

-- create hierarchy
grant role hr_users to role hr_admin;

-- this time we will not assign roles to sysadmin (against best practice)
-- grant role hr_admin to role sysadmin;


-- create hr user
create user oliver_hr password = '123' default_role =  hr_users 
must_change_password = true;
grant role hr_users to user oliver_hr;

-- create user for sales administration
create user mike_hr_admin password = '123' default_role =  hr_admin
must_change_password = true;
grant role hr_admin to user mike_hr_admin;
