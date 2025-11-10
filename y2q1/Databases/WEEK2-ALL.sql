/* Ethan Bastian 560704*/

--1 Show the first name and last name of the staff together with the address of the store where they work.

SELECT first_name, last_name, store.address
FROM staff
INNER JOIN store
ON staff.store_id = store.store_id

--2. Give the first name and the last name of the staff that ever rented a movie to customer id 526. Eliminate duplicate results.

SELECT distinct customer_id , staff.first_name, staff.last_name
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
WHERE customer_id = 526

--3. Show the first name and last name of the customers in combination with the first name and last name of the staff who helped customers

SELECT customer.first_name AS customerfirstname, customer.last_name AS customerlastname,
staff.first_name AS stafffirstname, staff.last_name AS stafflastname
FROM customer
INNER JOIN rental 
ON rental.customer_id = customer.customer_id
INNER JOIN staff 
ON staff.staff_id = rental.staff_id

-- 4. Show all film titles and their category names. Order by category name and film name

SELECT title, category.name
FROM film 
INNER JOIN film_category
ON film_category.film_id = film.film_id
INNER JOIN category
ON category.category_id = film_category.category_id
ORDER BY category.name, film.title

--5. Show the first name and the last name of customers, and the movie titles of movies they have rented in the past. Sort the result by last name, first name, and movie title

SELECT customer.first_name, customer.last_name, film.title
FROM customer
INNER JOIN rental 
ON rental.customer_id = customer.customer_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film 
ON inventory.film_id = film.film_id
ORDER BY customer.last_name, customer.first_name, film.title

-- 6. Show the first name and last name of customers and the total amount of money they spent on renting movies. Order by this amount descending.

SELECT customer.first_name, customer.last_name , SUM(payment.amount) AS ammount
FROM customer 
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
ORDER BY SUM(payment.amount)

--7. Show which film titles are available per store. Show the film name, the address of the store , and the number of copies that the store has of the film. Order by film title ascending

SELECT film.title , store.address , COUNT(film.title) AS count
FROM film
INNER JOIN inventory 
ON inventory.film_id = film.film_id
INNER JOIN store
ON inventory.store_id = store.store_id
GROUP BY film.title, store.address
ORDER BY film.title ASC

-- 8. Show per movie title the number of actors in the movie. Order the result by the number of actors descending

SELECT film.title, COUNT(actor.actor_id)
FROM film
INNER JOIN film_actor 
ON film.film_id = film_actor.film_id
INNER JOIN actor 
ON film_actor.actor_id = actor.actor_id
GROUP BY film.title
ORDER BY COUNT(actor.actor_id)

-- 9. Give the top 10 of the most rented movies

SELECT TOP 10 film.title, COUNT(inventory.film_id)
from film
INNER JOIN inventory 
ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY COUNT(inventory.film_id) DESC


-- 10. Select all movies that have never been rented
SELECT film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
HAVING COUNT(inventory.film_id) = 0

--11. Select all titles of movies of which there are exactly 8 copies available in the inventory
SELECT film.title, COUNT(inventory.film_id)
FROM film 
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.title
HAVING COUNT(inventory.film_id) = 8

--12. Show all customers who have spent over 100 dollars on movies
SELECT customer.first_name, customer.last_name, SUM(payment.amount)
from customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name
HAVING SUM(payment.amount) > 100

--13. Show all customers who have rented a movie in the horror category.
SELECT customer.first_name, customer.last_name, category.name
from customer
INNER JOIN rental 
ON rental.customer_id = customer.customer_id 
INNER JOIN inventory 
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON film.film_id = inventory.inventory_id
INNER JOIN film_category 
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'horror'

--14. Show all customers that have more than one unreturned movie. Display per customer the first name, last name, and the amount of unreturned movies. Order the result by first name, last name

SELECT customer.first_name, customer.last_name, COUNT(rental.rental_id)
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
WHERE return_date IS NULL
GROUP BY customer.first_name, customer.last_name
HAVING COUNT(rental.rental_id) > 1 
ORDER BY customer.first_name, customer.last_name

--15. Given the 10 most rented movies, show the movies of which there are less than 9 pieces available in the inventory.

SELECT TOP 10 film.title, COUNT(rental.inventory_id)
FROM film 
INNER JOIN inventory
ON inventory.film_id = film.film_id
INNER JOIN rental 
ON rental.inventory_id = inventory.inventory_id
GROUP BY film.title
ORDER BY COUNT(inventory.inventory_id) DESC

--16. Show the amount of money that has been earned per store
SELECT store.address, SUM(payment.amount)
FROM store
INNER JOIN staff 
ON store.store_id = staff.store_id
INNER JOIN payment 
ON staff.staff_id = payment.staff_id
GROUP BY store.address

--17. Give the number of customers per store. Show the address of the store and the number of customers per store.


--18. Show all the first name and last name of the tables customer, actor, and staff and order by last name and first name.


--19. Show all the firstnames that occur in both the customer and actor table. Order alphabetically


--20. Show all the firstname of all the actors, which firstname does not occur in the customer table. Order alphabetically.


--21. Add yourself as a customer to the database


--22. Rent the movies 'Trip Newton' and 'Hardly Robbers' with your newly created account. Make sure that the return date is not set!


--23. Add a new movie to the database with the title 'Going Dutch' and come up with the other attributes

