--###################################################################
--MUST BE RAN AFTER TABLES ARE FILLED!!!!!!!-----------------
--###################################################################

--altering houlrytotal table to have a total column
alter table "Production".hourlytotal
add column "TOTAL PRODUCTION" int;
--updating the newly made column to be the sum of the other columns
update "Production".hourlytotal
set "TOTAL PRODUCTION" = "RENEWABLES"+"NUCLEAR"+"THERMAL"+"HYDRO";




--Using select statement to insert joined data into percent production table
insert into "Comparison".percentproductionrenewable 
	select r."timestamp" as "Date",
	sum(t."TOTAL PRODUCTION") as "Total Production",
	sum(r."TOTAL") as "Renewable Production"
	from "Production".hourlyrenewable as r
	left join 
	"Production".hourlytotal as t
	on
	r.timestamp = t.timestamp
	group by "Date"
	order by "Date" desc;

--Updating the table to have the percent calculation column
update "Comparison".percentproductionrenewable
set "Percent Production Renew" = "Renewable Production" / "Total Production";



--#############################################################################


--filling new table with data from other tables
insert into "Comparison".percentdemandrenewable 
	select r."timestamp" as "Date",
	sum(d."DEMAND") as "Total Demand",
	sum(r."TOTAL") as "Renewable Production"
	from "Production".hourlyrenewable as r
	left join 
	"Demand".hourlydemand as d
	on
	r.timestamp = d.timestamp
	group by "Date"
	order by "Date" desc;
--created calulated column of percent of demand met by renew	
update "Comparison".percentdemandrenewable
set "Percent Demand Renew" = "Renewable Production" / "Total Demand";
--make sure it worked 
select * from "Comparison".percentdemandrenewable;
select * from "Comparison".percentproductionrenewable;
select * from "Production".hourlyrenewable;
select * from "Production".hourlytotal;
select * from "Demand".hourlydemand;