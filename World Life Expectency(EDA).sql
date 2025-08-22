# World_Life_Expectency Project - Exploratory Data Analysis(EDA)
#BY Nayem Mia


SELECT *
FROM world_life_expectancy;

#Lets see what is the each country's Lowest life Expectency And Highest Life Expectency look like

SELECT country,
MIN(Lifeexpectancy),
MAX(Lifeexpectancy)
FROM world_life_expectancy
GROUP BY country
ORDER BY country DESC;

#Okey that is a huge jump for some country.But we have some issues.Some of the country's Life expectency is 0.
#I think that is a data issue.Lets fix this,

SELECT country,
MIN(Lifeexpectancy),
MAX(Lifeexpectancy)
FROM world_life_expectancy
GROUP BY country
HAVING MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY country DESC;

#Now Lets see which Country has made the biggest jump to increase life expectency

SELECT country,
MIN(Lifeexpectancy),
MAX(Lifeexpectancy),
ROUND(MAX(Lifeexpectancy)-MIN(Lifeexpectancy),0) AS increased_years
FROM world_life_expectancy
GROUP BY country
HAVING MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY increased_years DESC;

#Well that is some huge jump for some country's. Now lets see the average life expectency by year

SELECT year,
ROUND(AVG(lifeexpectancy),2) AS ALE
FROM world_life_expectancy
WHERE (Lifeexpectancy) <> 0
AND (Lifeexpectancy) <> 0
GROUP BY year
ORDER BY year DESC;

#That is some good news.We have increased some 6 years of life expectency in whole world.
#NOW,Lets find out the co-relation between LIfe Expectancy and GDP.I want tom see if the GDP is higher when the life expectency is higher as well countrywise

SELECT country,
ROUND(AVG(Lifeexpectancy),1) AS life_exp,
ROUND(AVG(GDP),1) avg_gdp
FROM world_life_expectancy
GROUP BY country
HAVING life_exp <> 0
AND avg_gdp <> 0
ORDER BY  avg_gdp;

#AS we can see when the gdp is higher the life expectency is higher as well

SELECT 
SUM(CASE WHEN gdp >= 1500 THEN 1 ELSE 0 END) high_gdp_country,
AVG(CASE WHEN gdp >= 1500 THEN lifeexpectancy ELSE null END) high_gdp_life_expectancy,
SUM(CASE WHEN gdp <= 1500 THEN 1 ELSE 0 END) low_gdp_country,
AVG(CASE WHEN gdp <= 1500 THEN lifeexpectancy ELSE null END) low_gdp_life_expectancy
FROM world_life_expectancy;

#Lets see what are the average LIfe expectancy for Developing and Developed country

SELECT status,COUNT(DISTINCT country) AS country,
ROUND(AVG(Lifeexpectancy),1) AS avg_LE
FROM world_life_expectancy
GROUP BY status;

#Now let's see how life expectency affects BMI

SELECT country,
ROUND(AVG(Lifeexpectancy),1) AS LE,
ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING LE > 0
AND BMI >0
ORDER BY BMI DESC;

#Goodness! That is a really high BMI.I think the average BMI is likely 25.
#Lets find out how many people are dying for countries compared to their life expectency.

SELECT country,
Year,
Lifeexpectancy,
AdultMortality,
SUM(AdultMortality) OVER(PARTITION BY country ORDER BY year) AS Rolling_total
FROM world_life_expectancy

#we have the rolling total for adult mortality rate.we can see the changes for each countries happening over the years.




















