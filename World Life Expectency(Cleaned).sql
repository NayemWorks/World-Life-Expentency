#Hello,This is nayem Mia.Here I will be cleaning the dataset of world life expectency.

SELECT *
FROM world_life_expectancy;

#Found out the duplicates with this query.
#BUT we need row_id to remove this duplicates which is unique number to this table

SELECT country,year,CONCAT(country,year),COUNT(CONCAT(country,year)) 
FROM world_life_expectancy
GROUP BY country,year
HAVING COUNT(CONCAT(country,year)) >1;

#Found out the row_id using window function

SELECT *
FROM(
SELECT row_id,CONCAT(country,year),
ROW_NUMBER() OVER (PARTITION BY CONCAT(country,year) ORDER BY CONCAT(country,year)) AS row_num
FROM world_life_expectancy) AS row_tab
WHERE row_num > 1;

#We need to remove this duplicates

DELETE FROM world_life_expectancy
WHERE row_id IN(
	SELECT row_id
	FROM(	
		SELECT row_id,CONCAT(country,year),
		ROW_NUMBER() OVER (PARTITION BY CONCAT(country,year) ORDER BY CONCAT(country,year)) AS row_num
		FROM world_life_expectancy) AS row_tab
		WHERE row_num > 1);

#OK we have removed duplicates.But we have so many missing values we need to work with.Let's start with status.

SELECT *
FROM world_life_expectancy
WHERE status = '';

#As there is only 2 catagory in status we need to work them separatly

SELECT DISTINCT(country),status
FROM world_life_expectancy
WHERE status = 'Developing';

#Let's populate thease blanks

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status=''
AND t2.status<> ''
AND t2.status ='Developing';

#Same goes for Developed

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status=''
AND t2.status<> ''
AND t2.status ='Developed';

#Let's focus on life expectency.

SELECT country,year,lifeexpectancy
FROM world_life_expectancy
WHERE Lifeexpectancy = '';

#So,there are 2 blanks in life expectency.
#From the table as we can see the life expectency increases by year we can fill out the missing values by averageing previous and next year

SELECT t1.country,t1.year,t1.lifeexpectancy,
		t2.country,t2.year,t2.lifeexpectancy,
        t3.country,t3.year,t3.lifeexpectancy,
        ROUND((t2.lifeexpectancy+t3.lifeexpectancy)/2,1) AS life_expectency
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country=t2.country
    AND t1.year=t2.year-1
JOIN world_life_expectancy t3
	ON t1.country=t3.country
	AND t1.year=t3.year+1
WHERE t1.lifeexpectancy = '';

#We have the average for the missing values.Let's update the column

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country=t2.country
    AND t1.year=t2.year-1
JOIN world_life_expectancy t3
	ON t1.country=t3.country
	AND t1.year=t3.year+1
SET t1.lifeexpectancy = ROUND((t2.lifeexpectancy+t3.lifeexpectancy)/2,1)
WHERE t1.lifeexpectancy ='';

#OK there are no missing values in the dataset





