
World Life Expectancy Data Cleaning
This project focuses on cleaning a dataset containing global life expectancy data.
The cleaning process was performed using SQL, involving duplicate removal, missing value handling, and data consistency improvements.

📂 Project Overview
The dataset contains yearly life expectancy, country classification (Developed/Developing), and related demographic information.
Key objectives were:

Identify and remove duplicate rows.

Fill in missing values for categorical and numerical fields.

Ensure consistent and reliable data for further analysis.

🛠️ Steps Performed
1. Duplicate Removal
Detected duplicates using:

```
SELECT country, year, COUNT(*) 
FROM world_life_expectancy
GROUP BY country, year
HAVING COUNT(*) > 1;
```

Deleted duplicates to maintain dataset integrity.

2. Filling Missing Values
Status Column

Filled blanks with “Developed” or “Developing” by matching other records for the same country.

Life Expectancy Column

For missing numerical values, used interpolation by averaging the previous and next year’s life expectancy for that country.

3. Final Verification
Ensured no missing values remained in critical columns.

Verified data consistency.

💻 Tech Stack
SQL: MySQL syntax for data cleaning

Dataset: World Life Expectancy data
