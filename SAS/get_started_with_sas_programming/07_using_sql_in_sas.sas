data shoes;
	set sashelp.shoes;
run;

proc sql;
	select Region, Product, sum(sales) as total_sales from work.shoes where 
		stores>=10 group by Region, Product Order by Region, Product desc;
quit;

title "Best Region for Shoes Sales";

proc sql;
	select upcase(Region) as region, Product, sum(sales) as total_sales from 
		work.shoes where stores>=10 group by Region, Product Order by Region, Product 
		desc;
quit;

title;

/* Creating and Deleting Tables in SQL */
proc sql;
	create table work.best_shoes as select upcase(Region) as region, Product, 
		sum(sales) as total_sales from work.shoes where stores>=10 group by Region, 
		Product Order by Region, Product desc;
quit;

proc sql;
	drop table work.best_shoes;
quit;

/* Creating Inner Joins in SQL */
proc sql;
select grade,age,teacher
	from pg1.class_update 
	inner join pg1.class_teachers on class_update.name = class_teachers.name;
quit;

proc sql;
select Season, Name, storm_summary.Basin, BasinName,MaxWindMPH
	from pg1.storm_summary
	inner join pg1.storm_basincodes on storm_summary.basin = storm_basincodes.basin
	order by season desc, name;
quit;

/* Aliases */
proc sql;
select Season, Name, s.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary as s 
        inner join pg1.storm_basincodes as b 
        on upcase(s.basin)=b.basin 
    order by Season desc, Name;
quit; 