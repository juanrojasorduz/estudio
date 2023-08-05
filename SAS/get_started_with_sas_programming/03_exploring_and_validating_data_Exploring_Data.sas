data work.shoes; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.shoes;
    NetSales=Sales-Returns; /* creates a new field named NetSales */
run;

proc print data=work.shoes; /* Print all rows*/
run;

proc print data=work.shoes (obs=10); /* Print the first 10 rows*/
run;

proc print data=work.shoes (obs=10); /* Print the first 10 rows*/
	var  Inventory NetSales Returns Sales; /* Just For this fields*/
run;

proc means data=work.shoes; /* Print mean statistics just for those fields*/
	var NetSales Returns Sales;
run;

proc univariate data=work.shoes; /* Evaluates extreme values */
	var NetSales Returns Sales;
run;

proc freq data=work.shoes; /* List unique values and frequencies */
	tables  Product Subsidiary;
run;



	
