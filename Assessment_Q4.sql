
-- Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction 
-- value, calculate:

SELECT
    u.id AS customer_id,
    concat(u.first_name,' ',u.last_name) as name,
    -- Tenure in months
    TIMESTAMPDIFF(MONTH, u.created_on, CURRENT_DATE) AS tenure_months,
    -- Total transaction value
    COALESCE(SUM(s.amount), 0) AS total_transactions,
    -- CLV formula
    ROUND(
        (COALESCE(SUM(s.amount), 0) * 0.012)
        / GREATEST(TIMESTAMPDIFF(MONTH, u.created_on, CURRENT_DATE), 1),
        2
    ) AS estimated_clv

FROM
    users_customuser u
LEFT JOIN
    savings_savingsaccount s ON u.id = s.owner_id
GROUP BY
    u.id, u.created_on
ORDER BY
    estimated_clv DESC;
