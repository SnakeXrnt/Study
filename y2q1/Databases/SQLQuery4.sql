SELECT category.name, COUNT(film_category.film_id) AS film_count
FROM film_category
INNER JOIN category
ON (film_category.category_id=category.category_id)
WHERE COUNT(film_category.film_id) < 65
GROUP BY category.name
ORDER BY film_count 
