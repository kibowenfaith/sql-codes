-- CHAPTER 7 - 3: SQL Functions - DATE & TIME FUNCTIONS
		-- Timestamp - date & time combined (oracle, postgress, MySQL) and DateTime2 (SQL Server)
		-- Format: Year - Month - Day  &  Hours - Minutes - Seconds
USE SalesDB

SELECT
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
FROM Sales.Orders

		-- VALUES
		-- 1. Date column from a table
SELECT
	OrderID,
	CreationTime
FROM Sales.Orders

		-- 2. Hardcoded constant string value
SELECT
	OrderID,
	CreationTime,
	'2025-08-20' HardCoded
FROM Sales.Orders

		-- 3. GETDATE() Function - Returns the current date and time at the momment when the query is executed.
SELECT
	OrderID,
	CreationTime,
	'2025-08-20' HardCoded,
	GETDATE() Today
FROM Sales.Orders

		-- Functions Overview
		/*1. Extract parts of the date eg. Year or Month or day
		  2. Change date format eg. 2025-08-20 to 08/20/25 or 20 Aug 2025
		  3. Date Calculations eg Add, Difference
		  4. Date Test or validation if its real date that SQL understands: False(0) and True(1) */

/* Date & Time Functions
		Part Extraction - DAY, MONTH, YEAR, DATEPART, DATENAME, DATETRUNC, EOMONTH
		Format & Casting - FORMAT, CONVERT, CAST
		Calculations - DATEADD, DATEDIFF
		Validation - ISDATE */

-- a). Part Extraction
	 -- i. DAY() - returns the day from a date
	 -- ii. MONTH() - returns the month from a date
	 -- iii. YEAR() - returns the year from a date
				-- syntax: DAY/MONTH/YEAR (date)
SELECT
MONTH('2025-08-20')

SELECT
	OrderID,
	CreationTime,
	YEAR(CreationTime) Year,
	MONTH(CreationTime) Month,
	DAY(CreationTime) Day
FROM Sales.Orders
		
	 -- iv. DATEPART() - returns a specific part of a date as a number, a week or a quarter
				-- syntax: DATEPART(part, date)  - OUTPUT IS INT
SELECT
	OrderID,
	CreationTime,
	DATEPART(year, CreationTime) Year_dp,
	DATEPART(month, CreationTime) Month_dp,
	DATEPART(day, CreationTime) Day_dp,
	DATEPART(hour, CreationTime) Hour_dp,
	DATEPART(quarter, CreationTime) Quarter_dp,
	DATEPART(week, CreationTime) week_dp
FROM Sales.Orders

	 -- v. DATENAME() - returns the name of a specific part of a date, August or Wednesday
				-- syntax: DATENAME(part, date)  - OUTPUT IS STRING
				-- To present easy to read and human readable information to the users eg instead of 1 = January
SELECT
	OrderID,
	CreationTime,
	DATENAME(month, CreationTime) Month_dn,
	DATENAME(weekday, CreationTime) weekday_dn,
	DATENAME(day, CreationTime) day_dn, -- its an INT but can be stored as a STRING
	DATENAME(year, CreationTime) Year_dn  -- its an INT but can be stored as a STRING
FROM Sales.Orders

	 -- v. DATETRUNC() - Truncate the date to the specific part
				-- syntax: DATETRUNC(part, date)  - OUTPUT IS INT
SELECT
	OrderID,
	CreationTime,
	DATETRUNC(minute, CreationTime) Minute_dt,
	DATETRUNC(day, CreationTime) day_dt, -- the day will be 1 since we don't have a 0 day
	DATETRUNC(month, CreationTime) Month_dt, -- the month will be 1 since we don't have a 0 month
	DATETRUNC(year, CreationTime) Year_dt
FROM Sales.Orders

				-- Importance
SELECT
	COUNT(*)
FROM Sales.Orders  -- the total number of orders received

SELECT
	CreationTime,
	COUNT(*)
FROM Sales.Orders
GROUP BY CreationTime  -- the number of orders without specifying from which month

SELECT
	DATETRUNC(month, CreationTime) creation,
	COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime)    -- The number of orders in each month

SELECT
	DATETRUNC(year, CreationTime) creation,
	COUNT(*)
FROM Sales.Orders
GROUP BY DATETRUNC(year, CreationTime)    -- This is for Year


	 -- vi. EOMONTH() - Returns the last day of a month (End Of the Month)
				-- Changes only the days to the last day of the month eg 31 or 28 or 30
				-- syntax: EOMONTH(date)  - OUTPUT IS INT
SELECT
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) EndOfMonth,
	CAST(DATETRUNC(month, CreationTime) AS DATE) StartOfMonth  -- CAST() to change the data type
FROM Sales.Orders

	-- Part Extraction Use Case
	  -- 1. Data Aggregations and Reporting - Sales by year or quater or month

	  -- How many orders were placed each year?
SELECT
	YEAR(OrderDate),
	COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)
     -- How many orders were placed each month
SELECT
	DATENAME(month, OrderDate) AS OrderDate,
	COUNT(*) NrOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)
     -- Show all orders that were placed during the month of February
SELECT
	*
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2
	/* BEST PRACTICE: Filtering data using an integer is faster than using a string
	                  Avoid using DATENAME for filtering data, instead use DATEPART */

	  -- 2. Functions Comparison 
	  /*			DAY, MONTH, YEAR, DATEPART = INT
				    DATENAME = STRING
					DATETRUNC = DATETIME
					EOMONTH = DATE
			i. Which Part I want to extract? 
							Day OR Month? 
								Numeric? - DAY(), MONTH()
								Full Name - DATENAME()
							Year? - YEAR()
							Other Parts? - DATEPART() */

	  -- 3. All Parts
	  -- * there is a sql query that shows all parts (date&time scripts)

-- b). Format & Casting
	 /* Format -> YYYY - MM - dd   HH : mm : ss
							International standard(ISO 8601): 2025-08-20  for SQL
							USA Standard: 08-20-2025
							European Standard: 20-08-2025
			  Formating - changing the format of a value from one to another, changing how the data/value looks
			               Eg. Date: FORMAT - 2025-08-20  ->  MM/dd/YY: 08/20/25
											                  MMM YYYY: Aug 2025
									 CONVERT - 2025-08-20  ->  6 - 20 Aug 2025
									                           112 - 20250820
							   Number: FORMAT - 1234567.89 -> N - 1,234,567.89
													 C - $ 1,234,567.89  Dollar sign
													 P - 123,456,789.00%  percentage
			  Casting - Change the data type from one to another
						Eg. (String) '123' -> 123 (Number)
						    (Date) 2025-08-20 -> '2025-08-20' ( String)
							(String) '2025-08-20' -> 2025-08-20 (Date)
					Casting can be done using CAST() or CONVERT() */

	 /* i. FORMAT() - Formats a date or time value
							Syntax: FORMAT(value, format [,culture])  culture is optional Default = 'en-US'
							    eg. FORMAT(OrderDate, 'dd/MM/yyyy')
								    FORMAT(OrderDate, 'dd/MM/yyyy', 'ja-JP')
									FORMAT(1234.56, 'D', 'fr-FR') */
SELECT
	OrderID,
	CreationTime,
	FORMAT(CreationTime, 'MM-dd-yyyy') USA_Format,
	FORMAT(CreationTime, 'dd-MM-yyyy') EURO_Format,
	FORMAT(CreationTime, 'dd') dd, -- the day eg 01, 05
	FORMAT(CreationTime, 'ddd') ddd, -- eg. Wed
	FORMAT(CreationTime, 'dddd') dddd,  -- full name of the dat WEdnesday
	FORMAT(CreationTime, 'MM') MM,  -- the Month eg 01, 05
	FORMAT(CreationTime, 'MMM') MMM,  -- eg. Jan, Feb
	FORMAT(CreationTime, 'MMMM') MMMM  -- full name of the month, January
FROM Sales.Orders
			--Show CreationTime using the following format: Day Wed Jan Q1 2025 12:34:56 PM
SELECT
	OrderID,
	CreationTime,
	'Day' + FORMAT(CreationTime, 'ddd MMM') + 
	' Q' + DATENAME(quarter, CreationTime) + ' ' +
	FORMAT(CreationTime, 'yyyy hh:mm:ss tt') AS CustomerFormat  -- hh for 12hrs and HH for 24hrs
FROM Sales.Orders
			-- USE CASE
			/* Data Aggregations - Format the date before doing aggregation
					report of sales by month eg Feb 2025 */
SELECT
	FORMAT(OrderDate, 'MMM YY') OrderDate,
	COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM YY')
			-- Data Standardization - Format the incoming data into one standard fromat cause it comes in different formats

	 /* ii. CONVERT() - Converts a date or time value to a different data type & Format also the value
								Syntax: CONVERT(data_type, value[, style]) style is optional
								   eg. CONVERT(INT, '124')
								       CONVERT(VARCHAR, OrderDate, '34') default value for style is 0*/
SELECT
CONVERT(INT, '123') AS [String to Int CONVERT],
CONVERT(DATE, '2025-08-20') AS [String to Date CONVERT],
CreationTime,
CONVERT(DATE, CreationTime) AS [DateTime to Date CONVERT]
FROM Sales.Orders

SELECT
CreationTime,
CONVERT(DATE, CreationTime) AS [DateTime to Date CONVERT],
CONVERT(VARCHAR, CreationTime, 32) AS [USA Std. Style:32],
CONVERT(VARCHAR, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders

	 /* iii. CAST() - Converts a value to a specified data type
	                     Syntax: CAST(value AS data_type)
						    eg. CAST('123' AS INT)
							    CAST('2025-08-20' AS DATE)*/
SELECT
CAST('123' AS INT) AS [String to Int],
CAST('123' AS VARCHAR) AS [Int to String],
CAST('2025-08-20' AS DATE) AS [String to Date],
CAST('2025-08-20' AS DATETIME2) AS [String to DateTime],
CreationTime,
CAST(CreationTime AS DATE) AS [Datetime to Date]
FROM Sales.Orders

    /* CAST vs CONVERT vs FORMAT
	Casting:
			CAST Anytype to Anytype, CONVERT Anytype to Anytype, FORMAT Anytype to Only String
	Formating: 
			CAST No formating, CONVERT Formats only DATE & TIME, FORMAT Formats the DATE&TIME as well as Numbers

-- c). Calculations
	 /* i. DATEADD() - Adds or subtracts a specific time interval to/from a date.
	                     2025-08-20 -> 2028-08-20(+3yrs)/2025-10-20(+2months)/2025-08-25(+5days)
						               2022-08-20(-3yrs)/2025-06-20(-2months)/2025-08-15(-5days)*/
								Syntax: DATEADD(part, interval, date)
								    eg. DATEADD(year, 2, OrderDate)
									    DATEADD(month, -4, OrderDate)*/
SELECT
OrderID,
OrderDate,
DATEADD(day, -10, OrderDate) AS TenDaysBefore,
DATEADD(month, 3, OrderDate) AS TwoMonthsLater,
DATEADD(year, 2, OrderDate) AS TwoYearsLater
FROM Sales.Orders

	 /* ii. DATEDIFF() - Find the difference between two dates
	                     2025-08-20 DATEDIFF 2026-02-01 = YEAR(1), MONTH(3), DAY(68)
	                          Syntax: DATEDIFF(part, start_date, end_date)
							      eg. DATEDIFF(year, OrderDate, ShipDate)
								      DATEDIFF(day, OrderDate, ShipDate) */
        -- Calculate the age of employees
SELECT
FirstName,
BirthDate,
DATEDIFF(year, BirthDate, GETDATE()) AS Age  -- CURRENT_TIMESTAMP/ GETDATE() - To get now current dates
FROM Sales.Employees

        -- Find the average shipping duration in days for each month
SELECT
MONTH(OrderDate) AS OrderDate,
AVG(DATEDIFF(day, OrderDate, ShipDate)) AS AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

        -- Find the number of days between each order and the previous order(TIME GAP ANALYSIS)
SELECT
OrderID,
OrderDate CurrentOrderDate,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousOrderDate,   -- access the value from the previous records
DATEDIFF(day, LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate)
FROM Sales.Orders

-- D). Validation
	 /* i. ISDATE() - check if a value is a date. Returns 1 if the string value is a valid date, or 0 if it's not valid.
								Syntax: ISADATE(value)
								    eg. ISDATE('2025-08-20') = 1
									    ISDATE(2025) = 1 */
SELECT 
ISDATE('123') DateCheck1,   -- = 0
ISDATE('2025-08-20') DateCheck2,  -- =1
ISDATE('20-08-2025') DateCheck3,  -- =0
ISDATE('2025') DateCheck4,   -- =1
ISDATE('08') DateCheck5  -- =0

SELECT
	--CAST(OrderDate AS DATE) OrderDate,
	OrderDate,
	ISDATE(OrderDate),
	CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
			ELSE '9999-01-01'
	END NewOrderDate
FROM
(
	SELECT '2025-08-20' AS OrderDate UNION
	SELECT '2025-08-21' UNION
	SELECT '2025-08-23' UNION
	SELECT '2025-08'    -- data quality problem
)t
WHERE ISDATE(OrderDate) = 0