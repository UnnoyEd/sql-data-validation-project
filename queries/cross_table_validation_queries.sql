
/*  Rule: every order must reference an existing user
	Test: detect user ids that do not exist in users table
	Impact: orders cannot be reliably linked to users, causing broken user history, reporting inconsistencies, and incorrect business processing */
SELECT *
FROM orders
LEFT JOIN users ON users.id = orders.user_id
WHERE users.id IS NULL;

/*  Rule: every payment must reference an existing order
	Test: detect payments with order id that do not exist in orders table
	Impact: payments cannot be linked to orders, causing broken order history and incorrect business processing */
SELECT *
FROM payments
LEFT JOIN orders ON payments.order_id = orders.id
WHERE orders.id IS NULL;

/*  Rule: payment amount must be equal to order total
	Test: detect all payments with amount different from order total
	Impact: financial data integrity is broken; reporting, payment reconciliation, and order processing may contain errors */
SELECT *
FROM payments
LEFT JOIN orders ON payments.order_id = orders.id
WHERE payments.amount != orders.total;

/*  Rule: each order must have only one payment record
	Test: detect orders linked to several payment records
	Impact: duplicate payment records may cause incorrect financial reporting, duplicate charges, and inconsistent order processing */
SELECT order_id, COUNT(payments.id)
FROM payments
LEFT JOIN orders ON payments.order_id = orders.id
GROUP BY order_id
HAVING COUNT(payments.id) > 1;
