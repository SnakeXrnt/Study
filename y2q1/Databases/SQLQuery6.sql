/*
NAME : Ethan Bastian
*/

/* EXCERSICE 2*/
-- 16 Show the total number of customers. Use total_customers as column name
SELECT COUNT(customer_id) AS total_customers
FROM customer;

-- 17 Show the total turnover of customer with id 148. Use turnover as column name.
SELECT customer_id, SUM(amount) AS 'turnover'

FROM payment
WHERE customer_id = 148
GROUP BY customer_id;

-- 18. Show the average duration of all films. Use average_duration as column name. Use round(X) in order to round to whole minutes.
SELECT ROUND(AVG(length),0,1)
AS average_duration
FROM dbo.film;

-- 19. Show the longest duration of all films. Use duration as column name. Can you use the title in your select statement? Why (not)?
SELECT MAX(length) AS 'duration'
FROM film;
/*it is what it is. because i mix aggregate func with non aggregate column. one solution is to use where*/
 
-- 19. fixtation 
SELECT length, title
FROM film
WHERE length = (
SELECT MAX(length)
FROM film
);

-- 20. Show the number of films per year of release. Show the year of release and the number of films. Use number_of_films as column name.
SELECT release_year, COUNT(film_id) AS number_of_films
FROM film
GROUP BY release_year
ORDER BY release_year DESC;

-- 21.  Show the total value of payments per customer. Show the customer_id and the corresponding total value of payments. Use turnover as column name. Sort by the total value of payments.
SELECT customer_id, ROUND(SUM(amount),0)
FROM payment
GROUP BY customer_id
ORDER BY ROUND(SUM(amount),0) DESC;

-- 22. Show the number of films per category where the category id is less than 10. Sort the result by the number of films
SELECT category.name, COUNT(film_category.film_id) AS film_count
FROM film_category
INNER JOIN category
ON (film_category.category_id=category.category_id)
WHERE COUNT(film_category.film_id) < 65
GROUP BY category.name
ORDER BY film_count 



-- 23. Show all rental transactions after ’1 January 2006
SELECT * 
FROM rental
WHERE rental_date > '1-01-2006'

-- 24. Show the rental_id and duration of the rental-period, of the movies rented out between ’5 July 2005 22:00’ and ‘5 July 2005 23:00’. Use ‘duration’ as column name, order by duration (descending)

SELECT rental_id, DATEDIFF(MINUTE, rental_date, return_date) AS duration , rental_date
FROM rental

WHERE rental_date BETWEEN '2005-07-05 22:00:00' AND '2005-07-05 23:00:00'
ORDER BY DATEDIFF(MINUTE, rental_date, return_date) DESC

-- 27. Show the total value of payments per month of the year 2007. Use period and turnover as column names, order by turnover (descending): What is the best-selling month? Use an SQL comment to add this answer to your SQL file
SELECT FORMAT( payment_date, 'yyyy-MM') AS month , ROUND(SUM(amount),0) as turnover

FROM payment
GROUP BY FORMAT( payment_date, 'yyyy-MM')
ORDER BY ROUND(SUM(amount),0) DESC