-- CHAPTER 4: DML Commands - Modify(Manipulate) your data
SELECT * FROM customers

/* INSERT 
1. Manual Entry(VALUES) 
If no columns are specified, SQL expects values for all columns
NB: Match the umber of columns and values*/

INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6,'Anna', 'USA', NULL),
	(7,'Sam', NULL, 100)
	-- you can skip the columns if you insert values for every column, just list it for clarity
INSERT INTO customers 
VALUES 
	(9,'Andreas', 'Germany', NULL)
	-- Add few columns eg two - the columns not inserted will be NULL unless a default or constraint exists
INSERT INTO customers (id, first_name)
VALUES 
	(10,'Sarah') -- you can't skip columns that aere not NULL

/* 2. Using SELECT - Moving data from one table to another
Copy data from 'customers' table into 'persons'*/

INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
	id,
	first_name,
	NULL,         -- since we don't have 'birth_date' in customers table and we need that column, it's a NULL
	'Unknown'     -- since we don't have 'phone' in customers and it's a NOT NULL so we say unknown
FROM customers

SELECT * FROM persons

/* UPDATE - change the content of the already existing rows
Change the score of customer with ID 6 to 0*/

UPDATE customers
	SET score = 0 
	WHERE id = 6     -- without a WHERE, all rows will be updated

SELECT * FROM customers WHERE id = 6

-- Change the score of customer 10 to 0 and update the country to UK

UPDATE customers
	SET score = 0,
		country = 'UK'
	WHERE id = 10

SELECT * FROM customers WHERE id = 10

-- UPDATE all customers with a NULL score by setting their score to 0

UPDATE customers
	SET score = 0
	WHERE score IS NULL

-- 