/* Reading Excel Files */

libname xlclass xlsx "s:/workshop/data/class.xlsx";

/* This statment replace any space for underscore for column names 
and truncates names greater than 32 characters*/

options validvarname=v7;

/* To clear the library: */
libname xlclass clear;



/* Code for Read Excel File */

options validvarname=v7;
libname xlclass xlsx "s:/workshop/data/class.xlsx";

proc contents data=xlclass.class_birthdate;
run;

libname xlclass clear;


/* Example for Read Excel File */

options validvarname=v7;

libname xlstorm xlsx "s:/workshop/data/storm.xlsx"

proc contents data=xlstorm.storm_summary;
run;

libname xlstorm clear;


/* Import an Excel File as a copy */

proc import datafile="s:/workshop/data/class.xlsx"
	    dbms=xlsx
	    out=work.class_test_import replace;
    sheet=class_test;
run;