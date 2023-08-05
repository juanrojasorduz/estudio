data cars_new;
	set sashelp.cars;
	where origin ne "USA";
	profit=MSRP-Invoice;
	source="Non-US Cars";
	median_profit=MEAN(MSRP, Invoice);
	total_profit=SUM(MSRP, Invoice);
	upcase_make=UPCASE(Make);
	substr_model=SUBSTR(Model, 1, 3);

	if MSRP > 30000 then
		profit_type="High Profit";
	else if MSRP <=30000 and MSRP > 20000 then
		profit_type="Medium Profit";
	else
		profit_type="Low Profit";
	format profit dollar10.;
	keep make model MSRP invoice profit source median_profit total_profit 
		upcase_make substr_model profit_type;
run;

data cars_new;
	set sashelp.cars;
	where origin ne "USA";
	profit=MSRP-Invoice;
	source="Non-US Cars";
	median_profit=MEAN(MSRP, Invoice);
	total_profit=SUM(MSRP, Invoice);
	upcase_make=UPCASE(Make);
	substr_model=SUBSTR(Model, 1, 3);

	if MSRP > 30000 then
		do;
			profit_type="High Profit";
			car_type="Great Car";
		end;
	else if MSRP <=30000 and MSRP > 20000 then
		do;
			profit_type="Medium Profit";
			car_type="Regular Car";
		end;
	else
		do;
			profit_type="Low Profit";
			car_type="Bad Car";
		end;
	format profit dollar10.;
	keep make model MSRP invoice profit source median_profit total_profit 
		upcase_make substr_model profit_type car_type;
run;

data front rear;
	set sashelp.cars;

	if DriveTrain="Front" then
		do;
			DriveTrain="FWD";
			output front;
		end;
	else if DriveTrain='Rear' then
		do;
			DriveTrain="RWD";
			output rear;
		end;
run;