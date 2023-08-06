ods csvall file="/home/u63525278/sasuser.v94/cars.csv";
proc print data=sashelp.cars noobs;
    var Make Model Type MSRP MPG_City MPG_Highway;
    format MSRP dollar8.;
run;
ods csvall close;


/* Exporting Results to Excel */
ods excel file="/home/u63525278/sasuser.v94/cars.xlsx";
ods graphics on;
ods noproctitle;
title "Frequency Report for Chol Status";
proc freq data=sashelp.heart order=freq nlevels; /* Number of levels for Chol_Status*/
    tables Chol_Status / nocum plots=freqplot(orient=horizontal scale=percent); /* No cumulative values with graph*/
    label Chol_Status="Cholesterol Status";
run;
title;
ods proctitle; 
ods excel close;

/* Exporting Results to Excel with specific Names*/
ods excel file="/home/u63525278/sasuser.v94/products.xlsx" style=sasdocprinter
          options(sheet_name="Product Stats");
title "Sales Statistics by Product";
ods noproctitle;
proc means data=work.myshoes min mean median max maxdec=0;
    class Product;
    var Sales;
run;

ods excel options(sheet_name="Sales Distribution");
title "Distribution of Sales";
proc sgplot data=work.myshoes;
    histogram sales;
    density sales;
run;
title;
ods proctitle;
*Add ODS statement;
ods excel close;

/* Exporting Results to PDF */
ods pdf file="/home/u63525278/sasuser.v94/products.pdf" startpage=no style=journal pdftoc=1;
ods noproctitle;

ods proclabel "Products Statistics";
title "Sales Statistics by Product";
proc means data=work.myshoes min mean median max maxdec=0;
    class Product;
    var Sales;
run;

ods proclabel "Sales Distribution";
title "Distribution of Sales";
proc sgplot data=work.myshoes;
    histogram sales;
    density sales;
run;
title;

ods pdf close;

