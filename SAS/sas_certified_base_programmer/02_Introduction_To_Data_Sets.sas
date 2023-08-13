/* To see all the content for an specific library */

proc contents data=sashelp._all_;
run;

/* Creating and clearing new libraries */
libname myjdlib "/folders/myshortcuts/otherfiles"; /* Associates or disassociates a SAS data library with a libref (a shortcut name) */
libname myjdlib clear; /* clears one or all librefs */
libname libref clear; /* clears one or all librefs */
libname work list; /* lists the characteristics of a SAS data library; */


/* Creating and clearing new libraries 
Data Sets can be created from 3 different sources
	- Raw Data File (delimited)
	- Another SAS data set
	- Microsoft Excel
*/

data work.autos; /* Begins a DATA step and provides names for any output SAS data sets, views, or programs. */
	set sashelp.cars; /* Reads an observation from one or more SAS data sets. */
run; /* Executes the previously entered SAS statements. */

proc print data=work.autos; /* The PRINT procedure prints the observations in a SAS data set, using all or some of the variables.*/
	where type ~= 'SUV'; /* Selects observations from SAS data sets that meet a particular condition.*/
run;


proc print data=work.autos; /* The PRINT procedure prints the observations in a SAS data set, using all or some of the variables.*/
	where type ~= 'SUV'; /* Selects observations from SAS data sets that meet a particular condition.*/
run;

data work.autos; /* Begins a DATA step and provides names for any output SAS data sets, views, or programs. */
	set sashelp.cars; /* Reads an observation from one or more SAS data sets. */
	keep model msrp; /* Includes variables in output SAS data sets.*/
run; /* Executes the previously entered SAS statements. */

data work.autos; /* Begins a DATA step and provides names for any output SAS data sets, views, or programs. */
	set sashelp.cars; /* Reads an observation from one or more SAS data sets. */
	drop model msrp; /* Excludes variables from output SAS data sets. */
run; /* Executes the previously entered SAS statements. */

/* Adding Labels with Label Statement */
data work.autos; /* Begins a DATA step and provides names for any output SAS data sets, views, or programs. */
	set sashelp.cars; /* Reads an observation from one or more SAS data sets. */
	drop model msrp; /* Excludes variables from output SAS data sets. */
	label type='Style' origin='Origin from Car'; /* Assigns descriptive labels to variables. */
run; /* Executes the previously entered SAS statements. */

proc contents data=work.autos; /* The CONTENTS procedure shows the contents of a SAS data set and prints the directory of the SAS library. */
run;

proc print data=work.autos label /* Uses variables' labels as column headings.*/;
	label Invoice = 'Total Invoice';
run;

/* Adding format to SAS Data Sets Variables */
data work.autos; /* Begins a DATA step and provides names for any output SAS data sets, views, or programs. */
	set sashelp.cars; /* Reads an observation from one or more SAS data sets. */
	drop model msrp; /* Excludes variables from output SAS data sets. */
	label type='Style' origin='Origin from Car'; /* Assigns descriptive labels to variables. */
	format weight comma10. invoice dollar8.;/* Associates formats with variables. */
run; /* Executes the previously entered SAS statements. */

proc print data=work.autos;
run;












