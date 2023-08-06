proc export data=sashelp.cars
     outfile="s:/workshop/output/cars.txt" /* File Path */
     dbms=tab replace; /* Replace the file if it already exists */
run;

proc export data=pg1.storm_final
     outfile="&outpath/storm_final.csv"
     dbms=csv replace;
run; 

libname myxl xlsx "&outpath/cars.xlsx"

data myxl.asiacars;
    set sashelp.cars;
    where origin="Asia";
run;

libname myxl clear;	