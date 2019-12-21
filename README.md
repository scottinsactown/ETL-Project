# ETL-Project

The goal of this project was to build out a comprehensive database for how energy flows in California.  We established a solid set of data on renewable energy in California with our first class project, but we wanted to continue to expand the work. We sought out additional ways to gather data based on the skills taught in class with three particular goals in mind: find renewable energy information for after 2017, incorporate non-renewable energy production data, and identify hourly demand data. 

Execution Instructions
-
1. Create database "cali_renewable_db" in postgreSQL
2. Run db_schema.sql in SQL folder to create schema and tables
3. Run the two Jupyter notebooks in the CAISO SCRAPE folder
4. Run seedings.sql in SQL folder to update tables and build comparison tables
5. Run app.py in flask-api-app folder
6. Enjoy! 

Contents
- 
- CAISO SCRAPE:
  - CAISO-scrape Jupyter notebook used to scrape CAISO website
  - EIA_API Jupyter notebook used to access EIA API demand data
- SQL:
  - db_schema SQL schema and table set-up
  - seedings.sql updates tables and builds comparison tables
- flask-api-app:
  - app.py flask set-up
  - templates includes index.html
  - static includes images posted on index page
- ETL_Project_Report sums up the overall project effort
  
  
  
