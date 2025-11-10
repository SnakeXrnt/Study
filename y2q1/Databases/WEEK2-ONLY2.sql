/* Ethan Bastian 560704*/

--14. Show all customers that have more than one unreturned movie. Display per customer the first name, last name, and the amount of unreturned movies. Order the result by first name, last name

SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id) AS amount
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
WHERE return_date IS NULL
GROUP BY customer.first_name, customer.last_name
HAVING COUNT(rental.rental_id) > 1 
ORDER BY customer.first_name, customer.last_name

-- SUBQUERY BELOW THIS LINE --
SELECT customer.first_name, customer.last_name,
    (
        SELECT COUNT(*)
        FROM rental
        WHERE rental.customer_id = customer.customer_id
          AND rental.return_date IS NULL
    ) amount
FROM customer
WHERE
    (
        SELECT COUNT(*)
        FROM rental
        WHERE rental.customer_id = customer.customer_id
          AND rental.return_date IS NULL
    ) > 1
ORDER BY customer.first_name, customer.last_name;


--15. Given the 10 most rented movies, show the movies of which there are less than 9 pieces available in the inventory.

SELECT TOP 10 film.title, COUNT(rental.inventory_id) AS rental_count
FROM film 
INNER JOIN inventory
ON inventory.film_id = film.film_id
INNER JOIN rental 
ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY COUNT(inventory.inventory_id) DESC

-- SUBQUERY VERSION BELOW --
SELECT TOP 10 film.title,
    (
        SELECT COUNT(*)
        FROM rental
        JOIN inventory
            ON rental.inventory_id = inventory.inventory_id
        WHERE inventory.film_id = film.film_id
    ) rental_count
FROM film
WHERE
    (
        SELECT COUNT(*)
        FROM inventory
        WHERE inventory.film_id = film.film_id
    ) < 9
ORDER BY rental_count DESC;

