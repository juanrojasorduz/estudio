/* Veryfy general information about a specific table */

proc contents data=work.shoes;
run;

proc contents data="s:/workshop/data/class.sas7bdat";
run;


/* Create a library */

libname mylib base "s:/workshop/data";

libname mylib "s:/workshop/data";

/* So, the task would be: */

proc contents data=mylib.class;
run;


/* To clear the library: */

libname mylib clear;












			