--- Payment status constraint checks

/*  Rule: payment status must be either 'PAID' or 'FAILED'
	Test: detect values that contain different text
	Impact: payment processing, reporting, and downstream financial calculations may produce incorrect results due to invalid status values */
SELECT *
FROM payments
WHERE UPPER(status) NOT IN ('PAID', 'FAILED');

/*  Rule: payment status must not be NULL
	Test: detect missing status values
	Impact: further processing and calculations are broken */
SELECT *
FROM payments
WHERE status IS NULL;
