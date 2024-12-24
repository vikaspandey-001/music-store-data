-- QUES 11: Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent his amount.

WITH most_spent_customer AS(
	SELECT 
	    i.billing_country, 
	    c.customer_id, 
	    c.first_name, 
	    c.last_name, 
	    SUM(i.total),
	    ROW_NUMBER() OVER (PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS rn
	FROM customer c
	JOIN invoice i ON i.customer_id = c.customer_id
GROUP BY 1,2,3,4
)
SELECT * 
FROM most_spent_customer msc
WHERE rn=1;