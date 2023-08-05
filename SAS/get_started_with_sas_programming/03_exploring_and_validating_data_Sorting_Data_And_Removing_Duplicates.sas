data work.shoes; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.shoes;
    NetSales=Sales-Returns; /* creates a new field named NetSales */
run;

proc print data=work.shoes; /* Print all rows*/
run;

proc sort data=work.shoes out=products;  /* It creates a table with the sorted data */
	by _all_;
run;

proc sort data=work.shoes out=products nodupkey dupout=duplicates;   /* It creates a table with the sorted data and duplicate data*/
	by _all_;
run;

proc sort data=work.shoes out=products_by_sales;  /* It creates a table with the sorted data for products using the sales criteria*/
	by Product descending Sales;
run;

proc sort data=work.shoes out=products_by_sales nodupkey;  /* It creates a table with the sorted data for products and without duplicates*/
	by Product Subsidiary;
run;