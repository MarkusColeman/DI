CREATE TABLE countries(
id SERIAL PRIMARY KEY,
name VARCHAR (100),
capital VARCHAR (100),
flag TEXT, --we use text because it can handle long URLs
subregion VARCHAR (100),
population BIGINT
);

SELECT * FROM countries;