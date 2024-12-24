-- DATA CLEANING 
-- REMOVE DUPLICATES 
-- STANDARDISE THE DATA
-- 3. NULL VALUES OR BLANK VALUES 
--  4.REMOVES ANY UNNEDDED COLMNS
-- IMPORT A DATASET AND CLEAN THE DATA
-- IMPORT DATA 

SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- TRY TO IDENTIFY DUPLICATES

WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company ,location, industry, total_laid_off, percentage_laid_off, `date` ,stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT * 
FROM layoffs_staging
WHERE company = 'Casper';

-- to delete the extra tables we created an extra table and deleting it where that row is >= 2
 
 CREATE TABLE layoffs_staging2 (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);

SELECT *
FROM layoffs_staging2;


INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company ,location, industry, total_laid_off, percentage_laid_off, `date` ,stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;

-- Standardising data: finding issues in the data and then fixing it

SELECT company, (TRIM(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- UPDATE THE CRYPO CURRENCY TO CRYPTO

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

-- CHECK to see if their is any errors in country and we found a period after united states so we need to remove it
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'united states%'
ORDER BY 1;

SELECT DISTINCT country , TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging2;

-- CHANGE DATE COLUMN FROM TEXT TO DATE

SELECT 	`date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN 	`date` DATE;

-- WORKING WITH NULL VALUES
SELECT *
FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL; 

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- POPULATING DATA THAT CAN BE POPULATED 
SELECT *
FROM layoffs_staging2
WHERE company= 'airbnb';

SELECT * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry ='';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL )
AND t2.industry IS NOT NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;











