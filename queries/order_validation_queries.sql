--- Total constraint checks

/*  Rule: total must not be NULL
	Test: detect missing total values 
	Impact: payment cannot be processed, further calculations will result in error */
SELECT *
FROM orders
WHERE total IS NULL;

/*  Rule: total must not be negative; 0 is a valid boundary value
	Test: detect records with values of 0
	Impact: incorrect handling of 0 creates errors in further calculations */
SELECT *
FROM orders
WHERE total = 0;

/*  Rule: total must not be negative; 0 is a valid boundary value
	Test: detect values less than 0
	Impact: financial data integrity is broken */
SELECT *
FROM orders
WHERE total < 0;

/*  Rule: total must be <= 9999999
	Test: detect values that exceed 9999999
	Impact: financial calculations, reporting, or UI display may break due to overflow or rendering limits */
SELECT *
FROM orders
WHERE total > 9999999;
