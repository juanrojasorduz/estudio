/* Creating Enhanced Frequency Tables */
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
       Start_Date='Start Date'
       Region='Sales Region';
proc format;
   value $regionfmt 'AU'='Australia'
           'UK'='United Kingdom'
           'US'='United States '
           other='Incorrect Region Code';
run;
/* add some titles and footnotes */
title 'Sales by Department and Region';
title2 'All Sales Regions and Departments';
footnote2 color=red height=7pt bold 'Internal Use only';
footnote3 color=blue height=6pt "&SYSDATE9";
ods odf file='folders/myfolders/demo/report.pdf' style=Barretts Blue;
proc freq data=work.emps;
   tables Dept Region;
   format Region $regionfmt.;
run;
ods pdf close;
/* just cleaning up */
ods _all_ close;
ods listing;


 
/* Creating Summary Tables with the MEANS Procedure */ 
/* Creating Summary Tables with the SUMMARY Procedure */


 
/* Creating Enhanced Summary Tables */ 
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
       Start_Date='Start Date'
       Region='Sales Region';
proc format;
   value $regionfmt 'AU'='Australia'
           'UK'='United Kingdom'
           'US'='United States '
           other='Incorrect Region Code';
run;
/* add some titles and footnotes */
title 'Sales by Department and Region';
title2 'All Sales Regions and Departments';
footnote2 color=red height=7pt bold 'Internal Use only';
footnote3 color=blue height=6pt "&SYSDATE9";
proc summary data=work.emps;
   var Sales;
   class Region Dept;
   output out=work.emps_summary
       min=minSales max=maxSales
       sum=sumSales mean=avgSales;
run;
ods odf file='folders/myfolders/demo/report.pdf' style=Barretts Blue;
proc print data=work.emps_summary;
run;
ods pdf close;
/* just cleaning up */
ods _all_ close;
ods listing;



/* Creating Tabular Reports with the TABULATE Procedure */
/***
TABLE page expressions, row expression, column expression;
One-Dimensional: column dimension
Two-Dimensional: row dimension, column dimension
Three-Dimensional: page dimension, row dimension, column dimension
***/
/* a one-dimensional table Only a column_expression*/
title 'One-Dimensional: column dimension';
proc tabulate data=work.emps;
   class Region;
   table Region;
run;
/* a two-dimensional table */
title 'Two-Dimensional: row dimension, column dimension';
proc tabulate data=work.emps;
   class Pay_Type Region;
   table Pay_Type, Region;
run;
/* a three-dimensional table */
title 'Three-Dimensional: page dimension, row dimension, column dimension';
proc tabulate data=work.emps;
   class Product Pay_Type Region;
   table Product, Pay_Type, Region;
run;
title1 'Specify analysis variable "Sales" & use expressions in the table statement';
title2 'Here we cross Region with Sales and obtain min and max as well';
title3 ' ';
title4 'Remember the code here';
title5 'proc tabulate data=work.emps;';
title6 color=red 'class Pay_Type Region;';
title7 color=red 'var Sales;';
title8 color=red 'table Pay_Type all, Region*Sales*(min max);';
title9 'run;';
ods pdf file='/folders/myfolders/demo/tabulate_report.pdf' style=BarrettsBlue;
/* some other statistics */
proc tabulate data=work.emps;
   class Pay_Type Region;
   var Sales;
   table Pay_Type all, Region*Sales*(min max);
   format Region $Regionfmt.;
run;
ods pdf close;


 
/* Creating Output Data Sets Using the OUT= Option */
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
       Start_Date='Start Date'
       Region='Sales Region';
       Commission='Sales Commission';
proc format;
   value $regionfmt 'AU'='Australia'
           'UK'='United Kingdom'
           'US'='United States '
           other='Incorrect Region Code';
run;
footnote color=blue height=8pt "&SYSDATE9";
title 'Output Data Sets based on Product, Pay Type, Region';
ods odf file='folders/myfolders/demo/report.pdf' style=Barretts Blue;
/* some other statistics */
proc tabulate data=work.emps
       out=work.emps_tabulate;
   Where Region in ('UK', 'US');
   class Product Pay_Type Region;
   table Region;
   table Pay_Type, Region;
   table Product, Pay_Type, Region;
run;
proc print data=work.emps_tabulate;
run;
ods pdf close;


 
/* Overview of SAS/GRAPH SG Procedures */
/*
   SAS/GRAPH Statistical Graphics (or SG) Procedures include
   SGPANEL, SGPLOT, SCSCATTER, SGRENDER, and SGDESIGN
*/
ods graphics / reset imagemap;
/* use sgpanel procedure with the histogram plot type */
proc sgpanel data=sashelp.cars;
   title 'Horsepower Distribution of Cars';
   panelby type;
   histogram Horsepower;
   density Horsepower;
run;
ods graphics / reset;
/* Here are all the observations in a simple listing */
proc means data=sashelp.cars;
var horsepower;
run;
ods _all_ close;
ods listing;


 
/* Creating Pie Charts with SAS/GRAPH SG Procedures */
/* First we have to define our pie template */
proc template ;
   define statgraph mygraphs.pie;
       begingraph;
       layout region;
       piechart category=type / start=90 centerFirstSlice=1;
       endlayout;
       endgraph;
   end;
run;
/*
Enables or disables ODS graphics processing and sets graphics environment
options, imagemap generates tips so we can mouse over and see the values
*/
ods graphics / reset imagemap;
/* use sgrender procedure and specify the pie chart template */
proc sgrender template=mygraphs.pie data=Sashelp.cars;
run;
ods graphics / reset;
/* Here are all the observations in a simple listing */
proc freq data=sashelp. cars;
   tables type;
run;


 
/* Creating Bar Charts with SAS/GRAPH SG Procedures */
/*
Enables or disables ODS graphics processing and sets graphics environment
options, imagemap generates tips so we can mouse over and see the values
*/
ods graphics / reset imagemap;
/* use sgplot procedure with the vbar or hbar plot type */
proc sgplot data=sashelp.cars;
   hbar Type / response=Horsepower stat=Mean;
run;
ods graphics / reset;
/* Here is some summary data */
proc means data=sashelp.cars;
   var Horsepower;
   class type;
run;


 
/* Creating Histograms with SAS/GRAPH SG Procedures */
/*
Enables or disables ODS graphics processing and sets graphics environment
options, imagemap generates tips so we can mouse over and see the values
*/
ods graphics / reset imagemap;
/* use sgplot procedure with the histogram plot type */
proc sgplot data=sashelp.cars;
histogram Horsepower;
density Horsepower;
run;
ods graphics / reset;
/* Here all the observations in a simple listing */
proc means data=sashelp.cars;
var Horsepower;
run;

 
/* Producing Scatter Plots with SAS/GRAPH SG Procedures */
/*
Enables or disables ODS graphics processing and sets graphics environment
options, imagemap generates tips so we can mouse over and see the values
*/
ods graphics / reset imagemap;
/* use sgscatter procedure to produce a scatter plot */
proc sgscatter data=sashelp.cars;
   compare y=MPG_Highway
       x=(Weight Horsepower Enginesize)
       / group=Type;
run;
ods graphics / reset;
/* Here is a summary listing of horsepower */
proc means data=sashelp.cars;
   var Horsepower;
run;
/* Here is a frequency table of horsepower */
proc means data=sashelp.cars;
   table Horsepower;
run;


 
/* Exercise: Creating Reports and Charts */
/* Part1: Summary report */
ods graphics / reset imagemap;
/* use sgplot procedure vbar chart type */
proc sgplot data=sashelp.cars;
   vbar Type / response=Horsepower stat=Menu;
run;
ods graphics / reset;
/* Here is our summary data */
proc means data=sashelp.cars;
   var Horsepower;
   class Type;
run;
/***/
/* Part2: Frequency data */
ods graphics / reset imagemap;
/* use sgplot procedure vbar chart type */
proc sgplot data=sashelp.cars;
   vbar Type;
run;
ods graphics / reset;
proc freq data=sashelp.cars;
   table Type;
run; 
