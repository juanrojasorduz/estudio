/** Import a file **/
proc import datafile="/home/u63525278/sasuser.v94/cars.csv" /* The IMPORT procedure reads data from an external data source and writes it to a SAS data set.*/
	out=work.cars_import /* Identifies the output SAS data set with either a one- or two-level SAS name (library and member name).*/
	dbms=csv /* Specifies the type of data to import. */
	replace; /* Overwrites an existing SAS data set. If you do not specify REPLACE, PROC IMPORT does not overwrite an existing data set.*/
run;




/* Reading Form an Excel Sheet*/
options validvarname=any; /* Options Changes the value of one or more SAS system options. */
/* Validvarname Specifies the rules for valid SAS variable names that can be created and processed during a SAS session.*/
/* Any Enables compatibility with other DBMS variable (column) naming conventions, such  as allowing embedded/leading blanks 
and special/multi-byte characters (not exceeding  32 bytes) */
libname myxlsx xlsx '/home/u63525278/sasuser.v94/cars.xlsx';
proc datasets lib=myxlsx; quit; /* The DATASETS procedure is a utility procedure that manages your SAS files.*/ 
/* lib Names the library that the procedure processes. This library is the procedure input/output library.*/
/* Quit from the current SAS session. */
data emps;
	set myxlsx.cars;
run;
libname myxlsx clear;




/* Creating a Excel Sheet */
proc export data=sashelp.cars /* The EXPORT procedure reads data from a SAS data set and writes it to an external data source */
    outfile="/home/u63525278/sasuser.v94/cars_test.xlsx" /*Specifies the complete path and filename or a fileref for the output PC file, spreadsheet, 
    or delimited external file. */
	dbms=xlsx /* Specifies the type of data to export. */
	replace; /* Overwrites an existing file.*/
run;




/* Using the ODS to create an Excel Sheet */
ods csvall file='/home/u63525278/sasuser.v94/cars_test.csv' RS=none style=MINIMAL;
proc print data=sashelp.class noobs; 
run;
ods csvall close; 
run;
/*
*ODS Provides a method for delivering output in a variety of formats, and makes the formatted output easy to access.
*csvall Opens, manages, or closes the specified destination, which produces SAS output that is formatted using 
one of many different markup languages.
*file Opens a MARKUP family destination and specifies the file that contains the primary 
output that is created by the ODS statement.
*RS Specifies an alternative character or string that separates lines in the output files.
*Style Specifies the style definition to use in writing the output files. 
*noobs Suppresses the observation number in the output.
*closeCloses the destination and any files that are associated with it.
/*




/* Creating a Data Set from a delimited file */
/* Using the LENGHT statement*/
%let path=/folders/myshortcuts/otherfiles;
/* note that using the length statement will have an effect
on how the PDV is formed. SAS will create the First_name, Last_name,
and Department variables in the PDV first, then it will continue
parsing the program for other variables like those in the input statement */
data work.empsales;
       length First_name Last_name $ 15 Department $ 12; /* Specifies the number of bytes for storing variables. */
       infile "&path/emps_sales.csv" dlm=','; /*Identifies an external file to read with an INPUT statement.*/
       input Employee_ID First_name $
           Last_name $ Department $ Salary
           Hire_date $; /* Column INPUT reads input values from specified  columns and assigns them to the corresponding SAS variables*/
run;

/* the varnum option outputs the list of variable
names in the order that they were created */
proc contents data=work.empsales varnum;




/* Reading Nonstandard Data with Informants */
%let path=/folders/myshortcuts/otherfiles;
/* You use informats to read non-standard data <$><informat><w>. Notice
   here we are using the colon format modifier in the input statement. This
   causes SAS to go until it sees a delimiter. So for example, the input
   data could be only 4 or 5 characters long, and if the colon format modifier
   were omitted, SAS would read 15 characters, even if that included delimiters. */
data work.empsales;
       infile "&path/emps_sales.csv" dlm=',';
       input Employee_ID First_name :$15.
           Last_name :$18. Department :$12. Salary
           Hire_date :mmddyy.;
run;
/* the varnum option outputs the list of variable
   names in the order that they were created */
proc contents data=work.empsales varnum;
proc print data=work.empsales;




/* Processing Nonstatndard Data in the Data Step */
%let path=/folders/myshortcuts/otherfiles;
data work.empsales;
       infile "&path/emps_sales.csv" dlm=',';
       input Employee_ID First_name :$15.
           Last_name :$18. Department :$12. Salary
           Hire_date :mmddyy.;
keep First_name Last_name Salary Hire_date;
label Hire_date='Date Started';
format Salary dollar12. Hire_date monyy7.;
run;
proc contents data=work.empsales varnum;
proc print data=work.empsales label;




/* Using the list Input DSD Option */
%let path=/folders/myshortcuts/otherfiles;
data work.empsales;
       length First_name $ 15 Last_name $ 18 Department $% 12
           Phone Fax $ 12 Zip $ 10;
infile "&path/employee_info.csv" dlm=',';
input Employee_ID First_name $ Last_name $ Department $
           Phone $ Fax $ Zip $;
run;
proc print data=work.empsales noobs;
proc contents data=work.empsales varnum;




/* Using the MISSOVER Option */
%let path=/folders/myshortcuts/otherfiles;
data work.empsales;
       length First_name $ 15 Last_name $ 18 Department $ 12
           Phone Fax $ 12 Zip $10;
infile "&path/employee_info_missing.csv" dsd;
input Employee_ID First_name $ Last_name $ Department $
           Phone $ Fax $ Zip $;
keep First_name Last_name Department Phone Fax Zip;
label First_name="First Name" Last_Name="Last Name";
run;
proc print data=work.empsales noobs;
proc contents data=work.empsales varnum;


















