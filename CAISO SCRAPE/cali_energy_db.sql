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

