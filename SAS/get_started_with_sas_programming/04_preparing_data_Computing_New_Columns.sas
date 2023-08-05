data cars_new;
	set sashelp.cars;
	where origin ne "USA";
	profit = MSRP-Invoice;
	source = "Non-US Cars";
	format profit dollar10.;
	keep make model MSRP invoice profit source;
run;

/* Common Numeric Functions
SUM (num1, num2, ...)
MEAN (num1, num2, ...)
MEDIAN (num1, num2, ...)
RANGE (num1, num2, ...)
MIN (num1, num2, ...)
MAX (num1, num2, ...)
N (num1, num2, ...)
NMISS (num1, num2, ...)
*/

proc print data=work.cars_new;
run;

data cars_new;
	set sashelp.cars;
	where origin ne "USA";
	profit = MSRP-Invoice;
	source = "Non-US Cars";
	median_profit = MEAN(MSRP,Invoice);
	total_profit = SUM(MSRP,Invoice);
	format profit dollar10.;
	keep make model MSRP invoice profit source median_profit total_profit;
run;

/* Common Character Functions
UPCASE(char): Changes letters in a character string to uppercase 
LOWCASE(char): Changes letters in a character string to lowercase
PROPCASE(char, <delimiters>): Changes the first letter of each word to uppercase and other letters to lowercase
CATS(char1, char2, ...): Concatenates character strings and removes leading and trailing blanks from each argument
SUBSTR(char, position, <length>): Returns a substring from a character string
*/

data cars_new;
	set sashelp.cars;
	where origin ne "USA";
	profit = MSRP-Invoice;
	source = "Non-US Cars";
	median_profit = MEAN(MSRP,Invoice);
	total_profit = SUM(MSRP,Invoice);
	upcase_make=UPCASE(Make);
	substr_model=SUBSTR(Model,1,3);
	format profit dollar10.;
	keep make model MSRP invoice profit source median_profit total_profit upcase_make substr_model;
run;

/* Common Date Functions
MONTH (SAS-date)
YEAR (SAS-date)
DAY (SAS-date)
WEEKDAY (SAS-date)
QTR (SAS-date)
TODAY ()
MDY (month, day, year)
YRDIF (startdate, enddate, 'AGE')
*/

data workers_dates;
	set sashelp.workers;
	today_date=today();
	month=month(date);
	quarter=qtr(date);
	format today_date date7.;
	drop electric masonry;
	where qtr(date) between 1 and 2;
run;