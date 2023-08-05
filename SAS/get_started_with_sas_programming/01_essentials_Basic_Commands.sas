/* Read sashelp.class table and create a copy named myclass */
data myclass;
    set sashelp.class;
run;

/* Print the table myclass */
proc print data=myclass;
run



data work.shoes; /* creates a new table in the schema work named shoes using sashelp.shoes */
    set sashelp.shoes;
    NetSales=Sales-Returns; /* creates a new field named NetSales */
run;


proc means; /* adds an output for means */

proc means data=work.shoes mean sum; /* adds mean and sum for work.shoes */

/* Adds mean and sum for every region just using NetSales */
proc means data=work.shoes mean sum;
    var NetSales;
    class region;
run;


