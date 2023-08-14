/* Executing Statements Conditionally */
/* Import Code: */
/* Let's import some data to practice with */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales 8 Region $ 15;
       infile "$path/emps_sales_93652.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Department $ Sales Region $;
/* Executable Statements Code: */
/* multiple executable statements using if-then-do */   
       if Region='USA' then
               do;
               Payout = 'US bonus';
               if Department='sales' then
                       Bonus=.20*Sales;
               else if Department='marketing' then
                       Bonus=.10*Sales;
       end;
       else if Region='UK' then
               do;
               Payout = 'UK bonus';
               if Department='sales' then
                       Bonus=.10*Sales;
               else if Department='marketing'  then
                       Bonus=.05*Sales;
               end;
       else if Region='AU' then
               do;
               Payout = 'AU bonus';
               if Department='sales' then
                       Bonus=.10*Sales;
               else if Department='marketing' then
                       Bonus=.05*Sales;
               end;
       if missing (Commission) then
               Commission=0;
               
       if missing (Bonus) then
               Bonus=0;
run;



/* Using the ELSE Statement in a Conditional */
/* Demo Code: */
/* Let's import some data to practice with */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15 Department $ 10 Sales 8 Region $ 15 Payout $ 15;
       infile "$path/emps_sales_93653.csv" dlm=',' dsd;
       input Emp_ID First $ Last $ Department $ Sales Region $;
       
/* Everyone in USA is paid monthly and is paid a 20% bonus of sales if they
are in the sales dept. otherwise their bonus is 10% of sales.
*/
if Region='USA' then
       do;
       Payout='monthly';
       if Department='sales' then
               Bonus=.20*Sales;
       else
               Bonus=.10*Sales;
       end;
/*
Everyone else is paid biweekly and is paid a 10% bonus of sales if they
are in the sales dept. otherwise their bonus is 5% of sales
*/
else if Region='UK' then
       do;
       Payout='biweekly';
       if Department='sales' then
               Bonus=.10*Sales;
       else
               Bonus=.05*Sales;
       end;       
else if Region='AU' then
       do;
       Payout='biweekly';
       if Department='sales' then
               Bonus=.10*Sales;
       else
               Bonus=.05*Sales;
       end;       
if missing(Bonus) then
       Bonus=0;
run;



/* Using IF-THEN DELETE to Subset Observations */
data work.my_emps_sales;
	set work.emps;
	where region='UK';
	anniversary_month=month(start_date);
	if anniversary_month ne 7 then delete;
run;

 
  
/* Using the FORCE option to an APPEND Procedure */
proc append base=work.emps1 /* The APPEND procedure adds the observations from one SAS data set to the end of another SAS data set. */
			data=work.emps2;
run;
 

 
/* Using SET in a DATA Step to Concatenate Data Sets */
data work.emps_concat;
	set work.emps1 work.emps2;
run;


 
/* Using RENAME to Change Variable Names */
/* Demo .Code: */
data work.emps1;
      length Emp_ID 8 First_Name $ 12 Last_Name $ 15 Dept $ 10;
      infile "&path/emps_sales_93660.csv" dlm="," dsd;
      input Emp_ID First_Name $ Last_Name $ Dept $ Start_Date :mmddyy.;
      format Start_Date mmddyy10.;      
data work.emps2;
      length Emp_ID 8 First $ 12 Last $ 15 Department $ 10;
      infile "&path/emps_sales_93660_part2.csv" dlm="," dsd;
      input Emp_ID First $ Last $ Department $ Start_Date :mmddyy.;
      format Start_Date mmddyy10.;
data work.emps_concat;
      set work.emps1 work.emps2;
      
      
      
/* Merging Data Sets One-To-One */
/* Demo Code: */
data work.emps_start_date;
       length Emp_ID 8 First_Name $ 12 Last_Name $ 15;
       infile "&path/emps_sales_93661_part1.csv" dlm="," dsd;
       input Emp_ID First_Name $ Last_Name $ Start_Date :mmddyy.;
       format Start_Date mmddyy10.;       
data work.emps_department;
       length Emp_ID 8 Department $ 10;
       infile "&path/emps_sales_93661_part2.csv" dlm="," dsd;
       input Emp_ID Department $;
data work.emps_merged;
       merge work.emps_start_date work.emps_department;
       by Emp_ID;
run;  


 
/* Merging Data Sets One-To-Many */
/* Demo Code: */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15;
       infile "&path/emps_sales_93662_part1.csv" dlm="," dsd;
       input Emp_ID First $ Last $;
data work.emps_sales_by_quarter;
       length Emp_ID 8 Period $ 2 Sales 8;
       infile "&path/emps_sales_93662_part2.csv" dlm="," dsd;
       input Emp_ID Period $ Sales;
data work.emps_merged;
       merge work.emps work.emps_sales_by_quarter;
       by Emp_ID;
run;


 
/* Merging Data Sets with Nonmatches */
/* Demo Code: */
data work.emps;
       length Emp_ID 8 First $ 12 Last $ 15;
       infile "&path/emps_sales_93663_part1.csv" dlm=',' dsd;
       input Emp_ID First $ Last $;  
data work.emps_sales_by_quarter;
       length Emp_ID 8 Period $ 2 Sales 8;
       infile "&path/emps_sales_93663_part2.csv" dlm=',' dsd;
       input Emp_ID Period $ Sales;
data work.emps_merged;
       merge work.emps(in=inemps) work.emps_sales_by_quarter (in=inqsales);
       by Emp_ID;
       *if inemps=0 and inqsales=0;
run;
title 'emps';
proc print data=emps;
run;
title 'emps_sales_by_quarter';
proc print data=emps_sales_by_quarter;
run;


 
/* Exercise: Validating, Cleaning, and Combining Data */
/* Import Code: */
data work.emps1;
       length Emp_ID 8 First_Name Last_Name $ 15 Department $ 12 Salary 8;
       infile "&path/emps_sales_93664_part1.csv" dlm=',' dsd;
       input Emp_ID First_Name $ Last_Name $ Department $ Salary Start_Date :mmddyy.;
       format Start_Date mmddyy10.;
run;       
data work.emps2;
       length Emp_ID 8 First_Name Last_Name $ 15 Department $ 12 Salary 8;
       infile "&path/emps_sales_93664_part2.csv" dlm=',' dsd;
       input Emp_ID First_Name $ Last_Name $ Department $ Salary Start_Date :mmddyy.;
run; 