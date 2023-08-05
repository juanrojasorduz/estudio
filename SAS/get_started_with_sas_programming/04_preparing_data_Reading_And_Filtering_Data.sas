data myclass; /* We write a new table*/
	set sashelp.class; /* With this statement we create a copy from that table */
	where Age >=15; /* we filter ages */
	keep Name Age Height; /* We keep those columns */
run;


data myclass; /* We write a new table*/
	set sashelp.class; /* With this statement we create a copy from that table */
	where Age >=15; /* we filter ages */
	drop Sex Weight; /* We drop those columns */
	format Height 4.1 Weight 3.; /* We apply that format to those columns */
run;