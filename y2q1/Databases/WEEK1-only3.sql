/*
NAME : Ethan Bastian
*/

-- 18. Show the average duration of all films. Use average_duration as column name. Use round(X) in order to round to whole minutes.
SELECT ROUND(AVG(length),0,1)
AS average_duration
FROM dbo.film;

-- 22. Show the number of films per category where the category id is less than 10. Sort the result by the number of films
SELECT category.name, COUNT(film_category.film_id) AS film_count
FROM film_category
INNER JOIN category
ON (film_category.category_id=category.category_id)
WHERE COUNT(film_category.film_id) < 65
GROUP BY category.name
ORDER BY film_count 

-- 27. Show the total value of payments per month of the year 2007. Use period and turnover as column names, order by turnover (descending): What is the best-selling month? Use an SQL comment to add this answer to your SQL file
SELECT FORMAT( payment_date, 'yyyy-MM') AS month , ROUND(SUM(amount),0) as turnover

FROM payment
GROUP BY FORMAT( payment_date, 'yyyy-MM')
ORDER BY ROUND(SUM(amount),0) DESC