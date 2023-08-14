/* Creating a single DO Loop */
/*First Case*/
data compound_interest;
	drop principal rate;
	principal=1000;
	rate=.120;
	earnings=0;
	do month=1 to 12; /* Executes statements between DO and END repetitively based on the value of an index variable */
		earnings+(principal+earnings)*(rate/12);
		output; /*Writes the current observation to a SAS data set.*/
	end;
run;
proc print data=compound_interest noobs;
run;
/*Second Case*/
data what_day;
	drop year_val new_date_val;
	do year_val='2016', '2017', '2018', '2019', '2020';
		date_val='01/01/' || year_val;
		new_date_val=input(date_val, mmddyy10.);
		dow=strip(put(new_date_val, downame.));
		output;
	end;
run;

proc print data=work.what_day noobs;
run;



/* Do WHILE Loops */
/*First Case*/
data compound_interest;
	drop principal rate;
	principal=1000;
	rate=.120;
	earnings=0;
	month=0;
	do while(Earnings<=1000);
		earnings+(principal+earnings)*(rate/12);
		month+1;
		output; /*Writes the current observation to a SAS data set.*/
	end;
run;
proc print data=compound_interest noobs;
run;
/*Second Case*/
data compound_interest;
	drop principal rate;
	principal=1000;
	rate=.120;
	earnings=0;
	do month=1 to 100 while(Earnings<=1000);
		earnings+(principal+earnings)*(rate/12);
		output; /*Writes the current observation to a SAS data set.*/
	end;
run;
proc print data=compound_interest noobs;
run;



/* Do Until Loops */
data compound_interest;
	drop principal rate;
	principal=1000;
	rate=.120;
	earnings=0;
	month=0;
	do until(earnings>=1000);
		earnings+(principal+earnings)*(rate/12);
		month+1;
		output; /*Writes the current observation to a SAS data set.*/
	end;
run;
proc print data=compound_interest noobs;
run;



/* Nesting DO Loops */
data compound_interest;
	drop principal rate;
	principal=1000;
	rate=.120;
	earnings=0;
	do year=2017 to 2021;
		do month=1 to 12;
		   earnings+(principal+earnings)*(rate/12);
		   output; /*Writes the current observation to a SAS data set.*/
		end;
	end;
run;
proc print data=compound_interest noobs;
run;



/*Proc SQL */
/*Fist Case*/
proc sql;
	select make, model, type, origin from sashelp.cars
	where drivetrain='All' and Origin='USA';
quit;
/*Second Case*/
proc sql;
	create table my_report as 
	select make, model, type, origin from sashelp.cars
	where drivetrain='All' and Origin='USA'
	order by Model;
quit;
/*Third Case*/
title 'The my_report table just created';
proc print data=work.my_report noobs;
run;
/*Fourth Case*/
proc sql;
	select e.emp_id, e.emp_name, e.job_title, e.salary, c.country, c.phone
	from work.employees as e,
		 work.employee_contact as c
	where e.emp_id = c.emp_id;
quit;











