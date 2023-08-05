data work.shoes; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.shoes;
    NetSales=Sales-Returns; /* creates a new field named NetSales */
run;

proc print data=work.shoes; /* Print all rows*/
run;

proc print data=work.shoes; /* Filter store greater than 12*/
	where stores>28;
run;

proc print data=work.shoes; /* Filter regions equals to canada */
	where Region="Canada";
run;

proc print data=work.shoes; /* Filter regions equals to canada or Usa*/
	where Region in ("Canada","United States");
run;

proc print data=work.shoes; /* Filter according to a multiple condition*/
	where Region in ("Canada","United States") and Stores=2;
run;

proc print data=work.shoes; /* Filter according to a non missing condition*/
	where Region is not missing and Stores>28;
run;

proc print data=work.shoes; /* Filter according to a null condition*/
	where Region is not null;
run;

proc print data=work.shoes; /* Filter according to range condition*/
	where Stores between 20 and 28;
run;

proc print data=work.shoes; /* Filter rows that contain "sa" for the first letters*/
	where subsidiary like "Sa%";
run;

proc print data=work.shoes; /* Filter according to like condition*/
	where subsidiary like "%S_%";
run;

proc print data=work.shoes; /* Filter according to like condition*/
	where subsidiary like "%Sa_ %";
run;


/* Filtering using Macro Variables*/
%let Stores=20;
%let Subsidiary="Cairo";

proc print data=work.shoes;
	where Stores=&Stores and Subsidiary=&Subsidiary;
	var Stores Subsidiary Sales;
run;

proc means data=work.shoes;
	where Stores=&Stores and Subsidiary=&Subsidiary;
	var Stores Sales;
run; 

