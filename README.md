# SQL Data Validation Project

---

## Project Overview
---
This repository contains data validation exercises in SQL, created as a part of QA practice.

This project focuses on validating data integrity, business rules, and cross-table consistency using SQL queries.

The goal of this project is to demonstrate practical understanding of:

- Writing SQL validation queries
- Data validation
- Database testing

---
## Project scope

- User validation
- Email validation
- Order totals
- Cross-table integrity
- Business rule adherence

---
## Repository structure

```
/sql-data-validation-project
|
├── datasets
|   ├── sample_test_data.sql
├── findings
|   └── findings_report.md
├── queries
|	├── business_logic_queries.sql
|	├── cross_table_validation_queries.sql
|	├── order_validation_queries.sql
|	├── payment_validation_queries.sql
|   └── user_validation_queries.sql
├── schema
|   └── schema.sql
└── validation-checklists
|	└── data_validation_checklists.md
|
README.md  

```

The schema and datasets folders contain SQL files for creating and populating the test dataset.

The queries folder contains SQL validation checks grouped by validation area.

The validation-checklists folder contains documented validation rules and testing scope.

The findings folder contains reports of issues discovered during validation.
---

## Validation techniques used

- Boundary value analysis
- Equivalence partitioning
- Positive testing
- Negative testing
---

## Dataset description

- Users: table contains records of ids, usernames and emails.
- Orders: table contains records of order ids, user ids, and order totals
- Payments: contains records of payment ids, order ids, payment amounts and payment status

Dataset intentionally contains both valid and corrupted records

---
## Example query

Example query used to detect duplicate email values:

```sql
SELECT email, COUNT(id)
FROM users
GROUP BY email
HAVING COUNT(id) > 1;
```

---
## Key learning outcomes

During this project I've practiced:

- Applying QA thinking to database testing
- Writing SQL queries for data validation and integrity checks
- Validating relational data across multiple tables
- Detecting invalid, missing, or inconsistent data 
- Documenting validation rules and discovered issues clearly
- Organizing SQL checks and findings in a structured GitHub repository
- Understanding how invalid data can affect application behavior, reporting, and business processes

---
## Author

Natalia

Aspiring QA Engineer focused on manual testing and test automation fundamentals.
