data cars_new;
	set sashelp.cars;
run;

title1 "CARS 2023";
title2 "The Best cars you can buy this year";
footnote1 "Report Generated on 05AUG2023";

proc print data=work.cars_new;
run;

%let Year=2023; /* Using a Macrovariable */
title1 "CARS &Year";
title2 "The Best cars you can buy this year";
footnote1 "Report Generated on 05AUG2023";

proc print data=work.cars_new;
run;

/* Applying Temporary Labels to Columns */
proc means data=sashelp.cars;
	where type="Sedan";
	var MSRP MPG_Highway;
	label MSRP="Manufacturer Suggested Retail Price"
	      MPG_Highway="Highway Miles per Gallon";
run;

proc print data=sashelp.cars label;
	where type="Sedan";
	var Make Model MSRP MPG_Highway MPG_City;
	label MSRP="Manufacturer Suggested Retail Price"
	      MPG_Highway="Highway Miles per Gallon";
run;

/* Segmenting Reports */
proc sort data=sashelp.cars
		  out=cars_sort;
	by Origin;
run;

proc freq data=cars_sort;
	by Origin;
	tables Type;
run;

/* Enhancing Reports */
proc sort data=sashelp.cars out=cars_sorted;
	by origin Make Model;
	where MSRP >= 40000;
run;

title "Profitable Cars";
proc print data=cars_sorted;
	var make model type; 
	by origin;
	label make="Make By Car"
	  	  model="Model By Car"
	  	  type="Type By Car";
run;
	
/* Applying Permanent Labels to Columns */
data cars_update;
	set sashelp.cars;
	keep Make Model Type MSRP AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacter Suggested Retail Price"
		  AvgMPG="Average Miles per Gallon";
run;

proc contents data=cars_update;
run;