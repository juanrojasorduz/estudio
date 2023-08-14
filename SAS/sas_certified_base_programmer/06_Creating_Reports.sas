/* Producing a Basic Report */
%let path=/folders/myshortcuts/otherfiles;
/* Let's import some data to practice with */
data work.emps;
   length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
   Base_Salary 8 Region $ 15 Office $ 15;
   infile "&path/emps_sales_reports.csv" dlm=', ' dsd;
   input Emp_ID First $ Last $ Department $ sales Commission Base_Salary Region $ Office $ Start_Date :mddyy.;
   format Start_Date mddyy10.;
/* print a simple report (or listing) */
proc print data=work.emps;
run;
/* print frequency tables */
proc freq data=work.emps;
run;
/* print descriptive statistics */
proc means data=work.emps;
run;


 
/* Producing an Enhanced Report in SAS */ 
%let path=/folders/myshortcuts/otherfiles;
/* You can use the OPTIONS statement to alter the value of SAS system options which can be used to alter the look of a report. Note that you do NOT normally include the OPTIONS statement in a PROC or DATA step
*/
* options ls=64 nocenter nodate;
/* Let's import some data to practice with */
data work.emps;
length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
Base_Salary 8 Region $ 15 Office $ 15;
infile "&path/emps_sales_reports.csv" dlm=', ' dsd;
input Emp_ID First $ Last $ Department $ sales Commission Base_Salary Region $ Office $ Start_Date :mddyy.;
format Start_Date mddyy10.;
/* print the imported data set */
proc print data=work.emps noobs;
 var First Last Region Sales Commission Base_Salary;
 title1 "Sales Employees Report";
 title2 "UK Region";
 footnote1 color=red height=9pt bold 'Internal Use Only';
 footnote2 color=blue height=8pt "&SYSDATE9";
run;



/* Using the LABEL Statement to Add Column Headings */ 
%let path=/folders/myshortcuts/otherfiles;
* options ls=64 nocenter nodate number;
/* Let's import some data to practice with */
data work.emps;
length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
Base_Salary 8 Region $ 15 Office $ 15;
infile "&path/emps_sales_reports.csv" dlm=', ' dsd;
input Emp_ID F_Name $ L_Name $ Dept $ Sales Commission Base_Salary Region $ Office $ Start_Date :mddyy.;
format Start_Date mddyy10.;
/* Assigning Permanent Labels */
label F_Name='First Name'
L_Name='Last Name'
Dept = 'Department'
Sales ='Monthly Sales'; 
/* print non-US Sales Employees report */
proc print data=work.emps;
var F_Name L_Name Dept Region Sales Commission;
/* Assigning Temporary Labels */
 label F_Name='First Name'
L_Name='Last Name'
Dept = 'Department'
Sales ='Monthly Sales'; 
title1 "Sales Employees Report";
title2 "UK Region";
footnote color=red height=9pt bold 'Internal Use Only';
footnote2 color=blue height=8pt "&SYSDATE9";
where Region ne = 'US';
run;



/* Formatting Values Using the FORMAT Statement */ 
%let path=/folders/myshortcuts/otherfiles;
 options ls=64 nocenter nodate number;
/* Let's import some data to practice with */
data work.emps;
   length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
   Base_Salary 8 Region $ 15 Office $ 15;
   infile "&path/emps_sales_reports.csv" dlm=', ' dsd;
   input Emp_ID F_Name $ L_Name $ Dept $ Sales Commission Base_Salary Region $ Office $ Start_Date :mddyy.;
   format Start_Date mddyy10.;
   label F_Name='First Name' L_Name='Last Name' Dept = 'Department'Sales ='Monthly Sales';
/* print non-US Sales Employees report */
proc print data=work.emps noobs split=' ';
var F_Name L_Name Dept Region Sales Commission Start_Date;
format Sales dollar11.2 Commission dollar9.2 Start_Date monyy7.; 
title1 "Sales Employees Report";
title2 "UK Region";
footnote color=red height=9pt bold 'Internal Use Only';
footnote2 color=blue height=8pt "&SYSDATE9";
where Region ne = 'US';
run;



/* Creating and Applying User-defined Formats */ 
%let path=/folders/myshortcuts/otherfiles;
options ls=64 nocenter nodate number;
/* Let's import some data to practice with */
data work.emps;
   length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission Base_Salary
       8 Region $ 15 Office $ 15;
   infile '&path/emps_sales_reports.csv' dlm=', ' dsd;
   input Emp_ID F_Name $ L_Name $ Dept $ Sales Commission Base_Salary
       Region $ Office $ Start_Date :mddyy.;
   format Start_Date mddyy10.;
   label F_Name='First Name' L_Name='Last Name' Dept ='Department' Sales ='Monthly Sales' Start_Date='Start_Date';
/* Here is Step 1, use format procedure to create udf */
proc format;
   value $regionfmt 'AU'='Australia'
       'UK'='United Kingdom'
       US ='United States'
       other='Incorrect Region Code';

   value salesperf 0-49999='Needs Improvement'
       50000-74999='Pretty Good'
       75000-100000='Excellent';

    value salesperf 0-50000='Needs Improvement'
       50000-75000='Pretty Good'
       75000-100000='Excellent'; 

    value salesperf low-<50000='Needs Improvement'
       50000-<75000='Pretty Good'
       75000-high='Excellent'; 
run;
/* print global Sales Employees report */
proc print data=work. emps noobs split=' ';
   var F_Name L_Name Dept Region Sales Commission Start_Date;
   /* Note that this is Step 2, apply format to a specific variable */

   format Region $regionfmt
       Sales salesperf.
       Commission dollar9.2
       Start Date monyy7.;
   title1 'Sales Employees Report';
   title2 'All Regions';
   footnote1;
   footnote2 color=red height=7pt bold 'Internal Use only';
   footnote3 color=blue height=6pt "&SYSDATE9";
run;



/* Subsetting and Grouping Reports Using WHERE and BY */ 
%let path=/folders/myshortcuts/otherfiles;
options ls=64 nocenter nodate number;
/* Let's import some data to practice with */
data work.emps;
   length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
   Base_Salary 8 Region $ 15 Office $ 15;
   infile '&path/emps_sales_reports.csv' dlm=', ' dsd;
   input Emp_ID F_Name $ L_Name $ Dept $ Sales Commission Base_Salary
       Region $ Office $ Start_Date :mddyy.;
   format Start_Date mddyy10.;
   label F_Name='First Name'
       L_Name='Last Name'
       Dept ='Department'
       Sales ='Monthly Sales'
       Start_Date='Start_Date';

/*
   the observations in the data set need to be sorted by the same variables
   you intend to use in the BY statement
*/
proc sort data=work.emps out=work.empssort;
   by Region descending Sales;
run;
/* print US & UK Sales Employees report */
proc print data=work.empssort noobs split=' ';
   var F_Name L_Name Dept Region Sales Commission Start_Date;
   format Sales dollar11.2
       Commission dollar9.2
       Start_Date monyy7.;
   title1 'Sales Employees Report';
   title2 'US & UK Regions Only';
   footnote1;
   footnote2 color=red height=7pt bold 'Internal Use only';
   footnote3 color=blue height=6pt "&SYSDATE9";
   where Region='UK' or Region='US';
   where Region in ('US','UK');
   by Region descending sales;
run;



/* Directing Output Using ODS Statements */ 
/********* just a listing to the results tab *********/
ods listing;
proc freq data=work.emps;
   tables Region;
run;
ods listing close;
/********* creates an html formatted report *********/
ods html file='/folders/myfolders/demo/report.html';
proc freq data=work.emps;
   tables Region;
run;
ods html close;
/********* creates a pdf formatted report *********/
ods pdf file='/ folders/myfolders/demo/report.pdf';
proc freq data=work.emps;
   tables Region;
run;
ods pdf close;
/********* creates an rtf formatted report *********/
ods rtf file='/folders/myfolders/demo/report.rtf';
proc freq data=work.emps;
   tables Region;
run;
ods rtf close;
/********* creates a csv formatted report *********/
ods csvall file='/folders/myfolders/demo/report.csv';
proc freq data=work.emps;
   tables Region;
run;
ods csvall close;
/********* creates a report that can be opened with msoffice (msword for example) *********/
ods msoffice2k file='/folders/myfolders/demo/msofficereport.html';
proc freq data=work.emps;
   tables Region;
run;
ods msoffice2k close;
/********* creates an xml report that can be opened with msexcel *********/
ods tagsets.excelxp file='/folders/myfolders/demo/msexcel.xml';
proc freq data=work.emps;
   tables Region;
run;
proc means data=work.emps;
   var Sales;
run;
ods tagsets.excelxp close;
ods _all_ close;
/* its good practice to open the listing destination at the end of a program */
ods listing;



/* Specifying Styles in an ODS Statement */ 
%let path=/folders/myshortcuts/otherfiles;
options ls=64 nocenter nodate number;
/* Let's import some data to practice with */
data work.emps;
   length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales Commission
   Base_Salary 8 Region $ 15 Office $ 15;
   infile '&path/emps_sales_reports.csv' dlm=', ' dsd;
   input Emp_ID F_Name $ L_Name $ Dept $ Sales Commission Base_Salary
   Region $ Office $ Start_Date :mddyy.;
   format Start_Date mddyy10.;
   label F_Name='First Name'
       L_Name='Last Name'
       Dept ='Department'
       Sales ='Monthly Sales'
       Start_Date='Start_Date';
/* cannot be used with the listing destination */
ods listing;
proc freq data=work.emps;
   tables Region;
run;
ods listing close;
ods pdf file='/folders/myfolders/demo/report_default_style.pdf';
ods pdf file='/folders/myfolders/demo/report_science_style.pdf' style=Science;
ods pdf file='/folders/myfolders/demo/report_harvest_style.pdf' style=Harvest;
proc freq data=work.emps;
   tables Region;
run;
ods all close;
