data myshoes;
	set sashelp.shoes;
run;

proc means data=work.myshoes mean median min max maxdec=0;
    var Sales;
    class Product Subsidiary;
    ways 0 1 2;
run;

/* Creating an Output Summary Table */
proc means data=sashelp.heart noprint;
    var Weight;
    class Chol_Status;
    ways 1;
    output out=heart_stats mean=AvgWeight;
run;