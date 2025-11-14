-- CHAPTER 7 - 1: SQL Functions - STRING FUNCTIONS
--manipulate, aggregation(analyze, clean), transform
/* Functions - A built-in SQL code: 
					accepsts an input value
					processes it
					returns an output value
		1. Single- row functions - onE value, output is one value eg LOWER()
		2. Mutli-row functions - multiple rows and summarize one value eg SUM()

	Nested functions - Functions used inside another function
						Eg. LEN (LOWER(LEFT('Maria',2)))

	Types of SQL Functions
a). Single-row (row-level calculations): String, Numeric, Date & Time, Null
    this manipilates and prepares for multi row 
	ie DE clean up, transform and manipulate your data for the analysis
b). Multi-row (Aggregations): Aggregate (basic), Window (advanced) - DA */
USE MyDatabase

/* STRING FUNCTIONS
			Manipulation - CONCAT, UPPER, LOWER, TRIM, REPLACE
			Calculation - LEN
			String Extraction - LEFT, RIGHT, SUBSTRING */

--Manipulation
	 -- i. CONCAT - combines multiple strings into one value
	 --Show a list of customers' first names together with their country in one column
SELECT
	first_name,
	country,
	CONCAT(first_name, ' - ', country) AS name_country
FROM customers

	 -- ii. UPPER - converts all characters to uppercase
	 -- iii. LOWER - converts all characters to lowercase
SELECT
	first_name,
	country,
	CONCAT(first_name, ' - ', country) AS name_country,
	UPPER(first_name) AS Upper_name,
	LOWER(first_name) AS low_name
FROM customers

	 -- iv. TRIM - Removes leading and trailing spaces (empty spaces)
-- Find customers whose first name contains leading or trailing spaces
SELECT
	first_name
	FROM customers
WHERE first_name != TRIM(first_name) -- easier

SELECT
	first_name,
	LEN(first_name) len_name,   -- check length of names
	LEN(TRIM(first_name)) len_trim_name,  -- trim names and check the length
	LEN(first_name) - LEN(TRIM(first_name))  flag -- checks if the char match 
FROM customers
WHERE LEN(first_name) != LEN(TRIM(first_name))

	 -- v. REPLACE - Replaces specific character with a new character
SELECT
'123-456-789', -- remove dashes (-) from phone number
REPLACE('123-456-789', '-', ' ') AS clean_phone  -- or '', '/'

SELECT
'report.txt' AS old_filename,
REPLACE('report.txt', '.txt', '.csv') AS new_filename  -- replace file extence from txt to csv

-- Calculation
	 -- LEN - Counts how many characters
	 --Calculate the length of each customer's firts name
SELECT
'123-456-789',
LEN('123-456-789')

SELECT
	first_name,
	LEN(first_name) AS len_name
FROM customers

-- String Extraction
	 -- i. LEFT - Extracts specific number of characters from the start
	 -- ii. RIGHT - Extracts specific number of characters from the end
				-- (Value, No of characters)
SELECT
'123-456-789',
LEFT('123-456-789', 3),
RIGHT('123-456-789', 4)

-- Retrieve the firts two characters of each first name
SELECT
	first_name,
	LEFT(TRIM(first_name), 2) AS first_2_char,
	RIGHT(first_name, 2) AS last_2_char
FROM customers  -- TRIM since there is an empty space in 'John'

	 -- iii. SUBSTRING - Extracts a part of string at a specified position
				-- (Value, Start, Length)
SELECT
'123-456-789',
SUBSTRING('123-456-789', 5, 3)

-- Retrieve a list of customers' first names after removing the first character
SELECT
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name)) AS sub_name
FROM customers      -- LEN(first_name) - makes the length dynamic since the names have different no of chars

