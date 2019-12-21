
--Creating schemas for DB
CREATE SCHEMA "Production";

CREATE SCHEMA "Demand";

CREATE SCHEMA "Comparison";

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
);




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


--Creating table for hourly demand data in demand schema
--select statement AFTER filling from jupyter notebook to check data
CREATE TABLE "Demand".hourlydemand(
	"timestamp" timestamp PRIMARY KEY,
	"date" date not null,
	"Hour" int not null,
    "DEMAND" int
);


--Creating table "percent production renewable"
CREATE TABLE "Comparison".percentproductionrenewable(
	"Date" timestamp primary key,
	"Total Production" float,
	"Renewable Production" float,
	"Percent Production Renew" float
);

--Second calculated table "Percent Demand Renewable"
CREATE TABLE "Comparison".percentdemandrenewable(
	"Date" timestamp primary key,
	"Total Demand" float,
	"Renewable Production" float,
	"Percent Demand Renew" float
);