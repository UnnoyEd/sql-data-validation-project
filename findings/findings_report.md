# Data validation findings

---

## 1. Users table findings

### Username issues

#### Finding: NULL usernames
- Severity: High
- Description: Users exist without a username value
- Impact: Identity resolution broken across system

```sql
SELECT *
FROM users
WHERE username IS NULL;
```

---

#### Finding: Empty username
- Severity: High
- Description: Username stored as empty string
- Impact: Cannot reliably display or identify user

```sql
SELECT *
FROM users
WHERE username = '';
```

---

### 1.2 Email issues

#### Finding: NULL emails
- Severity: High
- Description: Missing email values
- Impact: Users cannot be contacted

```sql
SELECT *
FROM users
WHERE email IS NULL;
```

---

#### Finding: Empty email
- Severity: High
- Description: Email stored as an empty string
- Impact: Users cannot be contacted

```sql
SELECT *
FROM users
WHERE email IS '';
```

---

- Severity: High
- Description: Email stored with leading/trailing spaces
- Impact: Users cannot be contacted 

```sql
SELECT *
FROM users
WHERE email <> TRIM(email)
OR email LIKE '%  %';
``` 

---

#### Finding: Duplicate emails
- Severity: High
- Description: Same email used by multiple users
- Impact: Authentication and identity conflicts

```sql
SELECT email, COUNT(id)
FROM users
GROUP BY email
HAVING COUNT(id) > 1;
```

---

#### Finding: Invalid email format
- Severity: Medium
- Description: Email missing @ or incorrectly formatted
- Impact: Communication failures

```sql
SELECT *
FROM users
WHERE email NOT LIKE '%@%';
```

```sql
SELECT *
FROM users 
WHERE email LIKE '%@%@%'
```

---

## 2. Order Table Findings

### 2.1 Total issues

#### Finding: NULL order totals
- Severity: High
- Description: Orders without total value
- Impact: Payment and reporting failures

```sql
SELECT *
FROM orders
WHERE total IS NULL;
```

---

#### Finding: Negative order totals
- Severity: High
- Description: Orders with negative amounts
- Impact: Financial data corruption

```sql
SELECT *
FROM orders
WHERE total < 0;
```

---

#### Finding: Zero-value orders (edge cases)
- Severity: Low / Informational
- Description: Orders with total = 0
- Impact: May represent free orders or invalid input depending on business rules

```sql
SELECT *
FROM orders
WHERE total = 0;
```

---

#### Finding: Large number order totals
- Severity: High
- Description: Order with total > 9999999
- Impact: Financial data corruption and UI issues

```sql
SELECT *
FROM orders
WHERE total > 9999999
```
---

## 3. Payment Table Findings

### 3.1 Status issues

#### Finding: Invalid payment status
- Severity: High
- Description: Status outside allowed values (PAID/FAILED)
- Impact: Payment processing logic may break

```sql
SELECT *
FROM payments
WHERE UPPER(status) NOT IN ('PAID', 'FAILED');
```

---

#### Finding: NULL payment status
- Severity: High
- Description: Missing payment state
- Impact: Cannot determine transaction outcome

```sql
SELECT *
FROM payments
WHERE status IS NULL;
```

---


## 4. Cross-table integrity findings

#### Finding: Orders without users

- Severity: Critical
- Description: Orders referencing non-existent users
- Impact: Broken user-order relationships

```sql
SELECT *
FROM orders
LEFT JOIN users ON orders.user_id = users.id
WHERE users.id IS NULL;
```

---

#### Finding: Payments without orders

- Severity: Critical
- Description: Payments referencing missing orders
- Impact: Orphaned financial records

```sql
SELECT *
FROM payments
LEFT JOIN orders ON payments.order_id = orders.id
WHERE orders.id IS NULL;
```

---

#### Finding: Payment ≠ Order total mismatch

- Severity: High
- Description: Payment amount differs from order total
- Impact: Financial reconciliation errors

```sql
SELECT *
FROM payments 
JOIN orders  ON payments.order_id = orders.id
WHERE payments.amount != orders.total;
```

---

#### Finding: Duplicate payment records

- Severity: Critical
- Description: Duplicate payment records referring to a single order
- Impact: Incorrect financial reporting, double charges

```sql
SELECT order_id, COUNT(payments.id)
FROM payments
LEFT JOIN orders ON payments.order_id = orders.id
GROUP BY order_id
HAVING COUNT(payments.id) > 1;
```

---


## 5. Business logic findings


#### Finding: Orders without payments

- Severity: Critical
- Description: Orders without payment records
- Impact: Inconsistent order processing

```sql
SELECT *
FROM orders
LEFT JOIN payments ON payments.order_id = orders.id
WHERE payments.id IS NULL;
```

#### Finding:  Users without orders

- Severity: Informational
- Description: Users with no activity
- Impact: Useful for business analysis (inactive users)

```sql
SELECT *
FROM users
LEFT JOIN orders ON users.id = orders.user_id
WHERE orders.id IS NULL;
```
--- 


## 6. Summary

### Key issues found:
- Data integrity violations (FK issues)
- Financial inconsistencies
- Invalid user data (NULL / empty / malformed fields)
- Business rule violations in payments
