INSERT INTO users (id, username, email) VALUES
 (1, 'Natalia', 'natalia@test.com'),
 (2, 'John', 'JOhn@test.com'),
 (3, 'Peeta_222', ' peeta@test.com '),
 (4, 'Ashton', 'ash@test.com'),
 (5, 'Ash', 'ash@test.com'),
 (6, 'nightmare1544', ''),
 (7, 'Veronica', 'veratest.com'),
 (8, 'BarbieGirlll', NULL),
 (9, '', 'indie@test.com'),
 (10, NULL, 'kittycat@test.com');
 
 
INSERT INTO orders (id, user_id, total) VALUES
 (1, 1, 120.50),
 (2, 1, 45.00),
 (3, 2, 300.99),
 (4, 8, 1),
 (5, 4, 0),
 (6, NULL, 5000000000000),
 (7, 6, NULL),
 (8, 8, -1),
 (9, 3, -50.00),
 (10, 14, 15.52);


INSERT INTO payments (id, order_id, amount, status) VALUES
 (1, 1, 120.50, 'PAID'),
 (2, 2, 45.00, 'FAILED'),
 (3, 3, 300.99, 'PAID'),
 (4, 5, 13, 'PAID'),
 (5, NULL, 30.9, 'PAID'),
 (6, 9, 1, 'CoRRUp+Ed'),
 (7, 4, -50.00, 'FAILED'),
 (8, 6, 0, NULL),
 (9, 7, 5000000000000, ''),
 (10, 13, 300.99, 'PAID');
