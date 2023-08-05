data work.shoes; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.shoes;
    NetSales=Sales-Returns; /* creates a new field named NetSales */
run;

proc print data=work.shoes; /* Print all rows*/
run;

proc print data=work.shoes; /* It rounds the output value without decimals*/
	format sales inventory 10.;
run;

proc print data=work.shoes; /* It rounds the output value using DOLLAR format*/
	format sales inventory DOLLAR10.2;
run;

proc print data=work.shoes; /* It rounds the output value using EURO format*/
	format sales inventory EUROX10.2;
run;


data work.workers; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.workers;
run;

proc print data=work.workers; /* It transforms the field date to date7 format "15jan18" */
	format date date7.;
run;

proc print data=work.workers; /* It transforms the field date to weekdate format "Monday, January 15, 2018" */
	format date weekdate;
run;