--Part I
-- 1. Create a Customer table with: id, first_name, and last_name (NOT NULL).
-- 2. Create a Customer_profile table with: id, isLoggedIn (default FALSE), and customer_id as a UNIQUE foreign key to Customer.
-- 3. Insert the following customers: John Doe, Jerome Lalu, and Lea Rive.
-- 4. Insert the customer profiles using subqueries:
--    - John is logged in.
--    - Jerome is not logged in.
-- 5. Display the first names of customers who are logged in.
-- 6. Display the first names and login status of all customers, including those without a profile.
-- 7. Display the number of customers who are not logged in (including those without a profile).
CREATE TABLE customer (
id SERIAL PRIMARY KEY,
first_name VARCHAR (50),
last_name  VARCHAR (50) NOT NULL
);

CREATE TABLE customer_profile(
id SERIAL PRIMARY KEY,
isLoggedIn BOOLEAN DEFAULT FALSE,
customer_id INT UNIQUE REFERENCES customer(id)
);

INSERT INTO customer(first_name,last_name)
VALUES
('John', 'Doe'),
('Jerome', 'Lalu'),
('Lea', 'Rive');

INSERT INTO customer_profile(isLoggedIn, customer_id)
VALUES (TRUE, (SELECT id FROM customer WHERE first_name ='John'AND last_name ='Doe'));
INSERT INTO customer_profile(isLoggedIn, customer_id)
VALUES (FALSE,(SELECT id FROM customer WHERE first_name ='Jerome' AND last_name='Lalu'));

SELECT first_name 
FROM customer
JOIN customer_profile ON customer_profile.customer_id = customer.id
WHERE customer_profile.isLoggedIn = TRUE;

SELECT first_name, customer_profile.isLoggedIn
FROM customer
LEFT JOIN customer_profile ON customer_profile.customer_id = customer.id;

SELECT COUNT(*)
FROM customer
LEFT JOIN customer_profile ON customer_profile.customer_id = customer.id
WHERE customer_profile.isLoggedIn = FALSE OR customer_profile.isLoggedIn IS NULL;

--Part II
-- 1. Create a Book table with: book_id (SERIAL), title (NOT NULL), author (NOT NULL).
-- 2. Insert the following books: Alice In Wonderland, Harry Potter, To Kill a Mockingbird.
-- 3. Create a Student table with: student_id (SERIAL), name (NOT NULL, UNIQUE), and age (must be ≤ 15).
-- 4. Insert the following students: John (12), Lera (11), Patrick (10), Bob (14).
-- 5. Create a Library table with: book_fk_id, student_fk_id, borrowed_date.
--    - Both foreign keys should have ON DELETE and ON UPDATE CASCADE.
--    - The composite of book_fk_id and student_fk_id is the primary key.
-- 6. Insert the following library borrow records using subqueries:
--    - John borrowed Alice In Wonderland on 15/02/2022
--    - Bob borrowed To Kill a Mockingbird on 03/03/2021
--    - Lera borrowed Alice In Wonderland on 23/05/2021
--    - Bob borrowed Harry Potter on 12/08/2021
-- 7. Display all records in the library table.
-- 8. Display the name of the student and title of the borrowed books.
-- 9. Display the average age of students who borrowed Alice In Wonderland.
-- 10. Delete a student and observe what happens in the Library table due to cascading delete.
DROP TABLE IF EXISTS "Book" CASCADE;
CREATE TABLE book(
book_id SERIAL PRIMARY KEY,
title VARCHAR (255) NOT NULL,
author VARCHAR (255) NOT NULL
);

INSERT INTO book(title, author)
VALUES
('Alice In Wonderland','Lewis Carroll'),
('Harry Potter','J.K Rowling'),
('To kill a mockingbird','Harper Lee');

CREATE TABLE Student(
student_id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL UNIQUE,
age INT CHECK (age <= 15)
);

INSERT INTO student(name, age)
VALUES
('John',12),
('Lera',11),
('Patrick',10),
('Bob',14);

CREATE TABLE library (
  book_fk_id INT REFERENCES book(book_id) ON DELETE CASCADE ON UPDATE CASCADE,
  student_fk_id INT REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE,
  borrowed_date DATE,
  PRIMARY KEY (book_fk_id, student_fk_id)
);

INSERT INTO library (book_fk_id, student_fk_id, borrowed_date)
VALUES
((SELECT book_id FROM book WHERE title = 'Alice In Wonderland'),
(SELECT student_id FROM student WHERE name = 'John'),
'2022-02-15'),
((SELECT book_id FROM book WHERE title = 'To kill a mockingbird'),
(SELECT student_id FROM student WHERE name = 'Bob'),
'2021-03-03'),
((SELECT book_id FROM book WHERE title = 'Alice In Wonderland'),
(SELECT student_id FROM student WHERE name = 'Lera'),
'2021-05-23'),
((SELECT book_id FROM book WHERE title = 'Harry Potter'),
(SELECT student_id FROM student WHERE name = 'Bob'),
'2021-08-12');

SELECT student.name, book.title
FROM library
JOIN student ON student.student_id = library.student_fk_id
JOIN book ON book.book_id = library.book_fk_id;

SELECT ROUND(AVG(student.age), 2)
FROM library
JOIN student ON student.student_id = library.student_fk_id
JOIN book ON book.book_id = library.book_fk_id
WHERE book.title = 'Alice In Wonderland';

DELETE FROM student WHERE name = 'Bob';

SELECT * FROM library;-- because of ON DELETE CASCADE deleting Bob from the student table automatically deleted his entries in the library table