-- CHAPTER 6 - 1: Joining Data 
/* Combine Table A & B: Columns - JOINS
						Rows - SET Operators
Types of JOINS: Inner, Full, Left, Right  -> Requirement is a 'Key Column'
Types of SET: UNION, UNION ALL, EXCEPT(minus), INTERSECT  -> Requirement is a 'Same Columns'*/

/* What is SQL JOINS?
 When to use SQL JOINS? 
	1. Recombine data - big picture eg. INNER, LEFT, FULL
	2. Data Enrichment - getting extra data(Extract info) eg. LEFT
	3. Check for existence(Filtering) - look up, not combining eg. INNER, LEFT + WHERE, FULL + WHERE*/

-- JOINS TYPES
-- i. BASICS

/*1. NO JOIN - Returns data from Tables without combining them (Two results: All rows from A and B)
	"SELECT * FROM A;" and "SELECT * FROM B;" */

-- Retrieve all data from customers and orders in two different results
SELECT * FROM customers;
SELECT * FROM orders;

/*2. INNER JOIN - Returns ONLY MATCHING rows from both tables (the overlapping part)
"SELECT * FROM A INNER(default) JOIN B ON <condition>;"
ON - How to combine the tables(common column to match rows)
<condition> -> A.key = B.key
NB: Order of Tables - for INNER JOIN, it doesn't matter*/ 

-- Get all customers along with their orders, but only for customers who have placed an order
SELECT
	id,
	first_name,
	order_id,
	sales      -- column ambiguity ie id in both orders and customer table -> orders.id and customers.id
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

/*3. LEFT JOIN - Returns ALL rows(Everything - A: Primary source of Data) from LEFT 
and ONLY MATCHING rows from RIGHT table(B: Secondary needed additional data)
"SELECT * FROM A(left) LEFT JOIN B(right) ON A.key = B.key;"
NB: Order of Tables does matter*/

-- Get all customers along with their orders, including those without orders
SELECT
	id,
	first_name,
	order_id,
	sales
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;

-- Get all customers along with their orders, including orders without matching customers(from RIGHT)
SELECT
	id,
	first_name,
	order_id,
	sales
FROM orders
LEFT JOIN customers
ON customers.id = orders.customer_id;

/*4. RIGHT JOIN - ALL rows(Everything - B: Primary source of Data) from RIGHT 
and ONLY MATCHING rows from LEFT table(A: Secondary needed additional data)
"SELECT * FROM A RIGHT JOIN B ON A.key = B.key;"
NB: Order of Tables does matter*/

-- Get all customers along with their orders, including orders without matching customers
SELECT
	id,
	first_name,
	order_id,
	sales
FROM customers
RIGHT JOIN orders
ON id = customer_id;

-- Get all customers along with their orders, including those without orders(from LEFT)
SELECT
	id,
	first_name,
	order_id,
	sales
FROM orders
RIGHT JOIN customers
ON customers.id = orders.customer_id;

/*5. FULL JOIN - Returns ALL rows(everything) from BOTH tables 
"SELECT * FROM A FULL JOIN B ON A.key = B.key;"
NB: Order of Tables doesn't matter*/

-- Get all customers and all orders, even if there's no match
SELECT
	id,
	first_name,
	order_id,
	sales
FROM customers
FULL JOIN orders
ON customers.id = orders.customer_id;

-- ii. ADVANCED

/*1. LEFT ANTI JOIN - Returns row from the LEFT that has NO MATCH in RIGHT
only unmatching rows - data that exists in A(Primary) but don't exists in B(Look-up{filter})
"SELECT * FROM A LEFT JOIN B ON A.key = B.key WHERE B.key IS NULL;"
NB: Order of Tables does matter*/

--Get all customers who haven't placed any order
SELECT 
	id,
	first_name,
	order_id,
	sales 
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id 
WHERE o.customer_id IS NULL;

--Get all order without matching customers
SELECT 
	id,
	first_name,
	order_id,
	sales 
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id 
WHERE c.id IS NULL;

/*2. RIGHT ANTI JOIN - Returns row from the RIGHT that has NO MATCH in LEFT
only unmatching rows - data that exists in B(Primary) but don't exists in A(Look-up{filter})
"SELECT * FROM A RIGHT JOIN B ON A.key = B.key WHERE A.key IS NULL;"
NB: Order of Tables does matter*/

--Get all order without matching customers
SELECT 
	id,
	first_name,
	order_id,
	sales 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id 
WHERE c.id IS NULL;

/*3. FULL ANTI JOIN - Returns ONLY rows that DON'T MATCH in either tables (only unmatching data)
"SELECT * FROM A FULL JOIN B ON A.key = B.key WHERE A.key IS NULL OR B.key IS NULL;"*/

-- Find customers without orders and orders without customers
SELECT 
	id,
	first_name,
	order_id,
	sales 
FROM customers AS c
FULL JOIN orders AS o
ON c.id =  o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

--EXERCISE
-- Get all customers along with their orders, but only for customers who have placed an order(Without using an INNER JOIN)
SELECT 
	*
FROM customers AS c
INNER JOIN orders AS o
ON c.id =  o.customer_id -- using an INNER JOIN

SELECT 
	*
FROM customers AS c
LEFT JOIN orders AS o
ON c.id =  o.customer_id
WHERE o.customer_id IS NOT NULL -- Without using an INNER JOIN

/*3. CROSS JOIN - Combines EVERY row from LEFT with EVERY row from RIGHT
All possible combinations - Cartersian Join -
"SELECT * FROM A CROSS JOIN B;
NO RULES"*/

-- Generate all possible combinations of customers and orders
SELECT 
	* 
FROM customers 
CROSS JOIN orders;


/* How to choose between JOINS TYPES???
1. Only matching - INNER
2. All rows: 
			One side(Master Table) - LEFT
			Both sides(Both Important) - FULL
3. Only Unmatching: 
			One side(Master Table) - LEFT ANTI
			Both sides(Both Important) - FULL ANTI
RIGHT - you can choose in palece of LEFT


 Multi - Table Join
1. Master Table A(starting) SELECT FROM A
2. Table B					LEFT B ON ...
3. Table C					LEFT C ON ...
4. Table D					LEFT D ON ...
WHERE control what to keep(eg. matching or unmatching)

Eg. Only Matching - INNER B ON INNER C ON ...*/


/* EXERCISE: Multi Joins

Using SalesDB, retrieve a list of all orders, along with 
the related customer, product and employee details
For each order, display:
- Order ID
- Customer's name
- Product name
- Sales amount
- Product price
- Salesperson's name */

USE SalesDB

SELECT * FROM Sales.Orders
SELECT * FROM Sales.Customers
SELECT * FROM Sales.Products
SELECT * FROM Sales.Employees
SELECT * FROM Sales.OrdersArchive

SELECT 
	o.OrderID, 
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	o.Sales,
	p.Product AS ProductName,
	p.Price,
	e.FirstName AS EmployeeFirstName,
	e.LastName AS EmployeeLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID = P.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = e.EmployeeID