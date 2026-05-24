-- Username constraint checks

/*Rule: username must not be NULL
  Test: detect missing username values
  Impact: user identity is broken; system cannot reliably display, reference, or differentiate users in UI, logs, or business processes */
SELECT *
FROM users
WHERE username IS NULL;

/*  Rule: username must not be an empty string
	Test: detect empty username values
	Impact: user identity is broken; system cannot reliably display, reference, or differentiate users in UI, logs, or business processes */
SELECT *
FROM users
WHERE username = '';

/*  Rule: username must not be a sequence of spaces
	Test: detect usernames that contain one or multiple spaces in a row
	Impact: user identity is broken; system cannot reliably display, reference, or differentiate users in UI, logs, or business processes */
SELECT *
FROM users
WHERE username LIKE '% %';

/*  Rule: username must be less than 41 characters long
	Test: detect values that are longer than 40 characters
	Impact: UI layout is broken, data is displayed incorrectly */
SELECT *
FROM users
WHERE LENGTH(username) > 40;

-- Email constraint checks

/*  Rule: email must not be NULL 
	Test: detect missing email values
	Impact: users cannot be contacted */
SELECT *
FROM users
WHERE email IS NULL;

/*  Rule: email must not be empty
	Test: detect empty email values 
	Impact: users cannot be contacted */
SELECT *
FROM users
WHERE email = '';

/*  Rule: email must not be a sequence of spaces
	Test: detect emails that contain one or more consecutive spaces
	Impact: communtcation failure */
SELECT *
FROM users
WHERE email LIKE '% %';

/*  Rule: email must not contain leading/trailing spaces
	Test: detect email values that have leading/trailing spaces
	Impact: users cannot be contacted */
SELECT *
FROM users
WHERE email <> TRIM(email)
OR email LIKE '%  %';

/*  Rule: email must be unique
	Test: detect duplicate email values
	Impact: users could have authentication and communication issues */
SELECT email, COUNT(id)
FROM users
GROUP BY email
HAVING COUNT(id) > 1;

/*  Rule: email should follow email formatting rules: test@test
	Test: detect values that do not contain either @, text before @, or text after @
	Impact: communication failures */
SELECT *
FROM users
WHERE email NOT LIKE '%@%';

/*  Rule: email should follow email formatting rules: test@test
	Test: detect values that contain more than one @
	Impact: users could not be contacted */
SELECT *
FROM users 
WHERE email LIKE '%@%@%';
