DROP TABLE IF EXISTS actors;

	CREATE TABLE actors (
	  actor_id SERIAL PRIMARY KEY,
	  first_name VARCHAR(50) NOT NULL,
	  last_name VARCHAR(100) NOT NULL,
	  age DATE NOT NULL,
	  number_oscars SMALLINT NOT NULL,
	   CONSTRAINT unique_actor_identity UNIQUE (first_name, last_name, age)
	);
	
	INSERT INTO actors (first_name, last_name, age, number_oscars) 
	VALUES('Matt', 'Damon', '1970-10-08', 5);
	
	INSERT INTO actors (first_name, last_name, age, number_oscars) 
	VALUES('George', 'Clooney', '1961-05-06', 2);
	
	INSERT INTO actors (first_name, last_name, age, number_oscars) 
	VALUES('Viola', 'Davis', '1965-08-11', 1);
	
	INSERT INTO actors (first_name, last_name, age, number_oscars) 
	VALUES('Zoe', 'Saldaña', '1978-06-19', 1);
	
	INSERT INTO actors (first_name, last_name, age, number_oscars) 
	VALUES 
	('Denzel', 'Washington', '1954-12-28', 2),
	('Alejandro', 'González Iñárritu', '1963-08-15', 5),
	('Meryl', 'Streep', '1949-06-22', 3);
	
	UPDATE actors SET first_name ='Maty' WHERE first_name='Matt' AND last_name='Damon'
	RETURNING *;
	
	UPDATE actors SET number_oscars ='4' WHERE first_name='George' AND last_name='Clooney'
	RETURNING *;
	
	ALTER TABLE actors RENAME COLUMN age TO birthdate;
	
	DELETE FROM actors WHERE actor_id = 7
	RETURNING *;

--DailyChallenge Actors--
	--1. Count how many actors are in the table.
	SELECT COUNT (*) FROM actors;
	--2. Try to add a new actor with some blank fields. What do you think the outcome will be ? 
	--You'll receive an error indicating that you have to include data in all of the required fields that were initially set up about the actor: ex:
	INSERT INTO actors(first_name, last_name) -- you need to include age, number_oscars (Null is not allowed)
	VALUES('Penelope','Cruz');
		
