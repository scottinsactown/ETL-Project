-- Creating table for hourly renewable production data in Production schema 
--then selecting from it after writing from pandas

CREATE TABLE "Production".hourlyrenewable(
	"timestamp" timestamp PRIMARY KEY,
	"date" date not null,
	"Hour" int not null,
	"TOTAL" int,
	"SOLAR TOTAL" int,
	"SOLAR PV" int,
	"SOLAR THERMAL" int,
	"WIND TOTAL" int,
	"GEOTHERMAL" int,
	"BIOMASS" int,
	"BIOGAS" int,
	"SMALL HYDRO" int
)
select * from "Production".hourlyrenewable


--Creating table for hourly total production in Production schema 
--select after writing from pandas to make sure all the data is there 
CREATE TABLE "Production".hourlytotal(
	"timestamp" timestamp PRIMARY KEY,
	"date" date not null,
	"Hour" int not null,
	"RENEWABLES" int,
	"NUCLEAR" int,
	"THERMAL" int,
	"HYDRO" int
);
select * from "Production".hourlytotal

--Creating table for hourly demand data in demand schema
--select statement AFTER filling from jupyter notebook to check data
CREATE TABLE "Demand".hourlydemand(
	"timestamp" timestamp PRIMARY KEY,
	"date" date not null,
	"Hour" int not null,
    "DEMAND" int
);

select * from "Demand".hourlydemand


--###################################################################
--MUST BE RAN AFTER TABLES ARE FILLED!!!!!!!-----------------
--###################################################################

--Creating table "percent production renewable"
CREATE TABLE "Comparison".percentproductionrenewable(
	"Date" timestamp primary key,
	"Total Production" float,
	"Renewable Production" float,
	"Percent Production Renew" float
);
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
--check if it worked properly 
select * from "Comparison".percentproductionrenewable;



--#############################################################################


--Second calculated table "Percent Demand Renewable"
CREATE TABLE "Comparison".percentdemandrenewable(
	"Date" timestamp primary key,
	"Total Demand" float,
	"Renewable Production" float,
	"Percent Demand Renew" float
);


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