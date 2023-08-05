/* Import a data file with unstructured data */

proc import datafile="s:/workshop/data/storm_damage.csv" dbms=csv
	    out=storm_damage_import replace;
run;


proc contents data=storm_damage_import;
run;