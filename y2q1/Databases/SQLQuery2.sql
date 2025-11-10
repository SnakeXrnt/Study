SELECT FORMAT( payment_date, 'yyyy-MM') AS month , ROUND(SUM(amount),0) AS turnover

FROM payment
GROUP BY FORMAT( payment_date, 'yyyy-MM')
ORDER BY ROUND(SUM(amount),0) DESC;