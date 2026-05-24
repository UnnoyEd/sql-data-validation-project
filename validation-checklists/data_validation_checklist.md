# Data validation checklists

---
## User validation

### Username
**Rules:**
- Not NULL
- Not '' (empty value)
- Does not contain ' ' (space)
- No more than 40 characters

## Email
**Rules:**
- Not NULL
- Not '' (empty value)
- Does not contain ' ' (space)
- Must be unique
- Shouldn't contain leading / trailing spaces
- Format must look like 'text@text'

---
## Order validation

### Total
**Rules:**
- Not NULL
- Must be >= 0

---
## Payment validation

### Amount
**Rules:**
- Not NULL
- Must be >= 0
- Must be <= 9999999

### Status
**Rules:**
- Must be either 'PAID' or 'FAILED'
- Status values should be treated case-insensitively (e.g. paid = PAID)

---
## Cross-table consistency

**Rules:**
- Orders have user_id that exist in users table
- Payments have order_id that exist in orders table
- 1 payment record for 1 order record
- Payment amount should be equal to order total

---
## Business logic validation

**Rules:**
- Every order should have a payment record
- Users may have no orders
