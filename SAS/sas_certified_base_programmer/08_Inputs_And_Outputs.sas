/* Outputting Multiple Observations */
data mycars other;
   set sashelp.cars;

   select (drivetrain);
       when ('All') output mycars;
       otherwise output other;
   end;
run;
data mycars other;
   set sashelp.cars;

   if drivetrain='All' then
       output mycars;
run;


 
/* Writing to Multiple SAS Data Sets */  
data myawdcars myfwdcars myrwdcars other;
   set sashelp.cars;

   if drivetrain='All' then
       output myawdcars;
   else if drivetrain='Front' then
       output my fwdcars;
   *else if drivetrain='Rear' then
       output myrwdcars;
   else
       output other;
run;
/*********************************************************
SELECT < (select-expression) >;
   WHEN (when-expression) statement;
   WHEN (when-expression statement;
   <OTHERWISE Statement; >
END;
**********************************************************/
data myawdcars myfwdcars myrwdcars other;
   set sashelp.cars;

   select (drivetrain);
       when ('All') output myawdcars;
       when ('Front') output myfwdcars;
       *when ('Rear') output myrwdcars;
       otherwise output other;
   end;
run;



/* Controlling Variable Input and Output */ 
data myawdcars (drop=Origin) myfwdcars myrwdcars other;
   keep Make Model Type Drivetrain Origin;
   set sashelp.cars
       (drop=Type);

   select (drivetrain);
       when ('All') output myawdcars;
       when ('Front') output myfwdcars;
       when ('Rear') output myrwdcars;
       otherwise output other;
   end;
run;


 
/* Controlling Observation Input and Output */
data mycars;
   set sashelp.cars
       (keep=make model type drivetrain origin);
run;

proc print data=my cars;
run;


/* subset of observations */
data mycars;
   set sashelp.cars
       (firstobs=MIN obs=10);

   if drivetrain='All' then
       output mycars;
proc print data=mycars;
run;
/* use in a procedure step */
data mycars;
   set sashelp.cars;
run;
proc print data=mycars
   (firstobs=MIN obs=10);
   where Origin='USA';
run;


  
/* Creating an Accumulating Variable Using RETAIN */
data mycars (keep=make model msrp total MSRP);
   set sashelp.cars
       (obs=10);
   retain totalMSRP 0;
   totalMSRP=totalMSRP+MSRP;
run;
data mycars;
   set sashelp.cars;
run;


  
/* Creating an Accumulating Variable Using SUM */
/******************************************************************
variable+expression
equivalent to using the SUM function and the RETAIN statement:
retain variable 0;
variable=sum(variable,expression);
retain variable 0;
variable=variable+expression;
******************************************************************/
data mycars (keep=make model msrp totalMSRP);
   set sashelp.cars
   (obs=10);
   /* this is the sum statement */
   totalMSRP+MSRP;
run;
proc print data=mycars;
run;
data mycars;
   set sashelp.cars;
run;
proc print data=mycars;


  
/* Summarizing Data by Groups */
/* this is the untouched (so far) data set we'll use */
data mycars;
   set sashelp.cars;
run;
/* the data set must be sorted first */
proc sort data=sashelp.cars out=sortedcars;
   by Origin;
run;
/* now we can summarize by group (Origin) */
data groupedcars (keep=origin groupedMSRP);
   set sortedcars;
   by Origin;

   if First.Origin then grouped MSRP=0;
   groupedMSRP+msrp;
   if last.Origin;
run;
/* let's just check our results another way */
data asiacars europecars usacars other;
   set sashelp.cars;

   if origin='Asia' then
       output asiacars;
   else if origin='Europe' then
       output europecars;
   else if origin='USA' then
       output usa cars;
   else
       output other;
run;
data total (keep=make model msrp totalMSRP);
   set usacars;
   totalMSRP+MSRP;
run;


  
/* Summarizing Data by Multiple Groups */
/* this is the untouched (so far) data set we'll use */
data mycars;
   set sashelp.cars;
run;
/* the data set must be sorted first */
proc sort data=sashelp.cars out=sortedcars;
   by Drivetrain Origin;
run;
/* now we can summarize by group (Origin, Drivetrain) */
data groupedcars (keep=Drivetrain Origin groupedMSRP numCars);
   set sortedcars;
   by Drivetrain Origin;

   if First.Origin then
       do;
           grouped MSRP=0;
           numCars=0;
       end;
   groupedMSRP+msrp;
   numCars+1;
   if last.Origin;
run;
proc print data=groupedcars;
run;


  
/* Using Column Input */
%let path=/folders/myshortcuts/otherfiles;
/* Let's use column input to read the data */
data work.emps;
   infile "&path/emps_sales_column.dat";
   input Emp_ID 1-5 Name $ 8-27 Region $ 30-31;
run;
/* print a simple report (or listing) */
proc print data=work.emps;
run;


  
/* Using Formatted Input */
%let path=/folders/myshortcuts/otherfiles;

/* Let's use column input to read the data */
data work.emps;
   infile "&path/emps_sales_formatted.dat";
   input Emp_ID $char5. +2 Name $char20. +2 Sales;
   *input Emp_ID $char5. +2 Name $char20. +2 Sales comma6.;
   *input @8 Name $char20. +2 Sales comma6.;
run;
/* print a simple report (or listing) */
proc print data=work.emps;
run;
data monthly_sales;
input item $10. +5 Jul comma5. +5 Aug comma5. +5 Sep comma5.;
datalines;
Trucks        1,200     2,400     1,200
SUV            2,400     4,800     4,800
Sports        1,200     1,800     1,200
;
run;
proc print data=monthly_sales;
run;

 
 
/* Creating a Single Observation from Multiple Records */
/***
Cody Blackwell
206-555-4926
206-555-3648
cody_blackwell@hotmail.com
|----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
data rep_contact;
   input rep_name $20.;
   input;
   input office $12.;
   input cell $12.;
   input email $30.;
   * input rep_name $20. #3 office $12. / cell $12. /email $30.;
   datalines;
Cody Blackwell
206-555-4926
206-555-3648
cody_blackwell@hotmail.com
;
proc print data=rep_contact;
run;
  
  
  
/* Controlling When a Record Loads */
/***
S US Joe
C Raganza     1001
C Qenel          1002
S UK Debbie
C Brocadero 1025
C Frondino    1026
|----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
data crm_data(drop=type);
   retain territory rep;
   input type $1. @;
   if type='S' then
       input territory $ rep $;
   else if type='C' then
       do;
           input customer $10. cust_id;
           output crm_data;
       end;
   datalines;
S US Joe
C Raganza     1001
C Qenel          1002
S UK Debbie
C Brocadero 1025
C Frondino     1026
;
run;
proc print data=crm_data;
run;  



/* Reading Raw Data with Missing Values */
%let path=/folders/myshortcuts/other files;
data work.fixme;
   length emp_id first $ 15 last $ 18 dept $ 12 phone cell $ 12 zip $10;
   infile "spath/employee info missing.csv";
   *infile "&path/employee_info_missing. csv" dsd missover;
   input emp_id first $ last $ dept $
       phone $ cell $ zip $;
run;
proc print data=fixme;
run;
/***
emp_id,first,last,dept,phone,cell,zip
11001,Joe,Khoury,sales,608-555-7643,608-555-7684
11002,Anne,Waddell,marketing,608-555-7643,608-555-7684,53711-0531
11003,Luke,Khoury,marketing,608-555-7643,608-555-7684
11004,Raymond,Reeves,marketing,,608-555-7684,53711-0531
11005,Zack,MacPherson,sales,,,53711-0531
11006,Martina,Brooks,sales,608-555-7643,608-555-7684,53711-0531
11007,Jenna,Chavez,sales,,608-555-7684,53711-0531
11008,Wayne,Hill,sales,608-555-1643,608-555-7684,53711-0531
11009.Cody,Power,sales,608-555-1643,608-555-7684,53711-0531
11010,Debbie,Brooks,sales,608-555-7643,608-555-7684,53711-0531
***/