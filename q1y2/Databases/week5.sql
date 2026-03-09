1> CREATE DATABASE DVDFilms;
2> GO
1> USE DVDFilms
2> GO

1> USE master
2> DROP DATABASE DVDFilms
3> GO

1> CREATE DATABASE DVDFilms
2> GO
1> USE DVDFilms
2> go
Changed database context to 'DVDFilms'.

1> SELECT name, database_id, create_date
2> FROM sys.databases
3> GO
name       database_id create_date            
---------- ----------- -----------------------
master               1 2003-04-08 09:13:36.390
tempdb               2 2025-10-03 07:56:14.663
model                3 2003-04-08 09:13:36.390
msdb                 4 2025-07-14 13:37:03.417
dvdrental            5 2025-09-13 12:16:48.230
DVDFilms             6 2025-10-03 08:11:47.817

CREATE TABLE category (
	category_id INTEGER NOT NULL PRIMARY KEY,
	name VARCHAR(25) NOT NULL,
)

CREATE TABLE film (
	film_id INT NOT NULL PRIMARY KEY,
	title VARCHAR(225),
	description TEXT,
	release_year INT,
	rental_duration SMALLINT,
	rental_rate NUMERIC(4,2),
	length SMALLINT,
	replacement_cost NUMERIC(5,2),
	rating nvarchar,
	special_feautures TEXT,
	full_text TEXT,
)

CREATE TABLE film_category (
	film_id int NOT NULL,
	category_id int NOT NULL,
	CONSTRAINT pk_film_category PRIMARY KEY (film_id, category_id),
	CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES dbo.film(film_id),
	CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES dbo.category(category_id),
)









