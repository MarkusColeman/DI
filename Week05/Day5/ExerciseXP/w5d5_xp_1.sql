

-- Exercise 1: DVD Rental
-- Instructions:
-- 1. Get a list of all the languages from the language table.
-- 2. Get a list of all films joined with their languages.
--    Select: film title, description, and language name.
-- 3. Get all languages, even if there are no films in those languages.
--    Select: film title, description, and language name.
-- 4. Create a new table called new_film with the following columns: id, name.
--    Add some new films to the table.
-- 5. Create a new table called customer_review to store film reviews.
--    If a film is deleted, its review should be automatically deleted (ON DELETE CASCADE).
--    Table columns:
--      - review_id – primary key, non-null, auto-increment.
--      - film_id – references new_film(id).
--      - language_id – references language(language_id).
--      - title – title of the review.
--      - score – rating of the review (1 to 10).
--      - review_text – the text of the review (no limit).
--      - last_update – when the review was last updated.
-- 6. Add 2 movie reviews linked to valid film and language entries.
-- 7. Delete a film that has a review and observe what happens to the customer_review table.



SELECT * FROM LANGUAGE;	

SELECT  title, description, name
FROM film
JOIN language ON film.language_id = language.language_id;

SELECT title, description, name
FROM LANGUAGE
LEFT JOIN film ON film.language_id = lANGUAGE.language_id;

CREATE TABLE new_film(
id SERIAL PRIMARY KEY,
name VARCHAR (50)
);

INSERT INTO new_film (name)
VALUES
('Black Panther'),
('The Revenant'),
('12 Years a NAME'),
('Django'),
('The Hateful Eight');

CREATE TABLE customer_review(
review_id SERIAL PRIMARY KEY,
film_id INT REFERENCES new_film (id) ON DELETE CASCADE,
language_id INT REFERENCES language(language_id),
title VARCHAR (255),
score INT CHECK(score >= 1 AND score <=10),
review_text TEXT,
last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP CHECK (last_update <= CURRENT_TIMESTAMP) -- restricting user from entering a future date
);

INSERT INTO customer_review (film_id, language_id, title, score, review_text)
VALUES
(1, 1, 'Unexpectedly Brilliant', 9, 'A deeply moving story that exceeded expectations.'),
(2, 1, 'Mediocre at Best', 5, 'Had potential but lacked action.');

DELETE FROM new_film WHERE id = 1; -- because of ON DELETE CASCADE when the film is deleted so will the review which prevents reviews in the database that have no films linked to them.


