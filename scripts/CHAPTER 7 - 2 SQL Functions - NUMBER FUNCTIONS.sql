-- CHAPTER 7 - 2: SQL Functions - NUMBER FUNCTIONS

	 -- i. ROUND - Its replaces the numbers rounded to 0 (Value, dp) 
SELECT 
3.516 AS value,
ROUND(3.516, 2) AS round_2,
ROUND(3.516, 1) AS round_1,
ROUND(3.516, 0) AS round_0

	 -- ii. ABS - Returns the ABSOLUTE(positive) value of a number, removing any negative sign
	 -- (Value, dp) IN SHORT converting a negative number to positive

SELECT 
-10,
ABS(-10),
ABS(10)
