/* Examining Data Errors */
%let path-/folders/myshortcuts/otherfiles;
/*raw data, so we use the infile and input statements */
data work.emps;
       length First $ 12 Last $ 15 Age 8  Region $ 15 Office $ 15;
       infile "&path/93641.csv" dlm=',';
       input First $ Last $ Age Region $ Office $;
run;
/* print the imported Datasets */
proc print data=work.emps;
run;


 
/* Handling Data Errors */ 
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Age 8 Region $15 Office $ 15;
       infile "&path/93642.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Age Region $ Office $;
       if missing (Age) then Age=33;
       if missing (Region) then Region='North America';
run;
/* print the imported dataset */
title "List of Employees";
proc print data=work.emps;
run;



/* Validating Data Using PRINT and WHERE */ 
%let path=/folder/,yshortcuts/otherfiles;
/* Import the csv file so we can examine/ validate the data */
data work.employees;
       length Employee_ID 8 First _Name Last_Name $ 15 Department $ 12 Salary 8;
       infile "&path/emps_sales_93643.csv" dlm=',';
       input Employee_ID First_Name $ Last_Name $ Department $ Salary Start_Date :mmddyy.;
       format Start_Date mmddyy10.;
run;
/*
       Let's imagine that we only want observations where the employee's
       Start_Date is before July 15, 2006 (The day the company started business)
*/
proc print data=work.employees;
var Employee_ID First_Name Last_Name Start_Date;
where Start_Date < '15Jul2006'd;
run;



/* Validating Data Using FREQ and TABLES */
/* data work.employees Code: */
/* Import the csv file so we can examine / validate the data */
data work.employees;
length Employee_ID 8 First_Name Last_Name $ 15 Department $ 12 Salary 8;
infile "&path/emps_sales_93644.csv" dlm=',';
input Employee_ID First_Name $ Last_Name $ Department $ Salary STart_Date :mmddyy.;
format Start_Date mmddyy10.;
run;
/* proc freq Code: */
/*
Let's look at some frequency data to see if we can spot any invalid values for
Employee_ID (which should be unique), and Department (Only sales and marketing are valid)
*/
proc freq data=work.employees nlevels;
       tables Employee_ID Department;
run; 


 
/* Validating Data Using MEANS and VAR */
/* Import the csv file so we can examine / validate the data */
/* data work.employees Code: */
data work.employees;
       length Employee_ID 8 First_Name Last_Name $ 15 Department $ 12 Salary 8;
       infile "&path/emps_sales_93645.csv" dlm=',' dsd;
       input Employee_ID First_Name $ Last_Name $ Department $ Salary Start_Date :mmddyy.;
       format Start_Date mmddyy10.;
run;
/* proc means Code: */
/* Let's look at some descriptive statistics for the employee's salaries */
proc means data=work.employees n nmiss min max;
       var Salary;
run;


 
/* Validating Data Using UNIVARIATE and VAR */
/* Import the csv file so we can examine / validate the data */
data work.employees;
       length Employee_ID 8 First_Name Last_Name $ 15 Department $ 12 Salary 8;
       infile "&path/emps_sales_93646.csv" dlm=',' dsd;
       input Employee_ID First_Name $ Last_Name $ Department $ Salary Start_Date :mmddyy.;
       format Start_Date mmddyy10.;
run;
/* Let's have a look at some summary reports of descriptive statistics
for the employee's salaries
*/
proc univariate data=work.employees nextrobs=1 ;
       var Salary;
run;


 
/* Cleaning Data at the Source */ 
/* Let's import some data to practice with */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Age 8 Region $ 15 Office $ 15;
       infile "&path/emps_sales_93647.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Age Region $ Office $;
       if missing(Age) then Age=99;
run;
/* print the imported dataset */
title "List of Employees";
proc print data=work.emps;
run;   



/* Cleaning Data Using Assignment Statements */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Age 8 Region $ 15 Office $ 15;
       infile "&path/emps_sales_93648.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Age Region $ Office $;
       *Region=upcase (Region);
       *Office-propcase (Office);
run;
/* print the imported dataset */
title "List of Employees";

proc print data=work.emps;
run;    


 
/* Cleaning Data Using Conditionals in the DATA Step */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Age 8 Region $ 15 Office $ 15;
       infile "&path/emps_sales_93649.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Age Region $ Office $;
       *if missing(Age) then Age=33;
       *if missing (Region) then Region=('USA') ;
run;
/* print the imported dataset */
title "List of Employees";
proc print data=work.emps;
run;  



/* Creating Variables with DATA Step Assignments */
/* Let's import some data to practice with */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Region $ 15 Office $ 15;
       infile "$path/emps_sales_93650.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Department $ Sales Region $ Office $;
       
       if Department='sales' then
               Commission=.15*Sales;
       else if Department='marketing' then
               Bonus=.025*Sales;
               
       if missing (Commission) then
               Commission=0;
       
       if missing (Bonus) then
               Bonus=0;
run;
/* print the imported dataset */
title "Commission and Bonus";
proc print data=work.emps;
run;


 
/* Creating Values Using Operators and SAS Functions */ 
/* Let's import some data to practice with */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
               Base_Salary Sales_Bonus 8 Total_Payment 8;
       infile "$path/emps_sales_93651.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Department $ Sales Commission Base_Salary
               Sales_Bonus Total_Payment;       
/* set bonus levels and total payments */
       if Department='marketing' then
               Sales_Bonus=.025*Sales;
       else if Department='sales' then
               Sales_Bonus=.05*Sales;
       Total_Payment=sum(Sales_Bonus, Commission, Base_Salary);        
run;
/* print the imported dataset */
title "Monthly Payment";
proc print data=work.emps;
run;
