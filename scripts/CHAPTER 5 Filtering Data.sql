-- Intermediate Level
-- CHAPTER 5: Filtering Data
/* WHERE Operators->
		Comparison: =, <> / =!, >, >=, <, <=  - compare two things
		Logical: AND, OR, NOT - combine multiple operators
		Range: BETWEEN - check whether a value falls between a specific range
		Membership: IN, NOT IN - check whether a value is in list or not
		Search: LIKE - in order to search for a specific thing in a text*/

/* COMPARISON Operator -> Expression  Operator Expression(Condition)
Column1 = column2         first_name = last_name
Column1 = Value           first_name = 'John'
Function = Value          UPPER(first_name) = 'JOHN'
Expression = Value        Price * Quantity = 1000
Subquery = Value          (SELECT AVG(sales) FROM orders) = 1000  [Advanced]*/

SELECT * FROM customers

-- Equal(=) from Germany
SELECT 
    *
FROM customers
WHERE country = 'Germany'

-- Not Equal(!=/<>) not from Germany
SELECT 
    *
FROM customers
WHERE country <> 'Germany'

-- Greater than(>) score > 500
SELECT 
    *
FROM customers
WHERE score > 500

-- Greater than(>=) score >= 500
SELECT 
    *
FROM customers
WHERE score >= 500

--Less than(<) score < 500
SELECT 
    *
FROM customers
WHERE score < 500

-- Less than(<=) score <= 500
SELECT 
    *
FROM customers
WHERE score <= 500

/* LOGICAL Operators & RANGE Operators*/

-- AND - All conditions MUST be true
SELECT 
    *
FROM customers
WHERE country = 'USA' AND score > 500

-- OR - At least one condition Must be TRUE
SELECT 
    *
FROM customers
WHERE country = 'USA' OR score > 500

-- NOT - (Reverse) Excludes matching values
SELECT 
    *
FROM customers
WHERE NOT country = 'USA'  -- customers NOT from USA

SELECT 
    *
FROM customers
WHERE score >= 500  -- customers NOT less than 500 (the oposite of < is >=)

-- BETWEEN - Check if a value is within a range (Lower & Upper Boundaries are inclusive)
SELECT 
    *
FROM customers
WHERE score BETWEEN 500 AND 900

SELECT 
    *
FROM customers
WHERE score >= 500 AND score <= 900  -- Using Comparison & Logical Operators 

/* MEMBERSHIP Operators*/

-- IN - Check if a value exists in a list
SELECT 
    *
FROM customers
WHERE country = 'Germany' OR country = 'USA'

SELECT 
    *
FROM customers
WHERE country IN ('Germany', 'USA') -- Recommended instead of OR for ,ultiple values in the same column to simplify SQL

-- NOT IN (Reverse)
SELECT 
    *
FROM customers
WHERE country NOT IN ('Germany', 'USA')

/* SEARCH Operators*/

-- LIKE - search for a pattern in a text
/* Pattern: % or _

% - Anything: 0, 1 or many characters
_ - Excatly 1 character
% Example: 
            M%  - Maria, Ma, M BUT NOT Emma(X)
            %in - Martin, Vin, in BUT NOT Jasmine 
            %R% - Maria, Peter, Ryan, R BUT NOT Alice  -  Any name that has an 'r'

_ Example:
            __b% - Albert, Rob BUT NOT Abel, An*/

-- Find all customers whose first name starts with 'M'
SELECT 
    *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name ends with 'n'
SELECT 
    *
FROM customers
WHERE first_name LIKE '%n'

-- Find all customers whose first name contains 'r'
SELECT 
    *
FROM customers
WHERE first_name LIKE '%r%'

-- Find all customers whose first name has 'r' in the third position
SELECT 
    *
FROM customers
WHERE first_name LIKE '__r%'

