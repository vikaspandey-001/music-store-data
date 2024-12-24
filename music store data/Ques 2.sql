-- Ques 2: Which countries have the most invoices?
SELECT billing_country,
COUNT(*) as total_invoice
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC;