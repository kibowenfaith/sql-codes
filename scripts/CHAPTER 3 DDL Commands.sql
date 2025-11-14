-- CHAPTER 3: DDL Commands - CREATE, DROP & DELETE we are defining the database
/* CREATE  
Create a new table called persons with columns: 
id, person_name, birth_date and phone */

CREATE TABLE persons(
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)     -- setting primary key
)

SELECT * FROM persons

/* ALTER - (Edit)
Add a new column called email to the persons table */

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL  -- New columns are appended at the end of table by default

-- Remove the column phone from persons table

ALTER TABLE persons
DROP COLUMN phone

/* DROP 
Delete the table persons from the database */

DROP TABLE persons