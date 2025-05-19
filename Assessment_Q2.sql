 
-- Task: Calculate the average number of transactions per customer per month and  categorize them: 

-- To solve this task, I need to:
-- Count transactions per customer per month
-- Calculate the average transactions per month for each customer
-- Categorize customers based on their average transaction frequency

-- create a CTE (monthly transactions per customers)
with monthly_transactions as(
	SELECT 
    u.id as customer_id,
    DATE_FORMAT(s.created_on, '%Y-%m') AS month,
    COUNT(s.id) AS transaction_count
FROM
    users_customuser u
        JOIN
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY customer_id, month
),
-- create CTE for customer monthly avearage trasaction
customer_avg as (
    SELECT 
        customer_id,
        AVG(transaction_count) AS avg_transactions_per_month
    FROM 
        monthly_transactions
        GROUP BY customer_id
),
-- create CTE to segment customer monthly average trasaction   
categorized_customers AS (
SELECT 
    customer_id,
    avg_transactions_per_month,
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 2 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category
FROM 
    customer_avg
    )
SELECT 
    frequency_category,
    COUNT(*) AS customer_count, 
    round(avg(avg_transactions_per_month),2) as avg_transactions_per_month
FROM 
    categorized_customers
GROUP BY 
	frequency_category
ORDER BY 
    customer_count;