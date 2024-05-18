Q1. Write a code to check NULL values
# Write a code to check NULL values
SELECT * FROM coronadb.coronadata
WHERE `Confirmed` IS NULL
OR `Deaths` IS NULL
OR `Recovered` IS NULL
OR `Longitude` IS NULL
OR `Latitude` is NULL
OR `Country/Region` IS NULL
OR `Province` is NULL;
------
Q2. If NULL values are present, update them with zeros for all columns. 

#If NULL values are present, update them with zeros for all columns.

UPDATE coronadb.coronadata
SET Confirmed = COALESCE(Confirmed, 0),
    Deaths = COALESCE(Deaths, 0),
    Recovered = COALESCE(Recovered, 0)
WHERE Confirmed IS NULL
    AND Deaths IS NULL
    AND Recovered IS NULL;
-------
Q3. check total number of rows
# check total number of rows

SELECT COUNT(*) FROM coronadb.coronadata;
----
 Q4. Check what is start_date and end_date
#Check what is start_date and end_date

SELECT MIN(Date) AS StartDate, MAX(Date) AS EndDate FROM coronadb.coronadata;
-----
Q5. Number of month present in dataset
# Number of month present in dataset

SELECT MONTH(Date) AS Month, COUNT(*) AS NumOfMonths FROM coronadb.coronadata GROUP BY Month;
-----
Q6. Find monthly average for confirmed, deaths, recovered
 #Find monthly average for confirmed, deaths, recovered
 SELECT 
    MONTH(Date) AS Month,
    YEAR(Date) AS Year,
    AVG(Confirmed) AS AvgConfirmed,
    AVG(Deaths) AS AvgDeaths,
    AVG(Recovered) AS AvgRecovered
FROM 
    coronadb.coronadata
GROUP BY 
    Month, Year
ORDER BY 
    Year, Month;
------
Q7. Find most frequent value for confirmed, deaths, recovered each month 

#Find most frequent value for confirmed, deaths, recovered each month
SELECT 
    MONTH(Date) AS Month,
    YEAR(Date) AS Year,
    SUBSTRING_INDEX(GROUP_CONCAT(Confirmed ORDER BY confirmed DESC), ',', 1) AS MostFrequentConfirmed,
    SUBSTRING_INDEX(GROUP_CONCAT(Deaths ORDER BY deaths DESC), ',', 1) AS MostFrequentDeaths,
    SUBSTRING_INDEX(GROUP_CONCAT(Recovered ORDER BY recovered DESC), ',', 1) AS MostFrequentRecovered
FROM 
    coronadb.coronadata
GROUP BY 
    Month, Year
ORDER BY 
    Year, Month;
-----
Q8. Find minimum values for confirmed, deaths, recovered per year

#Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year,
    MIN(Confirmed) AS MinConfirmed,
    MIN(Deaths) AS MinDeaths,
    MIN(Recovered) AS MinRecovered
FROM 
    coronadb.coronadata
GROUP BY Year
ORDER BY Year;
----
Q9. Find maximumn values for confirmed, deaths, recovered per year

#Find maximumn values for confirmed, deaths, recovered per year
SELECT 
    YEAR(Date) AS Year,
    MAX(Confirmed) AS MaxConfirmed,
    MAX(Deaths) AS MaxDeaths,
    MAX(Recovered) AS MaxRecovered
FROM 
    coronadb.coronadata
GROUP BY Year
ORDER BY Year;
------
Q10. The total number of case of confirmed, deaths, recovered each month
#The total number of case of confirmed, deaths, recovered each month
    SELECT 
    MONTH(Date) AS Month,
    YEAR(Date) AS Year,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM 
    coronadb.coronadata
GROUP BY Month, Year
ORDER BY Year, Month;
------
Q11. Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
/*Check how corona virus spread out with respect to confirmed case
--      (Eg.: total confirmed cases, their average, variance & STDEV )*/
SELECT 
    SUM(Confirmed) AS TotalConfirmed,
    AVG(Confirmed) AS AvgConfirmed,
    VARIANCE(confirmed) AS VarianceConfirmed,
    STDDEV(confirmed) AS StdevConfirmed
FROM 
    coronadb.coronadata;
-------
Q12. Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
/*Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )*/

SELECT 
    MONTH(Date) AS Month,
    SUM(Deaths) AS TotalDeaths,
    AVG(Deaths) AS AvgDeaths,
    VARIANCE(Deaths) AS VarianceDeaths,
    STDDEV(Deaths) AS StdevDeaths
FROM 
    coronadb.coronadata
GROUP BY Month
ORDER BY Month;
------
Q13. Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
/* Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )*/
SELECT 
    SUM(Recovered) AS TotalRecovered,
    AVG(Recovered) AS AvgRecovered,
    VARIANCE(Recovered) AS VarianceRecovered,
    STDDEV(Recovered) AS StdevRecovered
FROM 
    coronadb.coronadata;
-------
Q14.Find Country having highest number of the Confirmed case*/
# Finding By Country/Region.
/*Find Country having highest number of the Confirmed case*/
# Finding By Country/Region.
SELECT 
    `Country/Region`,
    SUM(`Confirmed`) AS TotalConfirmed
FROM 
    coronadb.coronadata
GROUP BY 
    `Country/Region`
ORDER BY 
    TotalConfirmed DESC
LIMIT 1;
------
Q15. Find Country having lowest number of the death case
/*Find Country having lowest number of the death case*/
SELECT 
    `Country/Region`,
    MIN(`Deaths`) AS LowestDeaths
FROM 
    coronadb.coronadata
GROUP BY 
    `Country/Region`
ORDER BY 
    LowestDeaths ASC
LIMIT 5;
-------
Q16. Find top 5 countries having highest recovered case
/*Find top 5 countries having highest recovered case*/
SELECT 
    `Country/Region`,
    SUM(`Recovered`) AS TotalRecovered
FROM
coronadb.coronadata
GROUP BY
	`Country/Region`
ORDER BY
	TotalRecovered DESC
LIMIT 5;
--------