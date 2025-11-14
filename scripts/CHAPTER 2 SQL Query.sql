--CHAPTER 2: SQL Query
/* 
Coding Order

SELECT DISTINCT TOP 2
    Col1,
    SUM(Col2)
FROM Table
WHERE Col = 10
GROUP BY Col1
HAVING SUM(Col2)>30
0RDER BY Col1 ASC

*/

/*
Execute Order
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT DISTINCT
6. ORDER BY
7. TOP
*/

SELECT 
    *
FROM customers

-- Retrieve all customers data

SELECT * 
FROM customers

-- select few columns

SELECT 
    first_name,
    country,
    score
FROM customers

-- filter your data base on a condition
-- customers with a score not equal to 0

SELECT *
FROM 
    customers
WHERE
    score != 0

    -- customers from Germany

SELECT 
    first_name,
    country
FROM 
    customers
WHERE
    country = 'Germany'

    -- dort your data from the highest tscore first

SELECT *
FROM 
    customers
ORDER BY 
    score desc

SELECT *
FROM 
    customers
ORDER BY 
    score asc

    -- sort you data using multiple columns
    /* Retrieve all customers and 
    sort the results by the country and then by the highest score.*/

SELECT *
FROM 
    customers
ORDER BY 
    country asc,
    score desc

    -- Find the Total Score and total number of customers for each country

SELECT
    country,
    SUM(Score) AS Total_Score,
    COUNT(id) AS Total_Customers
FROM customers
GROUP BY country

    -- HAVING

SELECT
    country,
    SUM(Score) AS Total_Score
FROM customers
WHERE Score > 400
GROUP BY country
HAVING SUM(score) > 800

    /* Find the average score for each country
    considering only customers with a score not equal to 0
    and return only those countries with an average score greater than 430
    */

SELECT 
    country,
    AVG(score) as avg_score
FROM
    customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

    -- DISTINCT
    -- Return Unique list of all countries

SELECT DISTINCT
    country
FROM customers

-- TOP/LIMIT
-- TOP 3 with the highest scores

SELECT TOP 3
*
FROM customers
ORDER BY score desc

-- Retrieve the lowest 2 customers based on score
SELECT TOP 2
*
FROM customers
ORDER BY score asc

-- TWO most recent orders
SELECT TOP 2
*
FROM orders
ORDER BY order_date desc