-- CHAPTER 6 - 2: SET Operators - same column
-- SYNTAX AND RULES
/* 1. SQL Clauses - SET Operators can be used almost in all clauses
WHERE | JOIN | GROUP BY | HAVING
ORDER BY is allowed only once at the end of query
 Syntax:
	SELECT FirstName, LastName FROM Customers JOIN Clause WHERE Clause GROUP BY Clause
	UNION -- SET Operator
	SELECT FirstName, LastName FROM Employees JOIN Clause WHERE Clause GROUP BY Clause
ORDER BY FirstName  -- can be used only at the end to sort the final result*/

-- 2. Number of columns - They must be the same in each query
USE SalesDB

SELECT 
	FirstName, 
	LastName 
FROM Sales.Customers

UNION

SELECT 
	FirstName, 
	LastName 
FROM Sales.Employees

-- 3. Data Types - DT of columns in each query must be compatible eg VARACHAR(50)

SELECT CustomerID, LastName FROM Sales.Customers 
UNION  -- error: converting the varchar value 'Frank' to data type int.
SELECT FirstName, LastName FROM Sales.Employees  -- FirstName should be EmployeeID

-- 4. Order of Columns - The order in each query must be the same

SELECT LastName, CustomerID FROM Sales.Customers 
UNION
SELECT EmployeeID, LastName FROM Sales.Employees -- error

-- 5. Column Aliases - The column names in the result set are determined by column names specified in the firts query

SELECT CustomerID AS ID, LastName  FROM Sales.Customers   -- 1st query controls column names
UNION
SELECT EmployeeID, LastName FROM Sales.Employees  -- ignored

/* 6. Correct Columns - Even if all rules are met and SQL shows no errors, 
  the results maybe incorrect
- Incorect column selection leads to inaccurate results*/

SELECT FirstName, LastName  FROM Sales.Customers   
UNION
SELECT LastName, FirstName FROM Sales.Employees -- INCORRECT

/* 1. UNION - Returns all distinct rows from both queries(combine everything)
			- Removes duplicate rows from the result */

-- Combine the data from employees and customers into one table

SELECT * FROM Sales.Customers      
SELECT * FROM Sales.Employees

SELECT 
	FirstName, 
	LastName
FROM Sales.Customers
UNION
SELECT
	FirstName, 
	LastName
FROM Sales.Employees

/* 2. UNION ALL - Returns all rows from both queries, including duplicates
	  NB: UNION ALL is generally faster than UNION 
		  If you're confident there are no duplicates, use UNION ALL
		  Use UNION ALL to find duplicates and quality issues*/

-- Combine the data from employees and customers into one table including duplicates
SELECT 
	FirstName, 
	LastName
FROM Sales.Customers
UNION ALL
SELECT
	FirstName, 
	LastName
FROM Sales.Employees

/* 3. EXCEPT(minus) - Returns all distinct rows from the first query that are not found in the second query
			- it is the only one where the order of queries affects the final results 
			Removes duplicate */

-- Find the employees who are not customers at the same time
SELECT 
	FirstName, 
	LastName
FROM Sales.Employees  -- CHECK THE ORDER OF QUERY
EXCEPT
SELECT
	FirstName, 
	LastName
FROM Sales.Customers -- LOOK UP


/* 4. INTERSECT - Returns only the rows that are COMMON in both queries
			- Removes duplicate rows from the result */

-- Find the employees whore are also customers
SELECT 
	FirstName, 
	LastName
FROM Sales.Employees
INTERSECT
SELECT
	FirstName, 
	LastName
FROM Sales.Customers

-- UNION USE CASES
/*  ->Combine Information - combine similar information before analyzing the data
							instead of writing FOUR SQL queries, you write only ONE after UNION*/

-- Orders are stored in seperate tables(Orders and OrdersArchive)
-- Combine all orders data into one report without duplicates

SELECT * FROM Sales.Orders      
SELECT * FROM Sales.OrdersArchive
-- *BEST PRACTICES: Never use (*) to combine tables, list neede columns instead
-- we might change the schema of the table orders, rename stuff, add a new column or switch the columns
-- more clear
-- SOURCE FLAG: Include additional column to indicate the source of each row
SELECT 
'Orders' AS SourceTable,   -- SOURCE FLAG 
	   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT
'OrdersArchive' AS SourceTable,  -- SOURCE FLAG
	   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID  -- order source table

-- EXCEPT USE CASES
/* 1.->Delta Detection - Identifying the differences or changes(delta) between two batches of data
DE builds data pipeline to load daily new data from source to data warehouse or data lake

   2.->Data Completeness Check - To compare tables to detect discrepancies between databases.(data quality)
   check for data that is still in DB A that hasn't maigrated to DB B = Empty result and VICE VERSA */

-- SUMMARY
/*
Combine the results of multiple queries into a single result set
Types: UNION | UNION ALL | EXCEPT | INTERSECT
Rules: Same no. of columns, data types, otder of columns
	   1st query controls column names
Use Cases: Combine information(UNION + UNION ALL)
		   Delta Detection (EXCEPT)
		   Data Completeness Check (EXCEPT)
		   Apply EXCEPT in your logic as a DE in your data pipeline in order 
		   to identify what are the new data that must be inserted in your system */