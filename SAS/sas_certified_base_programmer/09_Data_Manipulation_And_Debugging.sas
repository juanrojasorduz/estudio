/* Using SAS Functions */ 
/***
var=function name (argument1<, argumentn>)
***/
%let path=/folders/myshortcuts/otherfiles;
/* Let's import some data to practice with */
data work.empsales (keep=Emp_ID F_Name Region Fixed_Region Down_Region);
length Emp_ID $7 F_Name $ 12 L_Name $ 15 Pay_Type $ 10 Sales Commission Base_Salary
8 Region $ 15 Product $ 20 start Date S7;
infile "&path/emps_sales_products.csv" dlm=', ' dsd;
input Emp_ID $F_Name $ L_Name $ Pay_Type $ Sales Commission Base_Salary
Region $ Product $ Start Date $;
/* changing case on Region */
Fixed_Region=upcase(Region);
Down_Region=lowcase(Region);
run;
proc print data=work.empsales noobs;
run;



/* Extracting and Transforming Character Values */
/* Part One Demo Code */
/***
var=function name (argument1<, argumentn>)
***/
%let path=/folders/myshortcuts/otherfiles;

/* Let's import some data to practice with */
data work.empsales (drop=L_Name Pay_Type Sales Commission Base_Salary Region);
   length Emp_ID $7 F_Name $ 12 L_Name $ 15 Pay_Type $ 10 Sales Commission
   Base_Salary 8 Region $ 15 Product $ 20 Start_Date $7 Country $20;
   infile "&path/emps_sales_products.csv" dlm=', ' dsd;
   input Emp_ID $ F_Name $ L_Name $ Pay_Type $ Sales Commission Base_Salary
   Region $ Product $ Start Date $;
/*
use substr to extract a string
substr(string, position, length)
*/
State_Prov=substr(Emp_ID, 3, 2);
if upcase(Region)='CA' then
Country='Canada';
else
Country='United States';
Hire_Month=substr)Start_Date, 1, 3);
/* use propcase to fix F_Name and Product */
F_Name=propcase(F_Name);
Product=propcase(Product);
/* use substr and length */
Emp_ID_Len=length(Emp_ID);
ID=substr(Emp_ID, (length(Emp_ID)-2), 3);
run;
proc print data=work.empsales noobs;
run;
/*
use char to return a char at a position in a string
char(string, position)
*/
data char_test;
   retainString_Val 'xyz';
   do position=0 to 4;
       Char_Result=char(String_Val, position);
       output;
   end;
run;
proc print data=char_test noobs;
run;
/* Part Two Demo Code: */
%let path=/folders/myshortcuts/otherfiles;
/* Let's look at some other string manipulations */
data input strings;
input Name $char 20.;
datalines;
Joe Khoury              /* trailing blanks */
   Alice Park             /* leading & trailing blanks  */
   Tom     Wang       /* leading, trailing, and blanks in between */
;
/***
----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
run;
data strings_manipulation (drop=Name);
set input_strings;
Original= '*' || Name || '*';
Left_Align= '*' || left(Name) || '*';
Right_Align= '*' || right(Name) || '*';
run;
/* output to a csv to see our data */
ODS CSVALL file="/folders/myfolders/demo/myodsfile.csv" RS=none style=MINIMAL;
proc print data=strings_manipulation noobs;
run;
ODS CSVALL close;
run;



/* Separating and Concatenating Character Values */
/* Part One Demo Code: */
%let path=/folders/myshortcuts/otherfiles;
/* Let's look at some other string manipulations */
data input strings;
input Name $char 20.;
datalines;
Joe Khoury /* trailing blanks */
Anne Waddell/* leading blanks */
Alice Park /* leading & trailing blanks */
;
/***
----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
run;
data strings_manipulation (drop=Name);
set input_strings;
Original= '*' || Name || '*';
Trimmed= '*' || trim(Name) || '*';
Stripped= '*' || strip(Name) || '*';
Alt Strip= '*' || trimn(strip(Name)) || '*'; * strip runs faster though;
run;
*/ Part Two Demo Code: */
%let path=/folders/myshortcuts/otherfiles;
/* Let's look at some other string manipulations */
data input strings;
input Name $char 20.;
datalines;
Joe Khoury /* trailing blanks */
Anne Waddell/* leading blanks */
Alice Park /* leading & trailing blanks */
;
/***
----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
run;
data strings_manipulation (drop=Name);
set input_strings;
Original= '*' || Name || '*';
First_Name= '*' || scan(Name,2,',') || '*';
run;
/* Part Three Demo Code: */
%let path=/folders/myshortcuts/otherfiles;
/* Let's look at some other string manipulations */
data input strings;
input Last $char10. +2 First $char10.;
datalines;
Khoury    Joe     /* trailing blanks */
   Park    Alice    /* leading & trailing blanks */
;
/***
----+----1----+----2----+----3----+----4|
|1234567890123456789012345678901234567890|
***/
run;
data strings_manipulation;
set input_strings;
Original= '*' || Name || '*';
Full_Name_Cat= '*' || cat(First, ' ', Last) || '*';
Full_Name_Catt= '*' || catt(First, ' ', Last) || '*';
Full_Name_Cats= '*' || cats(First, ' ', Last) || '*';
Full_Name_Catx= '*' || catx(',', Last, First) || '*';
run;


 
/* Finding and Modifying Character Values */
data input string;
   input Source $ 1-50;
datalines;
"What a good day, to 8write code in SAS!";
run;
/* compress (source<,chars><,modifiers>) */
data find modify;
set input_string;
Corrected1=compress(Source);
Corrected2=compress(Source, '1234567890');
Corrected3=compress(Source, , 'd'); *effectively the same as '1234567890';
run;
proc print data=find_modify;
run;
/* substr(string,start<,length>)=value;  */
data find_modify;
set input_string;
   Corrected=compress(Source, , 'd');
   substr(Corrected,1,4)="It's";
run;
proc print data=find modify;
run;
/* find (string,substring<,modifiers,start>) */
/* tranwrd (source,target,replacement) */
data find_modify;
set input_string;
   Corrected=compress(Source, , 'd');
   Length=length(Corrected);
   Target=find(Corrected,', ', 'i');
   Corrected=substr(Corrected,1,Target-1) || ' ' || strip(substr(Corrected,target+1));
   Replace_Word=tranwrd(Corrected, 'good', 'great');
run;
proc print data=find modify;
run;
/* Use ODS to output to external file */ 



/* Using Descriptive Statistics Functions */
%let path=/ folders/myshort cuts/other files;
/* Let's get some sales data to work with */
data work.emps_sales (drop=Emp_ID F_Name L_Name Product);
   length Emp_ID $7 F_Name $20 L_Name $20 Product $ 10;
   infile "&path/emps_sales_93703.csv" dlm=',' dsd;
   input Emp_ID $ F_Name $ L_Name $ Q1 Q2 Q3 Q4 Product $;
   /* function name (arg1, arg2, . . . . argn); */
   Total_Sales1=sum(Q1, Q2, Q3, Q4);
   Total_Sales2=sum(of Q: );
   Mean_Sales=mean(of Q1-Q4);
   Min_Sale=min(of Q1 - Q4);
   Max_Sale=max(of Q1 - Q4);
   /* You can use special SAS names */
   Total= sum(of _Numeric_);
run;
/* print a simple report (or listing) */
proc print data=work.emps_sales;
run;


 
/* Truncating Numeric Values */
%let path=/ folders/myshort cuts/other files;
/* Let's get some sales data to work with */
data work.emps_sales;
length Measure $ 20;
infile "&path/93703.csv" dlm=',' dsd;
input Measure $ Q1 Q2 Q3 Q4;
drop Mean_Sales Q1 Q2 Q3 Q4 ;
Measure='Mean_Sales';
Mean_Sales=mean(of Q1 - Q4);
Val=Mean_Sales;
output;
/* round(arg<,rounding unit>) */
Measure='Round Hundredths';
Val=round(Mean_Sales,0.01);
output;
Measure='Round Tenths';
Val=round(Mean_Sales,0.01);
output;
Measure='Round Integer';
Val=round(Mean_Sales,1);
output;
Measure='Round Tens';
Val=round(Mean_Sales,10);
output;
/* floor(arg) ceil(arg) int(arg) */
Measure='Floor of Mean Sales';
Val=floor(Mean_Sales);
output;
Measure='Ceil of Mean Sales';
Val=ceil(Mean_Sales);
output;
Measure='Int of 1.9';
Val=int(1.9);
output;
Measure='Int of 1.4';
Val=int(1.4);
output;
run;
/* print a simple report (or listing) */
proc print data=work.emps_sales;
run;



/* Converting Values Between Data Types */
%let path=/folders/myshortcuts/otherfiles;
/* Let's get some sales data to work with data work */
data work.emps sales;
length Num_Code_ID 5.Char_Code_ID $5;
infile "&path/emps_sales_93705.csv" dlm=' , ' dsd;
input Num_Code_ID Char_Code ID $;
/*
The numeric values of the variable Num_ID get converted to character values:
1. we assigned the numeric value to a previously defined char variable Char_Code_ID
2. we used the numeric value using an operator requiring a char value (the || operator)
The Char_Rate value is converted to numeric in order to perform the mathematical calculation for Num_Total
*/
Num_ID=11003;
Char_Rate='100';
Num_Hours=25;
/* Automatic conversions Num to Char */
Char_Code_ID=Num_ID;
Concat_Ex=Char_code_ID || Num_ID;
/* Automatic conversion Char to Num */
Num_Total=Num_Hours*Char_Rate;
/* input (source, informat); */
/* put (source, format) ; */
Explicit_Num_Char_Rate=input(Char_Rate, 3.);
Explicit_Char_Num_Hours=put(Num_Hours, 3.);
run;
/* where statement restrictions */
data auto conversion test;
Num_Val=10; *Assign a numeric value;
Char_Val='10'; *Assign a character value;
run;
proc print data=auto_conversion_test;
where Char_Val=10; *Note the numeric value on the right side of the comp. operator;
run;
proc print data=auto_conversion_test;
where Num_Val='10'; *Note the character value on the right side of the comp. operator;
run;



/* Debugging with PUTLOG */
%let path=/folders/myshort cuts/other files;
/* Let's get some sales data to work with */
data work.emps_sales (drop=F_Name L_Name Product);
*length Emp ID $7 F_Name $20 L_Name $20 Product $10;
infile "&path/emps_sales_93706.csv" dlm=',' dsd;
input Emp ID $ F_Name $ L_Name $ Q1 Q2 Q3 Q4 Product $;
/* get total and mean sales */
Total_Sales=sum(Q1, Q2, Q3, Q4);
Mean_Sales=mean(of Q1-Q4);
/* putlog 'message' ; */
if mean_sales < 40000 then
   do;
       if Mean_Sales < 0 then
           putlog 'ERROR: Something is wrong here, the average is less than $0 '
               Emp ID= Mean sales=8.2;
       else
           putlog 'WARNING: Average is less than $40,000 ' Emp_ID=Mean_Sales=8.2;
   end;
run;
/* print a simple report (or listing) */
proc print data=work.emps_sales;
run;



/* Debugging Logic Errors */
%let path=/folders/myshortcuts/otherfiles;
/*
   When your program is syntactically correct, no errors are detected, yet the results
   are not accurate. This is a logic error, SAS cannot detect logic errors introduced
   into your program. Rather, to track down the cause of logic errors its best practice
   to understand the data you're working with, read the SAS log, and of course you
   should always carefully review your results!
*/
/* A data step that contains a logic error */
data work.emps;
   length.Emp_ID 8 First S 12 Last S 15;
   infile "&path/emps_sales_93707_part1.csv" dlm=',' dsd;
   input Emp_ID First $ Last $;
data work.emps sales_by_quarter;
   length Emp_ID 8 Period $ 2 Sales 8;
   infile "&path/emps_sales_93707_part2.csv" dlm= ',' dsd;
   input Emp_ID Period $ Sales;
data work.emps merged;
   merge work.emps work.emps_sales_by_quarter;
   *by Emp ID;
   *if Emp_ID=11001;
run;
title 'emps';
proc print data=emps;


 
/* Exercise: Manipulating Data */ 
%let path=/folders/myshortcuts/otherfiles :
data work.empsales;
   input ID $ 1-5 Name $ 7-20 Phone $ 21-30 Q1 32-37 Q2 39-44 Q3 46-51 Q4 53-58;
   datalines;
11001 Joe Khoury            6085557643 100000 200000 800000 300000
11002 Anne Waddell       6085557643 200000 200000 100000 300000
11003 Luke Khoury          6085557643 100000 200000 400000 300000
11004 Cody Power           6085557643 300000 200000 300000 300000
11005 Debbie Brooks      6085557643 600000 200000 200000 300000
;
run;
data string_manipulation;
   set work.empsales;
   drop Phone Q1 Q2 Q3 Q4;
/* to clarify removal of leading/trailing spaces */
Original= '*' || Name || '*';
Stripped='*' || strip(Name) || "*";
/* use strip() to remove leading and trailing spaces */
Name=strip(Name);
/* use substr() to fix the phone format */
Phone=strip(Phone);
Telephone=substr(Phone, 1, 3) || '-' || substr (Phone, 4, 3) || '-' || substr(Phone 7, 4);
/* find total and average sales */
Total_Sales=sum(of q:);
Avg_Sales=mean(of q:);
run;
/* Use ODS to output to external file */
ODS CSVALL file="/folders/myfolders/demo/myodsfile.csv" RS=none style=MINIMAL;
/* noobs means no obs numbers in the output */
proc print data=work.string_manipulation noobs;
run;
ODS CSVALL close;
run;