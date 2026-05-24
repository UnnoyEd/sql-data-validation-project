
/*  Rule: every order must be linked to one payment record
	Test: detect order records that do not have a corresponding payment record 
	Impact: missing payment records may cause incorrect financial reporting and inconsistent order processing */
SELECT *
FROM orders
LEFT JOIN payments ON payments.order_id = orders.id
WHERE payments.id IS NULL;

/*  Rule: users may have no orders linked  
	Test: detect users that weren't referenced an any order records 
	Impact: useful for business analysis, customer activity tracking, and identifying inactive users */
SELECT *
FROM users
LEFT JOIN orders ON users.id = orders.user_id
WHERE orders.id IS NULL;
