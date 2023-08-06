proc freq data=sashelp.heart;
    tables Chol_Status;
run;

proc freq data=sashelp.heart order=freq nlevels;
    tables Chol_Status;
run;

proc freq data=sashelp.heart order=freq nlevels; /* Number of levels for Chol_Status*/
    tables Chol_Status / nocum; /* No cumulative values*/
run;

proc freq data=sashelp.heart order=freq nlevels; /* Number of levels for Chol_Status*/
    tables Chol_Status / nocum plots=freqplot(orient=horizontal scale=percent); /* No cumulative values with graph*/
run;

ods graphics on;
ods noproctitle;
title "Frequency Report for Chol Status";
proc freq data=sashelp.heart order=freq nlevels; /* Number of levels for Chol_Status*/
    tables Chol_Status / nocum plots=freqplot(orient=horizontal scale=percent); /* No cumulative values with graph*/
    label Chol_Status="Cholesterol Status";
run;
title;
ods proctitle; 

/* Creating Two-Way Frequency Reports */
proc freq data=sashelp.heart;
	tables BP_Status*Chol_Status;
run;

proc freq data=sashelp.heart;
	tables BP_Status*Chol_Status / norow nocol nopercent; /* No Percent,Row Pct,Col Pct frequency values in the output*/
run;

proc freq data=sashelp.heart;
	tables BP_Status*Chol_Status / list; /* Shows a frequency list for every combination of the fields*/
run;

proc freq data=sashelp.heart noprint; /* No print for the step */
	tables BP_Status*Chol_Status / out=chol_status_by_BP; /* Creates a new table for frequency output */
run;
