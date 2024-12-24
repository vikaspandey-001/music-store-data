-- QUES 10: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the heighest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.

WITH most_selling_genre AS(
	SELECT i.billing_country AS country_name, g.name AS genre_name, COUNT(il.quantity) AS purchase, g.genre_id,
	ROW_NUMBER() OVER(PARTITION BY i.billing_country ORDER BY COUNT(il.quantity) DESC) AS rn
	FROM invoice i
	JOIN invoice_line il ON il.invoice_id = i.invoice_id
	JOIN track t ON t.track_id = il.track_id
	JOIN genre g ON g.genre_id = t.genre_id
	GROUP BY 1, 2, 4
)
SELECT msg.country_name, msg.genre_id, msg.genre_name, msg.purchase
FROM most_selling_genre msg
WHERE msg.rn=1;

-- We can also solve the question without using WITH clause just by using "SELECT * from"(.....(query) )"any_alias" "WHERE any_alias.column_name condition;"