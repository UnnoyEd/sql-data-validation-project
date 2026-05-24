-- Simple e-commerce style schema for SQL QA practice
-- Constraints are minimized intentionally to allow invalid test data scenarios


-- Stores registered application users
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  username TEXT,
  email TEXT
 );
 
-- Stores customer orders
-- Each order should belong to a valid user
  CREATE TABLE orders (
 	id INTEGER PRIMARY KEY,
   	user_id INTEGER,
    total REAL
 );
 
 -- Stores payment information for orders
 -- Each payment should reference a valid order
  CREATE TABLE payments (
    id INTEGER PRIMARY KEY,
    order_id INTEGER,
    amount REAL,
    status TEXT
);
