-- Exercise 2: DVD Rental


-- 1. Use UPDATE to change the language of some films.
--    Make sure that you use valid languages.
UPDATE film
SET language_id = 3
WHERE film_id IN (1,2,3);
-- 2. Which foreign keys (references) are defined for the customer table?
--    How does this affect the way in which we INSERT into the customer table?
SELECT * FROM information_schema.table_constraints WHERE table_name = 'customer';
--address_id is the only foregin key in the customer table. In order to add a customer their address must already exist or the database will reject it.
-- 3. We created a new table called customer_review.
--    Drop this table. Is this an easy step, or does it need extra checking?
DROP TABLE customer_review;-- Whether its easy to drop a table or not depends on whether there are dependencies in the table. Those have to reviewed and dropped first. In this case there wasn't so it was easy.

-- 4. Find out how many rentals are still outstanding (i.e., have not been returned to the store yet).
SELECT COUNT (*) FROM rental
WHERE return_date IS NULL;
-- 5. Find the 30 most expensive movies which are outstanding (i.e., have not been returned to the store yet).
SELECT film.title, film.replacement_cost
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL
ORDER BY film.replacement_cost DESC
LIMIT 30;
-- 6. Your friend is at the store and decides to rent a movie.
--    He knows he wants to see 4 movies, but he can’t remember their names. Can you help him find which movies he wants to rent?

 --Clue 1: The film is about a sumo wrestler, and one of the actors is Penelope Monroe.
SELECT film.title, film.description
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name ='Penelope' AND actor.last_name = 'Monroe'
AND (film.title ILIKE '%sumo%'OR film.description ILIKE '%sumo%');

--    Clue 2: A short documentary (less than 1 hour long), rated “R”.
SELECT film.title, film.description
FROM film
JOIN film_category ON film.film_id= film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Documentary'
AND film.length <= 60
AND film.rating = 'R';

--Clue 3: A film that his friend Matthew Mahan rented.
--           He paid over $4.00 for the rental, and he returned it between the 28th of July and the 1st of August, 2005.
SELECT film.title, film.description
FROM film
JOIN inventory on inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN customer ON customer.customer_id = rental.customer_id
WHERE customer.first_name ='Matthew' AND customer.last_name ='Mahan'
AND film.rental_rate > 4.00
AND rental.return_date BETWEEN '2005-07-28' AND '2005-08-01';

--    Clue 4: His friend Matthew Mahan watched this film, as well.
--           It had the word “boat” in the title or description, and it looked like it was a very expensive DVD to replace.
SELECT film.title, film.description, film.replacement_cost
FROM film
JOIN inventory on inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN customer ON customer.customer_id = rental.customer_id
WHERE customer.first_name ='Matthew' AND customer.last_name ='Mahan'
AND (film.title ILIKE '%boat%'OR film.description ILIKE '%boat%')
ORDER BY film.replacement_cost DESC
LIMIT 1;-- there are 4 films rented by the same person that meets the criteria. We're using ORDER BY, DESC, and Limit 1 to single out the most expensive since the instruction alludes to just one movie.

