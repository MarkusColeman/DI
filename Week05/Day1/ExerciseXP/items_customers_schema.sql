CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  price INTEGER
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);

INSERT INTO items (name, price) VALUES ('Small Desk', 100);

INSERT INTO items (name, price) VALUES ('Large Desk', 300);

INSERT INTO items (name, price) VALUES ('Fan', 80);

INSERT INTO customers (first_name, last_name) VALUES ('Greg', 'Jones');

INSERT INTO customers (first_name, last_name) VALUES ('Sandra', 'Jones');

INSERT INTO customers (first_name, last_name) VALUES ('Scott', 'Scott');

INSERT INTO customers (first_name, last_name) VALUES ('Trevor', 'Green');

INSERT INTO customers (first_name, last_name) VALUES ('Melanie', 'Johnson');