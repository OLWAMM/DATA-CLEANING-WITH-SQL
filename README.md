# DATA-CLEANING-WITH-SQL
DATA CLEANING WITH SQL
# MySQL Data Cleaning Project

This project demonstrates the data cleaning process using MySQL. The code includes steps to:
1. Remove duplicates
2. Standardize data
3. Handle null or blank values
4. Remove unnecessary columns
5. Transform data types for better analysis

## Data Cleaning Steps
1. **Import Data**  
   - Import the dataset and create a staging table for modifications.

2. **Remove Duplicates**  
   - Identify duplicates using a `ROW_NUMBER` function and remove extra rows.

3. **Standardize Data**  
   - Trim whitespace from text fields.
   - Standardize industry names (e.g., changing "CRYPO" to "Crypto").
   - Fix errors in country names (e.g., removing trailing periods).

4. **Handle Null Values**  
   - Populate missing data where possible using existing data.
   - Delete rows where critical fields are null.

5. **Transform Data Types**  
   - Convert the `date` column from text to a `DATE` data type.

6. **Remove Unnecessary Columns**  
   - Drop helper columns (e.g., `row_num`) after use.

