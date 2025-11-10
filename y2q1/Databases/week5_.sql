-- ============================================================
-- GROUP 18 - LAB 5: DATABASE IMPLEMENTATION

-- LAB: Week 5 - Temporal Database
-- ============================================================
-- STEP 1: DROP DATABASE IF IT ALREADY EXISTS
USE master;

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DVDFilms')
BEGIN
    PRINT 'Dropping existing database DVDFilms...';
    DROP DATABASE DVDFilms;
END


-- STEP 2: CREATE DATABASE
CREATE DATABASE DVDFilms;



-- STEP 3: SET DATABASE CONTEXT
USE DVDFilms;


-- STEP 4: SHOW DATABASES
SELECT name, database_id, create_date
FROM sys.databases;


-- STEP 5: CREATE CATEGORY TABLE
CREATE TABLE dbo.category (
    category_id INT NOT NULL PRIMARY KEY,
    name VARCHAR(25) NOT NULL
);


-- STEP 6: INSERT SAMPLE DATA INTO CATEGORY
INSERT INTO dbo.category (category_id, name)
VALUES
(1, 'Action'), (2, 'Animation'), (3, 'Children'), (4, 'Classics'), (5, 'Comedy'),
(6, 'Documentary'), (7, 'Drama'), (8, 'Family'), (9, 'Foreign'), (10, 'Games'),
(11, 'Horror'), (12, 'Music'), (13, 'New'), (14, 'Sci-Fi'), (15, 'Sports'), (16, 'Travel');

SELECT * FROM dbo.category;


-- STEP 7: CREATE FILM TABLE
CREATE TABLE dbo.film (
    film_id INT NOT NULL PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    description TEXT NULL,
    release_year INT NULL,
    rental_duration SMALLINT NOT NULL DEFAULT 3,
    rental_rate NUMERIC(4,2) NOT NULL DEFAULT 4.99,
    length SMALLINT NULL,
    replacement_cost NUMERIC(5,2) NOT NULL DEFAULT 19.99,
    rating NVARCHAR(10) NOT NULL DEFAULT 'G',
    special_features NVARCHAR(255) NULL,
    full_text NVARCHAR(MAX) NULL
);


-- STEP 8: CREATE FILM_CATEGORY TABLE
CREATE TABLE dbo.film_category (
    film_id INT NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT pk_film_category PRIMARY KEY (film_id, category_id),
    CONSTRAINT fk_film FOREIGN KEY (film_id)
        REFERENCES dbo.film (film_id),
    CONSTRAINT fk_category FOREIGN KEY (category_id)
        REFERENCES dbo.category (category_id)
);
