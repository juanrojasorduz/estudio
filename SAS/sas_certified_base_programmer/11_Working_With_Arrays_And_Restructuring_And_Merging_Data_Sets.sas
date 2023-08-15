/* SAS Array Overview */
data work.items;
input item $5. +1 a1 $4. +1 a2 $4. +1 a3 $4. +1 a4 $4.;
*
item a1 a2 a3 a4;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[5] 5. item a1-a4;
	do i=2 to dim(A);
		A[i]='1000';
	end;
run;

title 'altered data using an array';
proc print data=work.arrays noobs;
run;


/* ######################################### */


/* Creating a SAS Array */
/* First Case*/
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;
 
data work.arrays (drop=i);
	set work.items;
	array A[*] 5. a1-a4;
	do i=1 to dim(A);
		A[i]=A[i]*0.50;
	end;
run;

title 'altered numeric data using an array';
proc print data=work.arrays noobs;
run;

/* Second Case */
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[1] $5. _character_;
	do i=1 to dim(A);
		A[i]=upcase(A[i]);
	end;
run;

title 'altered character data using an array';
proc print data=work.arrays noobs;
run;


/* ######################################### */


/* Processing a SAS Array */
/* First Case */
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[4] $5. a1-a4;
	do i=1 to dim(A);
		A[i]=A[i]*0.50;
	end;
run;

title 'altered numeric data using an array';
proc print data=work.arrays noobs;
run;

/* Second Case */
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[*] _character_;
	do i=1 to dim(A);
		A[i]=upcase(A[i]);
	end;
run;

title 'altered character data using an array';
proc print data=work.arrays noobs;
run;


/* ######################################### */

 
/* Using SAS Arrays to Create Variables */
/* First Case*/ 
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[4] 5.;
	array B[4];
	array C[4];
	do i=1 to dim(A);
		A[i]=A[i]*0.250;
		B[i]=A[i]*4;
		C[i]=B[i]*0.500;
	end;
run;

title 'SAS creates numeric vars B1-B4 and C1-C4';
proc print data=work.arrays noobs;
run;

/* Second Case*/ 
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

title 'original data set';
proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[1] 5. Item;
	array new[1] $;
	do i=1 to dim(A);
		A[i]=upcase(A[i]);
		new[i]=lowcase(A[i]);
	end;
run;

title 'SAS creates character var new1';
proc print data=work.arrays noobs;
run;


/* ######################################### */


/* Using SAS Arrays to Perform Calculations */ 
data first_names;
	input (names1-names4) (: $10.);
	datalines;
anne joe Luke Linda
;
run;

title 'the original data set';
proc print data=first_names noobs;
run;

data fix_names (drop=i);
	set first_names;
	array names[*] names1-names4;
	do i=1 to dim(names);
		names[i]=propcase(names[i]);
	end;
	all_names=catx(' ', of names[*]);
run;

title1 'passed the names array to the catx function';
title2 'to create the new variable all_names';
proc print data=fix_names noobs;
run;


/* ######################################### */


/* Assigning Initial Values to an Array */ 
data work.items;
input item $5. +1 a1 4. +1 a2 4. +1 a3 4. +1 a4 4.;
datalines;
item1 5000 8000 8000 6000
item2 6000 9000 5000 6000
item3 7000 5000 5000 6000
;
run;

proc print data=work.items noobs;
run;

data work.arrays (drop=i);
	set work.items;
	array A[4] 5. a1-a4;
	array pct[4] 3.2 _temporary_ (0.50, 0.75, 0.25, 0.50);
	do i=1 to dim(A);
		A[i]=A[i]*pct[i];
	end;
run;

proc print data=work.arrays noobs;
run;


/* ######################################### */


/* Using the TRANSPOSE Procedure to Manipulate Data */ 
data work.items;
input (value1-value8) (: 4.);
datalines;
5000 8000 8000 6000 5000 8000 8000 6000
6000 9000 5000 6000 6000 9000 5000 6000
7000 5000 5000 6000 7000 5000 5000 6000
;
run;

title 'original = WIDE';
proc print data=work.items;
run;

proc transpose data=work.items
			   out=work.items_transposed;
run;

title 'result of transpose = TALL';
proc print data=work.items_transposed noobs;
run;


/* ######################################### */


/* Rotating a Data Set with the TRANSPOSE Procedure */ 
data work.items;
input (value1-value8) (: 4.);
datalines;
5000 8000 8000 6000 5000 8000 8000 6000
6000 9000 5000 6000 6000 9000 5000 6000
7000 5000 5000 6000 7000 5000 5000 6000
;
run;

title 'original: 8 variables, 3 observations';
proc print data=work.items;
run;

proc transpose data=work.items
			   out=work.items_transposed
			   name=item prefix=amount;
run;

title 'result of transpose = TALL';
proc print data=work.items_transposed noobs;
run;


/* ######################################### */


/* Match-merging SAS Data Sets */ 
data work.items1;
input Region $2. (value1-value4) (: 5.);
datalines;
CA 1000 2000 3000 4000
UK 2000 3000 4000 5000
US 3000 4000 5000 6000
;
run;

data work.items2;
input Region $2. (value5-value8) (: 5.);
datalines;
AU 5000 6000 7000 8000
UK 6000 7000 8000 9000
US 7000 8000 9000 10000
;
run;

title 'the content of work.items1 data set';
proc print data=work.items1 noobs;
run;

title 'the content of work.items1 data set';
proc print data=work.items2 noobs;
run;

data work.merged_items;
	merge work.items1 (in=in1)
		  work.items2 (in=in2);
	by region;
	if in1 and in2;
run;

title 'the contents of work.merged_items';
proc print data=work.merged_items noobs;
run;


/* ######################################### */


/* Manipulations with a Match-merge */ 
data work.employees;
informat emp_id $5. region $2. dob mmddyy10.;
input emp_id region dob;
format dob date9.;
datalines;
11001 CA 01/18/1984
11002 UK 06/20/1980
11003 US 12/01/1995
;
run;

data work.sales;
informat emp_id $5. cust_id $5. inv_date mmddyy10.;
input emp_id cust_id inv_date amount;
format inv_date date9.;
datalines;
11001 55001 08/01/2016 5000
11001 55001 07/15/2016 2000
11002 55003 07/31/2016 10000
11003 55005 08/01/2016 7000
11003 55007 08/15/2016 4000
11003 55005 08/30/2016 4000
11001 55010 09/15/2016 3000
11002 55003 09/30/2016 2000
;
run;

proc sort data=work.employees;
	by emp_id;
proc sort data=work.sales;
	by emp_id;
	run;
	
data work.total_sales(keep=emp_id cust_id inv_date amount)
	 work.summary(drop=amount dob cust_id inv_date region)
	 work.everything(drop=total num_sales);
	merge work.employees work.sales;
	by emp_id;
	output total_sales everything;
	if first.emp_id then do;
		total=0;
		num_sales=0;
	end;
		total+amount; 
		num_sales+1;
	if last.emp_id then output work.summary;
run;

title 'Sales info merged';
proc print data=work.total_sales noobs;
run;
title 'All info merged';
proc print data=work.everything noobs;
run;
title 'Summary of sales performance';
proc print data=work.summary noobs;
run;


/* ######################################### */

	
/* Match-merging Data Sets That Lack a Common Variable */ 
data work.employees;
informat emp_id $5. region $2. dob mmddyy10.;
input emp_id region dob;
format dob date9.;
datalines;
11001 CA 01/18/1984
11002 UK 06/20/1980
11003 US 12/01/1995
;
run;

data work.customers;
informat cust_id $5. territory $10. phone $12.;
input cust_id territory phone;
datalines;
55001 NA 608-555-7643
55003 EU 016541235
55005 EU 016541235
55007 NA 608-555-7643
55010 NA 608-555-7643
;
run;

data work.sales;
informat emp_id $5. cust_id $5. inv_date mmddyy10.;
input emp_id cust_id inv_date amount;
format inv_date date9.;
datalines;
11001 55001 08/01/2016 5000
11001 55001 07/15/2016 2000
11002 55003 07/31/2016 10000
11003 55005 08/01/2016 7000
11003 55007 08/15/2016 4000
11003 55005 08/30/2016 4000
11001 55010 09/15/2016 3000
11002 55003 09/30/2016 2000
;
run;

proc sort data=work.employees;
	by emp_id;	
proc sort data=work.customers;
	by cust_id;	
proc sort data=work.sales;
	by emp_id;	
run;

data work.empsales;
	merge work.employees work.sales;
	by emp_id;
run;

proc sort data=work.empsales;
	by cust_id;
run;

data work.all;
	merge work.empsales work.customers;
	by cust_id;
run;

title 'Employees';
proc print data=work.employees noobs;
run;

title 'Sales';
proc print data=work.sales noobs;
run;

title 'Customers';
proc print data=work.customers noobs;
run;

title 'All merged';
proc print data=work.all noobs;
run;


/* ######################################### */


/* Match-merging a SAS Data Set and an Excel Workbook */ 
libname myprj1 "/folders/myshortcuts/otherfiles";

proc import datafile="/folders/myfolders/demo/merge_emps.xlsx"
	out=myprj1.employees
	dbms=xlsx
	replace;
run;

data work.employees;
informat employee_id $5. region $2. dob mmddyy10.;
input employee_id region dob;
format dob date9.;
datalines;
11001 CA 01/18/1984
11002 UK 06/20/1980
11003 US 12/01/1995
;
run;

proc sort data=work.employees;
	by employee_id;

data work.merged;
	merge work.employees(in=data_input)
		  myprj1.employees(in=excel_input);
	by employee_id;
run;

title 'Employees from excel';
proc print data=myprj1.employees noobs;
run;
title 'Employees from datalines input';
proc print data=work.employees noobs;
run;
title 'Merged employee data';
proc print data=work.merged noobs;
run;

libname myprj1 clear;


/* ######################################### */


/* Match-merging Data Sets with Same-named Variables */ 
data work.items1;
input Region $2. value 5.;
datalines;
CA 1000
UK 2000
US 3000
;
run;

data work.items2;
input Region $2. value 5.;
datalines;
CA 5000
UK 6000
US 7000
;
run;

title 'Content of items1 data set';
proc print data=work.items1 noobs;
run;
title 'Content of items2 data set';
proc print data=work.items2 noobs;
run;

data work.merged_items;
	merge work.items1(rename=(value=value1))
		  work.items2(rename=(value=value2));
	by region;
run;

title 'Merged data sets items1 and items2';
proc print data=work.merged_items noobs;
run;


