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

CREATE TABLE "Production".percentproductionrenewable(
	"Date" timestamp primary key,
	"Total Production" float,
	"Renewable Production" float,
	"Percent Production Renew" float
);

alter table "Production".hourlytotal
add column "TOTAL PRODUCTION" int;
update "Production".hourlytotal
set "TOTAL PRODUCTION" = "RENEWABLES"+"NUCLEAR"+"THERMAL"+"HYDRO";
insert into "Production".percentproductionrenewable 
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
update "Production".percentproductionrenewable
set "Percent Production Renew" = "Renewable Production" / "Total Production";

select * from "Production".percentproductionrenewable;

CREATE TABLE "Demand".hourlydemand(
	"timestamp" timestamp PRIMARY KEY,
	"date" date not null,
	"Hour" int not null,
    "DEMAND" int
);

select * from "Demand".hourlydemand

